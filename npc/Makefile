all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."
	verilator -Wall *.cpp *.v --cc --exe --build -j 0 --trace
	./obj_dir/Vtop
	
include ../Makefile

clean:
	rm -rf *.vcd obj_dir/

wave:
	gtkwave *.vcd
