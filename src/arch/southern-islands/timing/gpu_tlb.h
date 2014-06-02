#ifndef GPU_TLB
#define GPU_TLB

struct gpu_tlb{ 
    unsigned int PASID;
    unsigned int VTL_addr;
    unsigned int PHY_addr;
};

#endif

