
IVERILOG := iverilog
TARGET = $(WORK_DIR)/simulation/build/iverilog-npc
TB_FILE ?= $(WORK_DIR)/simulation/npc_tb.v
OBJCOPY := riscv64-linux-gnu-objcopy
AM_HOME ?= /home/long/ysyx-workbench/abstract-machine
MAINARGS ?= test
MAINARGS_MAX_LEN ?= 64
MAINARGS_PLACEHOLDER ?= the_insert-arg_rule_in_Makefile_will_insert_mainargs_here
CPU_TEST_PATH := /home/long/ysyx-workbench/am-kernels/tests/cpu-tests/build/
IMAGE ?= dummy
# SIM_IMG ?= $(CPU_TEST_PATH)$(IMAGE)-riscv32e-npc.elf ## cputest
# SIM_IMG ?= /home/long/ysyx-workbench/am-kernels/tests/am-tests/build/amtest-riscv32e-npc.elf
SIM_IMG ?= /home/long/ysyx-workbench/am-kernels/benchmarks/microbench/build/microbench-riscv32e-npc.elf ## microbench
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
	@echo + OBJCOPY "->" $(SIM_BIN)
	@$(OBJCOPY) -S -O binary \
		--set-section-flags .bss=alloc,contents \
		--adjust-vma=-0x80000000 \
		$(SIM_IMG) $(SIM_BIN_TMP)
	@echo + INSERT-ARG $(MAINARGS)
	@python3 $(AM_HOME)/tools/insert-arg.py $(SIM_BIN_TMP) $(MAINARGS_MAX_LEN) $(MAINARGS_PLACEHOLDER) "$(MAINARGS)"
	@od -An -tx1 -v $(SIM_BIN_TMP) | sed 's/^[[:space:]]*//' > $(SIM_BIN)
	@rm -f $(SIM_BIN_TMP)

cleaniverilog:
	rm $(WORK_DIR)/simulation/build/*

.PHONY: iverilog cleaniverilog

