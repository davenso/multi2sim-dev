CXX = g++
DEBUGFLAGS = -g
# You will need to modify the following 2 lines
# by inserting the correct path to the OpenCL
# lib and inc directories.

OPENCL_DIR = /home/yenkai/AMD-APP-SDK-v2.5-RC2-lnx32
INC = $(OPENCL_DIR)/include/
LIB = /home/yenkai/multi2sim/lib/

CXXFLAGS = -I$(INC) $(DEBUGFLAGS)
LINKFLAGS = -L$(LIB) -lm2s-opencl

ALLFLAGS = $(CXXFLAGS) $(LINKFLAGS)

all:
	$(CXX) $(ALLFLAGS) *.cpp -o srad

clean:
	clear
	@rm -f srad *.o *.out *~ *\#
