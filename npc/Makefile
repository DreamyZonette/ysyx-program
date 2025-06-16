TOP_NAME = top
BUILD_DIR = $(NPC_HOME)/build
TEST ?=
TEST_OBJ = $(wildcard $(VPATH)/**/$(TEST).v)
VPATH = $(NPC_HOME)/vsrc
CPATH = $(NPC_HOME)/csrc
VSRCS := $(wildcard $(VPATH)/**/*.v)
VSRCS += $(VPATH)/top.v
CSRCS := $(wildcard $(CPATH)/*.cpp)
CFLAGS ?= -Wall
VFLAGS += --cc --exe -I$(VPATH) --build -j 0 --trace
VFLAGS += --top-module $(TOP_NAME)
VFLAGS += --Mdir $(BUILD_DIR)/obj_dir

$(shell mkdir -p $(BUILD_DIR))

all:sim wave

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	verilator $(CFLAGS) $(CSRCS) $(VSRCS) $(VFLAGS)
	
	
include ../Makefile

wave:sim
	$(BUILD_DIR)/obj_dir/Vtop
	gtkwave $(BUILD_DIR)/wave.vcd


PHONY: clean test

test:
	verilator --lint-only -Wall $(TEST_OBJ)
	verilator --cc -Wall --Mdir $(BUILD_DIR)/obj_dir $(TEST_OBJ)
	@echo PASS

clean:
	-rm -rf *.vcd $(BUILD_DIR)


