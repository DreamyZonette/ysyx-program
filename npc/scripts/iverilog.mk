
IVERILOG := iverilog
TARGET = $(WORK_DIR)/simulation/build/npc_tb
TB_FILE ?= $(WORK_DIR)/simulation/npc_tb.v
OBJCOPY := riscv64-linux-gnu-objcopy
SIM_IMG ?= $(WORK_DIR)/simulation/source/microbench-riscv32e-npc.elf ## microbench
# SIM_IMG ?= $(WORK_DIR)/simulation/source/rtthread-riscv32e-npc.elf ## RTT
SIM_BIN_TMP := $(WORK_DIR)/simulation/build/iverilog_npc.tmp
SIM_BIN := $(WORK_DIR)/simulation/build/iverilog_npc.bin
EXCLUDE_FILES := \
    /home/long/ysyx-workbench/npc/vsrc/device/uart.v \
    /home/long/ysyx-workbench/npc/vsrc/crossbar.v
SIM_VSRCS := $(filter-out $(EXCLUDE_FILES), $(VSRCS))

IVERILOG_FLAGS ?= -Wall -o $(TARGET) 

iverilog: $(SIM_BIN) $(TARGET)
	vvp $(TARGET)

$(TARGET): $(TB_FILE) $(SIM_VSRCS)
	@mkdir -p $(WORK_DIR)/simulation/build
	$(IVERILOG) $(IVERILOG_FLAGS) $^

$(SIM_BIN): $(SIM_IMG)
	@mkdir -p $(WORK_DIR)/simulation/build
	$(OBJCOPY) -O verilog --adjust-vma=-0x80000000 --verilog-data-width=4 $(SIM_IMG) $(SIM_BIN_TMP)
	sed -E 's/([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})/\4\3\2\1/g' $(SIM_BIN_TMP) > $(SIM_BIN)

cleaniverilog:
	rm $(SIM_BIN) $(TARGET)

.PHONY: iverilog cleaniverilog

