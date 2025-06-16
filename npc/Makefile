all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."
	verilator -Wall ./csrc/*.cpp ./vsrc/top.v --cc --exe -Ivsrc/ --build -j 0 --trace
	
	
include ../Makefile

clean:
	rm -rf *.vcd obj_dir/

wave:sim
	./obj_dir/Vtop
	gtkwave wave.vcd
