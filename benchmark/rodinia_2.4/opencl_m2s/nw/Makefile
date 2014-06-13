include ../../common_m2s/make.config

#C compiler
CC = g++

CC_FLAGS = -g -O3 -Wall -m32

EXE = nw

$(EXE): nw.c
	$(CC) $(CC_FLAGS) -o $(EXE) nw.c -I$(OPENCL_INC) -L$(OPENCL_LIB) -lm2s-opencl
	m2c --amd --amd-device Tahiti -O0 nw.cl
clean:
	rm -f $(EXE) nw.bin
