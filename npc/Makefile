TOP_NAME = top
IMG ?= /home/long/ysyx-workbench/npc/add-minirv-npc.bin
#IMG ?= 
ELF ?= $(IMG:.bin=.elf)
NEMU_SO := $(NEMU_HOME)/build/riscv32-nemu-interpreter-so

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
CSRCS += $(wildcard $(CPATH)/monitor/sdb/*.c)

CFLAGS ?= -Wall 
CFLAGS +=  -CFLAGS "$(INCLUDES)" 
CFLAGS += -CFLAGS -fpermissive
VFLAGS ?= --cc --exe -I$(VPATH) --build -j 0 --trace
VFLAGS += --top-module $(TOP_NAME) 
VFLAGS += --Mdir $(BUILD_DIR)/obj_dir 
LDFLAGS += -LDFLAGS -lreadline -LDFLAGS -ltinfo
#LDFLAGS += -LDFLAGS -L$(dir $(NEMU_SO))
#LDFLAGS += -LDFLAGS -l:$(notdir $(NEMU_SO))
#LDFLAGS += -LDFLAGS "-Wl,-rpath,$(dir $(NEMU_SO))"

VERILATOR = verilator
ARGS ?= 
#ARGS += -d $(NEMU_SO) # 启用difftest
ARGS += -i $(IMG)     # 启用镜像文件
#ARGS += -e $(ELF)	  # 启用ftrace
ARGS += -b      	  # 启用批处理

$(shell mkdir -p $(BUILD_DIR))

all:run wave

run:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@$(VERILATOR) $(CFLAGS) $(LDFLAGS) $(CSRCS) $(VSRCS) $(VFLAGS)
	$(BUILD_DIR)/obj_dir/Vtop $(ARGS)
	
	
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


