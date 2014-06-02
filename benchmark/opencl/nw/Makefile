OPENCL_DIR = /home/yenkai/multi2sim/
INC = -I$(OPENCL_DIR)/runtime/include/ 
LIB = -L$(OPENCL_DIR)/lib/
#C compiler
CC = g++
CC_FLAGS = -g -O2 -Wall

EXE = nw

$(EXE): nw.c
	$(CC) $(CC_FLAGS) -o $(EXE) nw.c $(INC) $(LIB) -lm2s-opencl

clean:
	rm -f $(EXE)
