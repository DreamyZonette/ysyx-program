TOP_NAME = ysyxSoCFull
IMG ?= /home/long/ysyx-workbench/ysyxSoC/ready-to-run/D-stage/hello-minirv-ysyxsoc.bin
# IMG ?= 
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
CSRCS += $(shell find $(CPATH) -name *.c)

CFLAGS := 
CFLAGS += -CFLAGS "$(INCLUDES)" 
VFLAGS :=   --cc --exe -I$(VPATH) --build -j 0 --trace 
VFLAGS += --timescale "1ns/1ns" --no-timing  
VFLAGS += -Wno-ASSIGNDLY -Wno-UNUSEDSIGNAL -Wno-DECLFILENAME -Wno-PINCONNECTEMPTY # 忽略警告
VFLAGS += --top-module $(TOP_NAME) 
VFLAGS += --Mdir $(BUILD_DIR)/obj_dir 
VFLAGS += -I$(SOC_HOME)/uart16550/rtl/ -I$(SOC_HOME)/spi/rtl/
LDFLAGS := -LDFLAGS -lreadline -LDFLAGS -ltinfo
LDFLAGS += -LDFLAGS -lSDL2


VERILATOR = verilator
ARGS ?= 
ARGS += -l $(BUILD_DIR)/npc.log # 启用日志


CONFIG_FTRACE        := $(shell grep -m1 '^#define CONFIG_FTRACE' include/generated/autoconf.h | awk '{print $$3}')
CONFIG_DIFFTEST      := $(shell grep -m1 '^#define CONFIG_DIFFTEST' include/generated/autoconf.h | awk '{print $$3}')
CONFIG_WAVE          := $(shell grep -m1 '^#define CONFIG_WAVE' include/generated/autoconf.h | awk '{print $$3}')
ifneq ($(IMG),)
	ARGS += -i $(IMG)
endif

ifeq ($(MAKECMDGOALS),gdb)
  CFLAGS += -CFLAGS -g
endif

ifeq ($(CONFIG_FTRACE),1)
	ARGS += -e $(ELF)
endif

ifeq ($(CONFIG_DIFFTEST),1)
	LDFLAGS += -LDFLAGS -L$(dir $(NEMU_SO))
	LDFLAGS += -LDFLAGS -l:$(notdir $(NEMU_SO))
	LDFLAGS += -LDFLAGS "-Wl,-rpath,$(dir $(NEMU_SO))"
	ARGS += -d $(NEMU_SO)
endif

ifeq ($(BATCH),1)
	ARGS += -b 
endif

$(shell mkdir -p $(BUILD_DIR))



sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@$(VERILATOR) $(VFLAGS) $(CFLAGS) $(LDFLAGS) $(CSRCS) $(VSRCS) 
	
all:run wave

run:sim
	@echo "Start simulation"
	$(BUILD_DIR)/obj_dir/V$(TOP_NAME) $(ARGS)
	-vcd2fst $(BUILD_DIR)/wave.vcd $(BUILD_DIR)/wave.fst
	-rm -f $(BUILD_DIR)/wave.vcd
	
	
include ../Makefile

wave:
	
	gtkwave $(BUILD_DIR)/wave.fst


PHONY: clean test

gdb:sim
	@echo "Start gdb"
	gdb --args $(BUILD_DIR)/obj_dir/V$(TOP_NAME) $(ARGS)
	-vcd2fst $(BUILD_DIR)/wave.vcd $(BUILD_DIR)/wave.fst
	-rm -f $(BUILD_DIR)/wave.vcd

test:
	$(VERILATOR) --lint-only -Wall $(TEST_OBJ)
	$(VERILATOR) --cc -Wall --Mdir $(BUILD_DIR)/obj_dir $(TEST_OBJ)
	@echo PASS

clean:
	-rm -rf *.vcd $(BUILD_DIR)


