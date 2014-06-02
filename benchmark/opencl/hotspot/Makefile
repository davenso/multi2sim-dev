# OpenCL installation path      
OPENCL_DIR = /home/yenkai/multi2sim/
# OPENCL_DIR = /home/mwb7w/ati-stream-sdk-v2.2-lnx64/

CC = gcc
CC_FLAGS =  -O3 -Wall -m32

INC = -I$(OPENCL_DIR)/runtime/include/

LIB = -L$(OPENCL_DIR)/lib/

EXE = hotspot

$(EXE): hotspot.c hotspot.h OpenCL_helper_library.c OpenCL_helper_library.h
	$(CC) $(CC_FLAGS) -o $(EXE) $(INC) OpenCL_helper_library.c hotspot.c $(LIB) -lm2s-opencl

clean:
	rm -f $(EXE)
