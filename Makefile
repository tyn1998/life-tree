SNAP_DIR = ../Snap-4.0
GLIB_CORE_DIR = $(SNAP_DIR)/glib-core
SNAP_CORE_DIR = $(SNAP_DIR)/snap-core
SNAP_ADV_DIR = $(NAP_DIR)/snap-adv
SNAP_EXP_DIR = $(NAP_DIR)/snap-exp

UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
	CXX = g++
	CXXFLAGS += -std=c++0x -Wall
	CXXFLAGS += -O3 -DNDEBUG -fopenmp
	LDFLAGS +=
	LIBS += -lrt -lm

else ifeq ($(UNAME), Darwin)
  # OS X flags
  CXX = g++-10
  CXXFLAGS += -std=c++11 -Wall -Wno-unknown-pragmas
  CXXFLAGS += -O3 -DNDEBUG
  CLANG := $(shell g++ -v 2>&1 | grep clang | cut -d " " -f 2)
  ifneq ($(CLANG), LLVM)
    CXXFLAGS += -fopenmp
    #CXXOPENMP += -fopenmp
  else
    CXXFLAGS += -DNOMP
    CXXOPENMP =
  endif
  LDFLAGS +=
  LIBS +=

endif

ANALYZE = analyze
GRAPHLET = graphlet

BIN_DIR := bin

all : $(addprefix $(BIN_DIR)/,$(ANALYZE) $(GRAPHLET) orca)

# COMPILE

$(BIN_DIR)/$(ANALYZE) : $(ANALYZE).cpp $(SNAP_CORE_DIR)/Snap.o | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $(BIN_DIR)/$(ANALYZE) \
		$(ANALYZE).cpp $(SNAP_CORE_DIR)/Snap.o \
		-I$(SNAP_CORE_DIR) -I$(SNAP_ADV_DIR) -I$(GLIB_CORE_DIR) -I$(SNAP_EXP_DIR) $(LDFLAGS) $(LIBS) \

$(BIN_DIR)/$(GRAPHLET) : $(GRAPHLET).cpp $(SNAP_CORE_DIR)/Snap.o | $(BIN_DIR) 
	$(CXX) $(CXXFLAGS) -o $(BIN_DIR)/$(GRAPHLET) $(GRAPHLET).cpp $(SNAP_CORE_DIR)/Snap.o \
		-I$(SNAP_CORE_DIR) -I$(SNAP_ADV_DIR) -I$(GLIB_CORE_DIR) -I$(SNAP_EXP_DIR) $(LDFLAGS) $(LIBS) \

$(SNAP_CORE_DIR)/Snap.o : 
	make -C $(SNAP_CORE_DIR)

$(BIN_DIR)/orca : orca.cpp | $(BIN_DIR)
	g++ -O2 -std=c++11 -o $(BIN_DIR)/orca orca.cpp

$(BIN_DIR) :
	mkdir $(BIN_DIR)

clean:
	rm -f *.o  $(ANALYZE) $(GRAPHLET)
