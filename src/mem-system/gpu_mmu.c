
/*
 *  Multi2Sim
 *  Copyright (C) 2012  Rafael Ubal (ubal@ece.neu.edu)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <assert.h>

#include <lib/mhandle/mhandle.h>
#include <lib/util/debug.h>
#include <lib/util/file.h>
#include <lib/util/list.h>
#include <lib/util/misc.h>

#include "gpu_mmu.h"


/*
 * Global variables
 */

char *gpu_mmu_report_file_name = "";

unsigned int gpu_mmu_page_size = 1 << 12;  /* 4KB default page size */
unsigned int gpu_mmu_log_page_size;
unsigned int gpu_mmu_page_mask;




/*
 * Private variables
 */

/* Local constants */
#define GPU_MMU_PAGE_HASH_SIZE  (1 << 10)
#define GPU_MMU_PAGE_LIST_SIZE  (1 << 10)

/* Physical memory page */
struct gpu_mmu_page_t
{
    struct gpu_mmu_page_t *next;

    int address_space_index;  /* Memory map ID */
    unsigned int vtl_addr;  /* Virtual address of page */
    unsigned int phy_addr;  /* Physical address */

    /* Statistics */
    long long num_read_accesses;
    long long num_write_accesses;
    long long num_execute_accesses;
};

/* Memory management unit */
struct gpu_mmu_t
{
    /* List of pages */
    struct list_t *page_list;

    /* Hash table of pages */
    struct gpu_mmu_page_t *page_hash_table[GPU_MMU_PAGE_HASH_SIZE];

    /* Report file */
    FILE *report_file;
};

static struct gpu_mmu_t *gpu_mmu;




/*
 * Private Functions
 */

static struct gpu_mmu_page_t *gpu_mmu_get_page(int address_space_index, unsigned int vtladdr)
{
    struct gpu_mmu_page_t *prev, *page;
    unsigned int tag;
    int index;

    /* Look for page */
    index = ((vtladdr >> gpu_mmu_log_page_size) + address_space_index * 23) % GPU_MMU_PAGE_HASH_SIZE;
    tag = vtladdr & ~gpu_mmu_page_mask;
    prev = NULL;
    page = gpu_mmu->page_hash_table[index];
    while (page)
    {
        if (page->vtl_addr == tag && page->address_space_index == address_space_index)
            break;
        prev = page;
        page = page->next;
    }
    //yk multi2sim handle page fault on x86
    /* Not found */
    if (!page)
    {
        /* Initialize */
        page = xcalloc(1, sizeof(struct gpu_mmu_page_t));
        page->vtl_addr = tag;
        page->address_space_index = address_space_index;
        page->phy_addr = list_count(gpu_mmu->page_list) << gpu_mmu_log_page_size;

        /* Insert in page list */
        list_add(gpu_mmu->page_list, page);

        /* Insert in page hash table */
        page->next = gpu_mmu->page_hash_table[index];
        gpu_mmu->page_hash_table[index] = page;
        prev = NULL;
    }

    /* Locate page at the head of the hash table for faster subsequent lookup */
    if (prev)
    {
        prev->next = page->next;
        page->next = gpu_mmu->page_hash_table[index];
        gpu_mmu->page_hash_table[index] = page;
    }

    /* Return it */
    return page;
}


/* Compare two pages */
static int gpu_mmu_page_compare(const void *ptr1, const void *ptr2)
{
    struct gpu_mmu_page_t *page1 = (struct gpu_mmu_page_t *) ptr1;
    struct gpu_mmu_page_t *page2 = (struct gpu_mmu_page_t *) ptr2;

    long long num_accesses1;
    long long num_accesses2;

    num_accesses1 = page1->num_read_accesses + page1->num_write_accesses
        + page1->num_execute_accesses;
    num_accesses2 = page2->num_read_accesses + page2->num_write_accesses
        + page2->num_execute_accesses;
    if (num_accesses1 < num_accesses2)
        return 1;
    else if (num_accesses1 == num_accesses2)
        return 0;
    else
        return -1;
}




/*
 * Public Functions
 */

void gpu_mmu_init()
{
    /* Variables derived from page size */
    gpu_mmu_log_page_size = log_base2(gpu_mmu_page_size);
    gpu_mmu_page_mask = gpu_mmu_page_size - 1;

    /* Initialize */
    gpu_mmu = xcalloc(1, sizeof(struct gpu_mmu_t));
    gpu_mmu->page_list = list_create_with_size(GPU_MMU_PAGE_LIST_SIZE);

    /* Open report file */
    if (*gpu_mmu_report_file_name)
    {
        gpu_mmu->report_file = file_open_for_write(gpu_mmu_report_file_name);
        if (!gpu_mmu->report_file)
            fatal("%s: cannot open report file for GPU_MMU", gpu_mmu_report_file_name);
    }
}


void gpu_mmu_done()
{
    int i;

    /* Dump report */
    gpu_mmu_dump_report();

    /* Free pages */
    for (i = 0; i < list_count(gpu_mmu->page_list); i++)
        free(list_get(gpu_mmu->page_list, i));
    list_free(gpu_mmu->page_list);

    /* Free GPU_MMU */
    free(gpu_mmu);
}


void gpu_mmu_dump_report(void)
{
    struct gpu_mmu_page_t *page;

    FILE *f;
    int i;

    long long num_accesses;

    /* Report file */
    f = gpu_mmu->report_file;
    if (!f)
        return;

    /* Sort list of pages it as per access count */
    list_sort(gpu_mmu->page_list, gpu_mmu_page_compare);

    /* Header */
    fprintf(f, "%5s %5s %9s %9s %10s %10s %10s %10s\n", "Idx", "MemID", "VtlAddr",
        "PhyAddr", "Accesses", "Read", "Write", "Exec");
    for (i = 0; i < 77; i++)
        fprintf(f, "-");
    fprintf(f, "\n");

    /* Dump */
    for (i = 0; i < list_count(gpu_mmu->page_list); i++)
    {
        page = list_get(gpu_mmu->page_list, i);
        num_accesses = page->num_read_accesses + page->num_write_accesses
            + page->num_execute_accesses;
        fprintf(f, "%5d %5d %9x %9x %10lld %10lld %10lld %10lld\n",
            i + 1, page->address_space_index, page->vtl_addr, page->phy_addr, num_accesses,
            page->num_read_accesses, page->num_write_accesses,
            page->num_execute_accesses);
    }
    fclose(f);
}


/* Obtain an identifier for a new virtual address space */
int gpu_mmu_address_space_new(void)
{
    static int gpu_mmu_address_space_index;

    return gpu_mmu_address_space_index++;
}


unsigned int gpu_mmu_translate(int address_space_index, unsigned int vtl_addr)
{
    struct gpu_mmu_page_t *page;

    unsigned int offset;
    unsigned int phy_addr;

    offset = vtl_addr & gpu_mmu_page_mask;
    page = gpu_mmu_get_page(address_space_index, vtl_addr);
    assert(page);
    phy_addr = page->phy_addr | offset;
    return phy_addr;
}


int gpu_mmu_valid_phy_addr(unsigned int phy_addr)
{
    int index;

    index = phy_addr >> gpu_mmu_log_page_size;
    return index < gpu_mmu->page_list->count;
}


void gpu_mmu_access_page(unsigned int phy_addr, enum gpu_mmu_access_t access)
{
    struct gpu_mmu_page_t *page;
    int index;

    /* Get page */
    index = phy_addr >> gpu_mmu_log_page_size;
    page = list_get(gpu_mmu->page_list, index);
    if (!page)
        return;

    /* Record access */
    switch (access)
    {
    case gpu_mmu_access_read:
        page->num_read_accesses++;
        break;

    case gpu_mmu_access_write:
        page->num_write_accesses++;
        break;

    case gpu_mmu_access_execute:
        page->num_execute_accesses++;
        break;

    default:
        panic("%s: invalid access", __FUNCTION__);
    }
}
