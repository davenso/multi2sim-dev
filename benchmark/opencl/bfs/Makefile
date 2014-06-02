OPENCL_DIR = /home/yenkai/AMD-APP-SDK-v2.5-RC2-lnx32

#C compiler
CC = g++

INCLUDE = $(OPENCL_DIR)/include
LIB = /home/yenkai/multi2sim/lib/

SRC = bfs.cpp timer.cc

CC_FLAGS = -g -O3

EXE = bfs

release:$(SRC)
	$(CC) $(CC_FLAGS) -lm2s-opencl  -fopenmp $(SRC) -o $(EXE) -I$(INCLUDE) -L$(LIB)

errmsg:$(SRC)
	$(CC) $(CC_FLAGS) -lm2s-opencl -fopenmp $(SRC) -o $(EXE) -I$(INCLUDE) -L$(LIB) -D ERRMSG PTX_MSG
	
ptx:$(SRC)
	$(CC) $(CC_FLAGS) -lm2s-opencl -fopenmp $(SRC) -o $(EXE) -I$(INCLUDE) -L$(LIB) -D PTX_MSG

profile:$(SRC)
	$(CC) $(CC_FLAGS) -lm2s-opencl -fopenmp $(SRC) -o $(EXE) -I$(INCLUDE) -L$(LIB) -D PROFILING
	
res:$(SRC)
	$(CC) $(CC_FLAGS) -lm2s-opencl -fopenmp $(SRC) -o $(EXE) -I$(INCLUDE) -L$(LIB) -D RES_MSG
	
debug: $(SRC)
	$(CC) $(CC_FLAGS) -lm2s-opencl $(SRC) -o $(EXE) -I$(INCLUDE) -L$(LIB)
	
run:
	./$(EXE)
	
clean: $(SRC)
	rm -f $(EXE) $(EXE).linkinfo result*
