include ../../../common_m2s/make.config

INC = -I$(OPENCL_INC) -I../common
LIB = -L$(OPENCL_LIB)

#C compiler
CC = g++
CC_FLAGS = -g -O3 -Wall -m32

EXE = lud

$(EXE): lud.cpp
	$(CC) $(CC_FLAGS) -o $(EXE) lud.cpp ../common/common.c $(INC) $(LIB) -lm2s-opencl
	m2c --amd --amd-device Tahiti -O0 lud_kernel.cl
clean:
	rm -f $(EXE) lud_kernel.bin
