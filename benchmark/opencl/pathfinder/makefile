CXX = g++
DEBUGFLAGS = -g
# You will need to modify the following 2 lines
# by inserting the correct path to the OpenCL
# lib and inc directories.

OPENCL_DIR = /home/yenkai/AMD-APP-SDK-v2.5-RC2-lnx32
INC = $(OPENCL_DIR)/include/
LIB = /home/yenkai/multi2sim/lib/


CXXFLAGS = -I$(INC) -c $(DEBUGFLAGS)
LINKFLAGS = -L$(LIB) -lm2s-opencl

# link objects(binaries) together
a.out: main.o OpenCL.o
	$(CXX) $(LINKFLAGS) main.o OpenCL.o -o pathfinder

# compile main function file into object (binary)
main.o: main.cpp OpenCL.cpp kernels.cl
	$(CXX) $(CXXFLAGS) main.cpp OpenCL.cpp

clean:
	clear
	@rm -f pathfinder *.o *.out *~ *\#
