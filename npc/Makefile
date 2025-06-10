
BUILD_DIR = $(NPC_HOME)/build
VPATH = $(NPC_HOME)/vsrc
CPATH = $(NPC_HOME)/csrc
VSRCS := $(wildcard $(VPATH)/**/*.v)
VSRCS += $(VPATH)/top.v
CSRCS := $(wildcard $(CPATH)/*.cpp)
CFLAGS ?= -Wall
VFLAGS += --cc --exe -I$(VPATH) --build -j 0 --trace
VFLAGS += --top-module top
VFLAGS += --Mdir $(BUILD_DIR)/obj_dir

$(shell mkdir -p $(BUILD_DIR))

all:sim wave
	#@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	#@echo "Write this Makefile by your self."
	verilator $(CFLAGS) $(CSRCS) $(VSRCS) $(VFLAGS)
	
	
include ../Makefile

wave:sim
	$(BUILD_DIR)/obj_dir/Vtop
	gtkwave $(BUILD_DIR)/wave.vcd

clean:
	rm -rf *.vcd $(BUILD_DIR)


