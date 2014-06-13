include ../../common_m2s/make.config
CXX = g++
DEBUGFLAGS = 
# You will need to modify the following 2 lines
# by inserting the correct path to the OpenCL
# lib and inc directories.
CXXFLAGS = -I$(OPENCL_INC) -c $(DEBUGFLAGS)
LINKFLAGS = -L$(OPENCL_LIB) -lm2s-opencl 

# link objects(binaries) together
a.out: main.o OpenCL.o
	$(CXX) main.o OpenCL.o $(LINKFLAGS) -o pathfinder -m32
	m2c --amd --amd-device Tahiti -O0 kernels.cl

# compile main function file into object (binary)
main.o: main.cpp OpenCL.cpp kernels.cl
	$(CXX) $(CXXFLAGS) main.cpp OpenCL.cpp -m32

clean:
	@rm -f pathfinder *.o *.out *~  kernels.bin
