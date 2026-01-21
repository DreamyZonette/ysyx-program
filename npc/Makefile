TOP_NAME = ysyxSoCFull
IMG ?= /home/long/ysyx-workbench/npc/demo/tests/char-test.bin
#IMG ?= 
ELF ?= $(IMG:.bin=.elf)
NEMU_SO := $(NEMU_HOME)/build/riscv32-nemu-interpreter-so

WORK_DIR = $(shell pwd)
BUILD_DIR = $(WORK_DIR)/build
TEST ?=
TEST_OBJ = $(shell find $(VPATH) -name $(TEST).v)
VPATH = $(WORK_DIR)/vsrc
CPATH = $(WORK_DIR)/csrc
SOC_HOME = /home/long/ysyx-workbench/ysyxSoC
INC_PATH := $(WORK_DIR)/include $(INC_PATH)
INCLUDES = $(addprefix -I, $(INC_PATH))

VSRCS := $(shell find $(VPATH) -name *.v)
VSRCS += $(shell find $(SOC_HOME)/perip -name *.v)
VSRCS += $(SOC_HOME)/build/ysyxSoCFull.v
CSRCS := $(wildcard $(CPATH)/*.cpp)
CSRCS += $(shell find $(CPATH) -name *.c)

CFLAGS :=  
CFLAGS += -CFLAGS "$(INCLUDES)" 
CFLAGS += -CFLAGS -fpermissive 
VFLAGS :=  --cc --exe --build -j 0 --trace  --autoflush
VFLAGS += -I$(VPATH) -I$(SOC_HOME)/perip/uart16550/rtl -I$(SOC_HOME)/perip/spi/rtl
VFLAGS += --top-module $(TOP_NAME) 
VFLAGS += --Mdir $(BUILD_DIR)/obj_dir 
VFLAGS += --timescale "1ns/1ns" --no-timing
LDFLAGS := -LDFLAGS "-lreadline -ltinfo -lSDL2"
# LDFLAGS += -LDFLAGS -lSDL2

VERILATOR = verilator
ARGS ?=  
ARGS += -l $(BUILD_DIR)/npc.log # 启用日志


CONFIG_FTRACE        := $(shell grep -m1 '^#define CONFIG_FTRACE' include/generated/autoconf.h | awk '{print $$3}')
CONFIG_DIFFTEST      := $(shell grep -m1 '^#define CONFIG_DIFFTEST' include/generated/autoconf.h | awk '{print $$3}')
CONFIG_WAVE          := $(shell grep -m1 '^#define CONFIG_WAVE' include/generated/autoconf.h | awk '{print $$3}')
CONFIG_ITRACE         := $(shell grep -m1 '^#define CONFIG_ITRACE' include/generated/autoconf.h | awk '{print $$3}')


ifneq ($(IMG),)
	ARGS += -i $(IMG)
endif

ifeq ($(IMG),)
	ifneq ($(OBJ),)
		# ARGS += -i $(NEW_OBJ_DIR)/new.bin
	endif
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

ifeq ($(CONFIG_ITRACE),1)
	CSRCS += $(WORK_DIR)/tools/disasm.c
	LIBCAPSTONE = $(NEMU_HOME)/tools/capstone/repo/libcapstone.so.5
	CFLAGS += -CFLAGS -I$(NEMU_HOME)/tools/capstone/repo/include
src/utils/disasm.c: $(LIBCAPSTONE)
$(LIBCAPSTONE):
	$(MAKE) -C $(NEMU_HOME)/tools/capstone
endif

$(shell mkdir -p $(BUILD_DIR))


all:run wave

$(BUILD_DIR)/wave.fst:
	-@vcd2fst $(BUILD_DIR)/wave.vcd $(BUILD_DIR)/wave.fst
	-@rm -f $(BUILD_DIR)/wave.vcd

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@$(VERILATOR) $(VFLAGS) $(CFLAGS) $(LDFLAGS) $(CSRCS) $(VSRCS) 
	
run:sim
	@echo "Start simulation"
	$(BUILD_DIR)/obj_dir/V$(TOP_NAME) $(ARGS)
	
	
include ../Makefile

wave: $(BUILD_DIR)/wave.fst
	
	gtkwave $(BUILD_DIR)/wave.fst
	rm $(BUILD_DIR)/wave.fst


PHONY: clean test adapt

adapt: sim
	$(MAKE) -C $(CPU_TEST_HOME) ARCH=minirv-npc ALL=$(OBJ)
	bash $(GEN) $(CPU_TEST_HOME)/$(OBJ)-minirv-npc.elf

gdb:sim
	@echo "Start gdb"
	gdb --args $(BUILD_DIR)/obj_dir/V$(TOP_NAME) $(ARGS)
	-@vcd2fst $(BUILD_DIR)/wave.vcd $(BUILD_DIR)/wave.fst
	-@rm -f $(BUILD_DIR)/wave.vcd

test:
	$(VERILATOR) --lint-only -Wall $(TEST_OBJ)
	$(VERILATOR) --cc -Wall --Mdir $(BUILD_DIR)/obj_dir $(TEST_OBJ)
	@echo PASS

clean:
	-rm -rf *.vcd $(BUILD_DIR)


