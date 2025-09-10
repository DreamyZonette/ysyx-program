TOP_NAME = ysyxSoCFull
IMG ?= /home/long/ysyx-workbench/npc/demo/add-minirv-npc.bin
#IMG ?= 
ELF ?= $(IMG:.bin=.elf)
NEMU_SO := $(NEMU_HOME)/build/riscv32-nemu-interpreter-so

SOC_HOME := /home/long/ysyx-workbench/ysyxSoC/perip

WORK_DIR = $(shell pwd)
BUILD_DIR = $(WORK_DIR)/build
TEST ?=
TEST_OBJ = $(shell find $(VPATH) -name $(TEST).v)
VPATH = $(WORK_DIR)/vsrc
CPATH = $(WORK_DIR)/csrc
INC_PATH := $(WORK_DIR)/include $(INC_PATH)
INCLUDES = $(addprefix -I, $(INC_PATH))

VSRCS := $(shell find $(VPATH) -name *.v)
VSRCS += $(shell find $(SOC_HOME) -name *.v)
VSRCS += /home/long/ysyx-workbench/ysyxSoC/ready-to-run/D-stage/ysyxSoCFull.v
CSRCS := $(wildcard $(CPATH)/*.cpp)

CFLAGS ?= #-Wall 
CFLAGS += -CFLAGS "$(INCLUDES)" 
VFLAGS ?= --cc --exe -I$(VPATH) --build -j 0 --trace
VFLAGS += --top-module $(TOP_NAME) 
VFLAGS += --Mdir $(BUILD_DIR)/obj_dir 
VFLAGS += --timescale "1ns/1ns" --no-timing 
VFLAGS += -I$(SOC_HOME)/uart16550/rtl -I$(SOC_HOME)/spi/rtl
# LDFLAGS += -LDFLAGS -lreadline -LDFLAGS -ltinfo

VERILATOR = verilator

$(shell mkdir -p $(BUILD_DIR))

all:run wave

run:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	$(VERILATOR) $(CFLAGS) $(LDFLAGS) $(CSRCS) $(VSRCS) $(VFLAGS)
	
	
	
include ../Makefile

wave:
	gtkwave $(BUILD_DIR)/wave.vcd


PHONY: clean test

test:
	$(VERILATOR) --lint-only -Wall $(TEST_OBJ)
	$(VERILATOR) --cc -Wall --Mdir $(BUILD_DIR)/obj_dir $(TEST_OBJ)
	@echo PASS

clean:
	-rm -rf *.vcd $(BUILD_DIR)


