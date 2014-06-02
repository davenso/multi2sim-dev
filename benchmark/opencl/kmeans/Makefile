
# C compiler
CC = g++
CC_FLAGS = -g -O2 

OPENCL_DIR = /home/yenkai/multi2sim/
# OPENCL_DIR = /home/mwb7w/ati-stream-sdk-v2.2-lnx64/


INC = -I$(OPENCL_DIR)/runtime/include/                                                                                                                                    

LIB = -L$(OPENCL_DIR)/lib/

kmeans: cluster.o getopt.o read_input.o kmeans_clustering.o rmse.o
	$(CC) $(CC_FLAGS) -lm2s-opencl kmeans.cpp cluster.o getopt.o read_input.o kmeans_clustering.o rmse.o -o kmeans $(INC)

%.o: %.[ch]
	$(CC) $(CC_FLAGS) $< -c

cluster.o: cluster.c 
	$(CC) $(CC_FLAGS) cluster.c -c
	
getopt.o: getopt.c 
	$(CC) $(CC_FLAGS) getopt.c -c
	
kmeans.o: kmeans.c 
	$(CC) $(CC_FLAGS) read_input.c -c

rmse.o: rmse.c
	$(CC) $(CC_FLAGS) rmse.c -c

clean:
	rm -f *.o *~ kmeans *.linkinfo
