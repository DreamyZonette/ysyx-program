
IVERILOG := iverilog
TARGET = $(WORK_DIR)/simulation/build/iverilog-npc
TB_FILE ?= $(WORK_DIR)/simulation/npc_tb.v
OBJCOPY := riscv64-linux-gnu-objcopy
AM_HOME ?= /home/long/ysyx-workbench/abstract-machine
CPU_TEST_PATH := /home/long/ysyx-workbench/am-kernels/tests/cpu-tests/build/
IMAGE ?= recursion
SIM_IMG ?= $(CPU_TEST_PATH)$(IMAGE)-riscv32e-npc.elf ## cputest
# SIM_IMG ?= /home/long/ysyx-workbench/am-kernels/tests/am-tests/build/amtest-riscv32e-npc.bin
# SIM_IMG ?= /home/long/ysyx-workbench/am-kernels/benchmarks/microbench/build/microbench-riscv32e-npc.bin ## microbench
# SIM_IMG ?= $(WORK_DIR)/simulation/source/rtthread-riscv32e-npc.elf ## RTT 
SIM_BIN_TMP := $(WORK_DIR)/simulation/build/$(IMAGE)-iverilog.tmp
SIM_HEX := $(WORK_DIR)/simulation/build/iverilog_npc.hex
EXCLUDE_FILES := \
    /home/long/ysyx-workbench/npc/vsrc/device/uart.v \
    /home/long/ysyx-workbench/npc/vsrc/crossbar.v
SIM_VSRCS := $(filter-out $(EXCLUDE_FILES), $(VSRCS))

IVERILOG_FLAGS ?= -Wall -o $(TARGET) 

iwave: $(WORK_DIR)/simulation/build/npc_wave.vcd
	gtkwave $(WORK_DIR)/simulation/build/npc_wave.vcd

$(WORK_DIR)/simulation/build/npc_wave.vcd: iverilog

iverilog: $(SIM_HEX) $(TARGET)
	vvp $(TARGET)

$(TARGET): $(TB_FILE) $(SIM_VSRCS)
	@mkdir -p $(WORK_DIR)/simulation/build
	$(IVERILOG) $(IVERILOG_FLAGS) $^

$(SIM_HEX): $(SIM_IMG)
	@mkdir -p $(WORK_DIR)/simulation/build
	@echo + COPY "->" $(SIM_BIN_TMP)
	@cp $(SIM_IMG) $(SIM_BIN_TMP)
	@echo + OBJCOPY "->" $(SIM_HEX) "(verilog hex)"
	@$(OBJCOPY) -I binary -O verilog $(SIM_BIN_TMP) $(SIM_HEX)
	@rm -f $(SIM_BIN_TMP)

cleaniverilog:
	rm $(WORK_DIR)/simulation/build/*

.PHONY: iverilog cleaniverilog

