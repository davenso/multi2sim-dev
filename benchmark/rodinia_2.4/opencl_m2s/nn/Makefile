include ../../common_m2s/make.config

#C compiler
CC = g++

SRC = nearestNeighbor.cpp clutils.cpp utils.cpp

CC_FLAGS = -g -O3 -m32

EXE = nn

release:
	$(CC) $(CC_FLAGS) -lm2s-opencl  -fopenmp $(SRC) -o $(EXE) -I$(OPENCL_INC) -L$(OPENCL_LIB)
	m2c --amd --amd-device Tahiti nearestNeighbor_kernel.cl
clean: 
	rm -f $(EXE) nearestNeighbor_kernel.bin
