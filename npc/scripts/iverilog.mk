
IVERILOG := iverilog
TARGET = $(WORK_DIR)/simulation/build/iverilog-npc
TB_FILE ?= $(WORK_DIR)/simulation/npc_tb.v
OBJCOPY := riscv64-linux-gnu-objcopy
CPU_TEST_PATH := /home/long/ysyx-workbench/am-kernels/tests/cpu-tests/build/
IMAGE ?= dummy
# SIM_IMG ?= $(CPU_TEST_PATH)$(IMAGE)-riscv32e-npc.elf ## cputest
SIM_IMG ?= $(WORK_DIR)/simulation/source/microbench-riscv32e-npc.elf ## microbench
# SIM_IMG ?= $(WORK_DIR)/simulation/source/rtthread-riscv32e-npc.elf ## RTT 
SIM_BIN_TMP := $(WORK_DIR)/simulation/build/$(IMAGE)-iverilog.tmp
SIM_BIN := $(WORK_DIR)/simulation/build/iverilog_npc.bin
EXCLUDE_FILES := \
    /home/long/ysyx-workbench/npc/vsrc/device/uart.v \
    /home/long/ysyx-workbench/npc/vsrc/crossbar.v
SIM_VSRCS := $(filter-out $(EXCLUDE_FILES), $(VSRCS))

IVERILOG_FLAGS ?= -Wall -o $(TARGET) 

iwave: $(WORK_DIR)/simulation/build/npc_wave.vcd
	gtkwave $(WORK_DIR)/simulation/build/npc_wave.vcd

$(WORK_DIR)/simulation/build/npc_wave.vcd: iverilog

iverilog: $(SIM_BIN) $(TARGET)
	vvp $(TARGET)

$(TARGET): $(TB_FILE) $(SIM_VSRCS)
	@mkdir -p $(WORK_DIR)/simulation/build
	$(IVERILOG) $(IVERILOG_FLAGS) $^

$(SIM_BIN): $(SIM_IMG)
	@mkdir -p $(WORK_DIR)/simulation/build
	$(OBJCOPY) -S -O verilog \
	-I elf32-littleriscv \
	--set-section-flags .bss=alloc,contents \
	--adjust-vma=-0x80000000 \
	$(SIM_IMG) $(SIM_BIN)

cleaniverilog:
	rm $(WORK_DIR)/simulation/build/*

.PHONY: iverilog cleaniverilog

