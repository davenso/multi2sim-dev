#ifndef GPU_MMU_H
#define GPU_MMU_H

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

void gpu_mmu_access_page(unsigned int phy_addr, enum mmu_access_t access);



#endif // GPU_MMU_H
