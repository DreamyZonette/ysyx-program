
IVERILOG := iverilog
TARGET = $(WORK_DIR)/simulation/build/npc_tb
TB_FILE ?= $(WORK_DIR)/simulation/npc_tb.v
IVERILOG_FLAGS ?= -Wall -o $(TARGET) 

iverilog: $(TARGET)
	vvp $(TARGET)

$(TARGET): $(TB_FILE) $(VSRCS)
	@mkdir -p $(WORK_DIR)/simulation/build
	$(IVERILOG) $(IVERILOG_FLAGS) $^