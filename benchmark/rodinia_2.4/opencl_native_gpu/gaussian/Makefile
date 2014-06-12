include ../../common/make.config

#C compiler
CC = g++

SRC = clutils.cpp gaussianElim.cpp utils.cpp

CC_FLAGS = -g -O3 -m32

EXE = gaussian

release:
	$(CC) $(CC_FLAGS) -lm2s-opencl  -fopenmp $(SRC) -o $(EXE) -I$(OPENCL_INC) -L$(OPENCL_LIB)
	
clean: 
	rm -f $(EXE) 
