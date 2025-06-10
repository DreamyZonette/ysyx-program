
VPATH = $(NPC_HOME)/vsrc
CPATH = $(NPC_HOME)/csrc
VSRCS := $(wildcard $(VPATH)/**/top.v)
CSRCS := $(wildcard $(CPATH)/**/*.cpp)
VFLAGS += -Wall --cc --exe -Ivsrc/**/ --build -j 0 --trace

all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."
	verilator  $(CSRCS) $(VSRCS) $(VFLAGS)
	
	
include ../Makefile

clean:
	rm -rf *.vcd obj_dir/

wave:sim
	./obj_dir/Vtop
	gtkwave wave.vcd
