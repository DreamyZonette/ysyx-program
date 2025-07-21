TOP_NAME = top
#IMG ?= /home/long/ysyx-workbench/am-kernels/tests/cpu-tests/build/dummy-riscv32e-npc.bin
IMG ?= 

WORK_DIR = $(shell pwd)
BUILD_DIR = $(WORK_DIR)/build
TEST ?=
TEST_OBJ = $(wildcard $(VPATH)/**/$(TEST).v)
TEST_OBJ += $(wildcard $(VPATH)/$(TEST)/*.v)
VPATH = $(WORK_DIR)/vsrc
CPATH = $(WORK_DIR)/csrc
INC_PATH := $(WORK_DIR)/include $(INC_PATH)
INCLUDES = $(addprefix -I, $(INC_PATH))
VSRCS := $(wildcard $(VPATH)/**/*.v)
VSRCS += $(VPATH)/top.v
CSRCS := $(wildcard $(CPATH)/*.cpp)
CSRCS += $(wildcard $(CPATH)/**/*.c)
CSRCS += $(wildcard $(CPATH)/**/*.h)
CFLAGS ?= -Wall
CFLAGS +=  -CFLAGS "$(INCLUDES)"
VFLAGS ?= --cc --exe -I$(VPATH) --build -j 0 --trace
VFLAGS += --top-module $(TOP_NAME)
VFLAGS += --Mdir $(BUILD_DIR)/obj_dir

$(shell mkdir -p $(BUILD_DIR))

all:sim wave

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	verilator $(CFLAGS) $(CSRCS) $(VSRCS) $(VFLAGS)
	$(BUILD_DIR)/obj_dir/Vtop -i $(IMG)
	
	
include ../Makefile

wave:sim
	gtkwave $(BUILD_DIR)/wave.vcd


PHONY: clean test

test:
	verilator --lint-only -Wall $(TEST_OBJ)
	verilator --cc -Wall --Mdir $(BUILD_DIR)/obj_dir $(TEST_OBJ)
	@echo PASS

clean:
	-rm -rf *.vcd $(BUILD_DIR)


