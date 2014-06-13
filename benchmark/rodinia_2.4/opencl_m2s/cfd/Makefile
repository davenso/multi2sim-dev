include ../../common_m2s/make.config
#C compiler
CC = g++

#OPENCL_DIR = /home/sc5nf/ati-stream-sdk-v2.2-lnx64/
#INC = $(OPENCL_DIR)/include/ 
#LIB = $(OPENCL_DIR)/lib/x86_64/

FLAGS = -O3 -m32
SRC = euler3d.cpp

EXE = euler3d

release:$(SRC)
	$(CC) $(SRC) -o $(EXE) -I$(OPENCL_INC) -L$(OPENCL_LIB) -lm2s-opencl $(FLAGS) 
	m2c --amd --amd-device Tahiti Kernels.cl 
errmsg:$(SRC)
	$(CC) $(SRC) -o $(EXE) -I$(OPENCL_INC) -L$(OPENCL_LIB) -lm2s-opencl -D ERRMSG $(FLAGS)

ptx:$(SRC)
	$(CC) $(SRC) -o $(EXE) -I$(OPENCL_INC) -L$(OPENCL_LIB)  -lm2s-opencl -D PTX_MSG $(FLAGS)

res:$(SRC)
	$(CC) $(SRC) -o $(EXE) -I$(OPENCL_INC) -L$(OPENCL_LIB)  -lm2s-opencl -D RES_MSG $(FLAGS)

clean: $(SRC)
	rm -f $(EXE) $(EXE).linkinfo result* ./*.bin
