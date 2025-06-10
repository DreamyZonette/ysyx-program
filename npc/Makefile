
BUILD_DIR = $(NPC_HOME)/build
VPATH = $(NPC_HOME)/vsrc
CPATH = $(NPC_HOME)/csrc
VSRCS := $(wildcard $(VPATH)/**/*.v)
CSRCS := $(wildcard $(CPATH)/*.cpp)
CFLAGS ?= -Wall
VFLAGS += --cc --exe -I$(VPATH) --build -j 0 --trace
VFLAGS += --top-module top
VFLAGS += --Mdir $(BUILD_DIR)/obj_dir


all:sim wave
	#@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	#@echo "Write this Makefile by your self."
	verilator $(CFLAGS) $(CSRCS) $(VSRCS) $(VFLAGS)
	
	
include ../Makefile

clean:
	rm -rf *.vcd $(BUILD_DIR)

wave:sim
	$(BUILD_DIR)/obj_dir/Vtop
	gtkwave wave.vcd
