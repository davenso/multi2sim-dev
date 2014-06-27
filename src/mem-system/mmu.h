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

#ifndef MEM_SYSTEM_MMU_H
#define MEM_SYSTEM_MMU_H


enum mmu_access_t
{
	mmu_access_invalid = 0,
	mmu_access_read,
	mmu_access_write,
	mmu_access_execute
};

extern char *mmu_report_file_name;

extern unsigned int mmu_page_size;
extern unsigned int mmu_page_mask;
extern unsigned int mmu_log_page_size;

void mmu_init(void);
void mmu_done(void);
void mmu_dump_report(void);

//yk: address_space_new start from 0, and increase in order
int mmu_address_space_new(void);
//yk: call translate to get physical address.
//yk: If the page doesn't exist, create the one for it
unsigned int mmu_translate(int address_space_index, unsigned int vtl_addr);
int mmu_valid_phy_addr(unsigned int phy_addr);

void mmu_access_page(unsigned int phy_addr, enum mmu_access_t access);



enum gpu_mmu_access_t
{
    gpu_mmu_access_invalid = 0,
    gpu_mmu_access_read,
    gpu_mmu_access_write,
    gpu_mmu_access_execute
};

extern char *gpu_mmu_report_file_name;

extern unsigned int gpu_mmu_page_size;
extern unsigned int gpu_mmu_page_mask;
extern unsigned int gpu_mmu_log_page_size;

void gpu_mmu_init(void);
void gpu_mmu_done(void);
void gpu_mmu_dump_report(void);

//yk: address_space_new start from 0, and increase in order
int gpu_mmu_address_space_new(void);
//yk: call translate to get physical address.
//yk: If the page doesn't exist, create the one for it
//yk: The physical address is assigned also from 0x0, increase in page size
//yk: When a memory load/store access happens, m2s first check wheather the page has been translated.
//yk: If it is not translated, then assign the physical address for it and create the mapping relation.
unsigned int gpu_mmu_translate(int address_space_index, unsigned int vtl_addr);
int gpu_mmu_valid_phy_addr(unsigned int phy_addr);

void gpu_mmu_access_page(unsigned int phy_addr, enum gpu_mmu_access_t access);

unsigned int gpu_mmu_get_pte_addr(unsigned int, unsigned int);
unsigned int gpu_mmu_get_pde_addr(int,unsigned int);
unsigned int gpu_mmu_translate_32bit_pagewalk(int, unsigned int, unsigned int ,int);

#define PDE_MODE  0
#define PTE_MODE  1

#define PDE_MASK      0xFFC00000
#define PTE_MASK      0x003FF000
#define OFFSET_MASK   0x00000FFF

#define PDE_SHIFT  22
#define PTE_SHIFT  12

#define PAGE_ENTRY_NUM  1024
#endif

