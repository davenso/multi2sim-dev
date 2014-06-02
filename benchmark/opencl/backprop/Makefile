OPENCL_DIR = /home/yenkai/multi2sim/
INC = -I$(OPENCL_DIR)/runtime/include/ 
LIB = -L$(OPENCL_DIR)/lib/
# C compiler
CC = g++
CC_FLAGS = -g -O2 

backprop: backprop.o imagenet.o facetrain.o
	$(CC) $(CC_FLAGS) -lm2s-opencl backprop_ocl.cpp backprop.o imagenet.o facetrain.o -o backprop $(INC) $(LIB)

%.o: %.[ch]
	$(CC) $(CC_FLAGS) $< -c
	
backprop.o: backprop.c 
	$(CC) $(CC_FLAGS) backprop.c -c
	
facetrain.o: facetrain.c
	$(CC) $(CC_FLAGS) facetrain.c -c

imagenet.o: imagenet.c
	$(CC) $(CC_FLAGS) imagenet.c -c

clean:
	rm -f *.o *~ backprop *.linkinfo
