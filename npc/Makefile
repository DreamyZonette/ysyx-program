WORK_DIR  = $(shell pwd)
BUILD_DIR = $(WORK_DIR)/build
INC_PATH := $(WORK_DIR)/include $(INC_PATH)
INCLUDES = $(addprefix -I, $(INC_PATH))
CFLAGS = -Wall $(INCLUDES)

all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."
	verilator $(CFLAGS) ./csrc/*.cpp ./vsrc/top.v --cc --exe -Ivsrc/ --build -j 0 --trace
	
	
include ../Makefile

clean:
	rm -rf *.vcd obj_dir/

wave:sim
	./obj_dir/Vtop
	gtkwave wave.vcd
