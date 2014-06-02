################################################################################
#
# OpenCL Nearest Neighbor
#
################################################################################
#
# This will build for MacOS X as well as for Linux x86_64
# If the environment variable ATISTREAMSDKROOT is defined, then the
# application will be linked with the ATI SDK; otherwise, it will be linked
# with the NVIDIA SDK.
#
################################################################################

# Add source files here
EXECUTABLE	:= nearestNeighbor
SRCDIR		:= src/
CCFILES		:= nearestNeighbor.cpp clutils.cpp
C_DEPS		:= nearestNeighbor.h clutils.h
INCDIR		:= inc/

################################################################################
# Rules and targets

.SUFFIXES : .cl

# detect OS
OSUPPER = $(shell uname -s 2>/dev/null | tr [:lower:] [:upper:])
OSLOWER = $(shell uname -s 2>/dev/null | tr [:upper:] [:lower:])
# 'linux' is output for Linux system, 'darwin' for OS X
DARWIN = $(strip $(findstring DARWIN, $(OSUPPER)))
ifneq ($(DARWIN),)
   SNOWLEOPARD = $(strip $(findstring 10.6, $(shell egrep "<string>10\.6" /System/Library/CoreServices/SystemVersion.plist)))
   ROOTDIR := /Developer/GPU\ Computing
endif

ifdef ATISTREAMSDKROOT
   ROOTDIR := $(ATISTREAMSDKROOT)
   SHAREDDIR := $(ATISTREAMSDKROOT)
   OCLCOMMONDIR := $(ATISTREAMSDKROOT)
endif


# detect if 32 bit or 64 bit system
HP_64 =	$(shell uname -m | grep 64)
OSARCH= $(shell uname -m)

# Basic directory setup for SDK
# (override directories only if they are not already defined)
SRCDIR     ?= 
ROOTDIR    ?= $(HOME)/NVIDIA_GPU_Computing_SDK
ROOTOBJDIR ?= obj
LIBDIR     ?= $(ROOTDIR)/shared/lib/
SHAREDDIR  ?= $(ROOTDIR)/shared/
OCLROOTDIR ?= $(ROOTDIR)/OpenCL/
OCLCOMMONDIR ?=/home/yenkai/multi2sim
OCLBINDIR ?= ./bin/
BINDIR     ?= $(OCLBINDIR)/$(OSLOWER)
OCLLIBDIR     := $(OCLCOMMONDIR)/lib
INCDIR	?= .

# Compilers
CXX        := g++
CC         := gcc
LINK       := g++ -fPIC

# Includes
INCLUDES  += -I$(INCDIR) -I$(OCLCOMMONDIR)/runtime/include -I$(SHAREDDIR)/inc -I$(SHAREDDIR)/include

	MACHINE := 32
	USRLIBDIR := -L/usr/lib/


# Warning flags
CXXWARN_FLAGS := \
	-W -Wall \
	-Wimplicit \
	-Wswitch \
	-Wformat \
	-Wchar-subscripts \
	-Wparentheses \
	-Wmultichar \
	-Wtrigraphs \
	-Wpointer-arith \
	-Wcast-align \
	-Wreturn-type \
	-Wno-unused-function \
	$(SPACE)

CWARN_FLAGS := $(CXXWARN_FLAGS) \
	-Wstrict-prototypes \
	-Wmissing-prototypes \
	-Wmissing-declarations \
	-Wnested-externs \
	-Wmain \


        LIB_ARCH         = i386
            CXX_ARCH_FLAGS += -m32

# Compiler-specific flags
CXXFLAGS  := $(CXXWARN_FLAGS) $(CXX_ARCH_FLAGS)
CFLAGS    := $(CWARN_FLAGS) $(CXX_ARCH_FLAGS)
LINK      += $(CXX_ARCH_FLAGS)

# Common flags
COMMONFLAGS += $(INCLUDES) -DUNIX

# Add Mac Flags
ifneq ($(DARWIN),)
	COMMONFLAGS += -DMAC
endif

# Debug/release configuration
ifeq ($(dbg),1)
	COMMONFLAGS += -g
	BINSUBDIR   := debug
	LIBSUFFIX   := D
else 
	COMMONFLAGS += -O3 
	BINSUBDIR   := release
	LIBSUFFIX   :=
	CXXFLAGS    += -fno-strict-aliasing
	CFLAGS      += -fno-strict-aliasing
endif


# Libs
ifneq ($(DARWIN),)
   LIB       := -L${OCLLIBDIR} -L$(LIBDIR) -L$(SHAREDDIR)/lib/$(OSLOWER) 
   LIB += -framework OpenCL -framework AppKit ${ATF} ${LIB} 
else
   LIB       := ${USRLIBDIR} -L${OCLLIBDIR} -L$(LIBDIR) -L$(SHAREDDIR)/lib/$(OSLOWER) 
   LIB += -lm2s-opencl ${LIB}
   LIB += -L${OCLLIBDIR}/$(OSARCH)
endif


# Lib/exe configuration
ifneq ($(STATIC_LIB),)
	TARGETDIR := $(OCLLIBDIR)
	TARGET   := $(subst .a,_$(LIB_ARCH)$(LIBSUFFIX).a,$(OCLLIBDIR)/$(STATIC_LIB))
	LINKLINE  = ar qv $(TARGET) $(OBJS) 
else
	TARGETDIR := $(BINDIR)/$(BINSUBDIR)
	TARGET    := $(TARGETDIR)/$(EXECUTABLE)
	LINKLINE  = $(LINK) -o $(TARGET) $(OBJS) $(LIB)
endif

# check if verbose 
ifeq ($(verbose), 1)
	VERBOSE :=
else
	VERBOSE := @
endif

# Add common flags
CXXFLAGS  += $(COMMONFLAGS)
CFLAGS    += $(COMMONFLAGS)


################################################################################
# Set up object files
################################################################################
OBJDIR := $(ROOTOBJDIR)/$(BINSUBDIR)
OBJS +=  $(patsubst %.cpp,$(OBJDIR)/%.cpp.o,$(notdir $(CCFILES)))
OBJS +=  $(patsubst %.c,$(OBJDIR)/%.c.o,$(notdir $(CFILES)))

################################################################################
# Rules
################################################################################
$(OBJDIR)/%.c.o : $(SRCDIR)%.c $(INCDIR)%.h
	$(VERBOSE)$(CC) $(CFLAGS) -o $@ -c $<

$(OBJDIR)/%.cpp.o : $(SRCDIR)%.cpp $(INCDIR)%.h
	$(VERBOSE)$(CXX) $(CXXFLAGS) -o $@ -c $<

$(TARGET): makedirectories $(OBJS) Makefile
	$(VERBOSE)$(LINKLINE)
	@cp data/filelist.txt $(TARGETDIR)
	@cp data/cane4_0.db $(TARGETDIR)
	@cp data/cane4_1.db $(TARGETDIR)
	@cp data/cane4_2.db $(TARGETDIR)
	@cp data/cane4_3.db $(TARGETDIR)
	@cp src/nearestNeighbor_kernel.cl $(TARGETDIR)

makedirectories:
	$(VERBOSE)mkdir -p $(LIBDIR)
	$(VERBOSE)mkdir -p $(OBJDIR)
	$(VERBOSE)mkdir -p $(TARGETDIR)


tidy :
	$(VERBOSE)find . | egrep "#" | xargs rm -f
	$(VERBOSE)find . | egrep "\~" | xargs rm -f

clean : tidy
	$(VERBOSE)rm -f $(OBJS)
	$(VERBOSE)rm -f $(TARGET)

clobber : clean
	$(VERBOSE)rm -rf $(ROOTOBJDIR)
	$(VERBOSE)find $(TARGETDIR) | egrep "ptx" | xargs rm -f
	$(VERBOSE)find $(TARGETDIR) | egrep "txt" | xargs rm -f
	$(VERBOSE)rm -f $(TARGETDIR)/samples.list
