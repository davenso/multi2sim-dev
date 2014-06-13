include ../../common_m2s/make.config
# C compiler
CC = g++
CC_FLAGS = -g -O2 -m32

kmeans: cluster.o getopt.o read_input.o kmeans_clustering.o rmse.o
	$(CC) $(CC_FLAGS) -lm2s-opencl kmeans.cpp cluster.o getopt.o read_input.o kmeans_clustering.o rmse.o -o kmeans -I$(OPENCL_INC) -I$(OPENCL_DIR)/shared/inc/ -L$(OPENCL_LIB)
	m2c --amd --amd-device Tahiti kmeans.cl
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
	rm -f *.o *~ kmeans *.linkinfo ./*.bin
