include ../../common_m2s/make.config

#C compiler
CC = g++

SRC = clutils.cpp gaussianElim.cpp utils.cpp

CC_FLAGS = -g -O3 -m32

EXE = gaussian

release:
	$(CC) $(CC_FLAGS) -lm2s-opencl  -fopenmp $(SRC) -o $(EXE) -I$(OPENCL_INC) -L$(OPENCL_LIB)
	m2c --amd --amd-device Tahiti gaussianElim_kernels.cl
clean: 
	rm -f $(EXE)  gaussianElim_kernels.bin 
