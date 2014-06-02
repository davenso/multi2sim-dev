CC = g++

OPENCL_DIR = /home/yenkai/AMD-APP-SDK-v2.5-RC2-lnx32
INC = $(OPENCL_DIR)/include/
LIB = /home/yenkai/multi2sim/lib/

FLAGS = -g
SRC = euler3d.cpp

EXE = euler3d

release:$(SRC)
	$(CC) -lm2s-opencl  $(SRC) -o $(EXE) -I$(INC) -L$(LIB)	$(FLAGS) 

errmsg:$(SRC)
	$(CC) -lm2s-opencl $(SRC) -o $(EXE) -I$(INC) -L$(LIB) -D ERRMSG $(FLAGS)
	
ptx:$(SRC)
	$(CC) -lm2s-opencl $(SRC) -o $(EXE) -I$(INC) -L$(LIB) -D PTX_MSG $(FLAGS)
	
res:$(SRC)
	$(CC) -lm2s-opencl $(SRC) -o $(EXE) -I$(INC) -L$(LIB) -D RES_MSG $(FLAGS)
	
clean: $(SRC)
	rm -f $(EXE) $(EXE).linkinfo result*
