
VPATH = $(NPC_HOME)/vsrc
CPATH = $(NPC_HOME)/csrc
VSRCS := $(wildcard $(VPATH)/**/*.v)
CSRCS := $(wildcard $(CPATH)/**/*.cpp)
VFLAGS += -Wall --cc --exe -I$(VPATH) --build -j 0 --trace

#BUILD_DIR = $(NPC_HOME)/build

all:sim
	#@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	#@echo "Write this Makefile by your self."
	verilator $(VFLAGS) $(CSRCS) $(VSRCS) 
	
	
include ../Makefile

clean:
	rm -rf *.vcd obj_dir/

wave:sim
	./obj_dir/Vtop
	gtkwave wave.vcd
