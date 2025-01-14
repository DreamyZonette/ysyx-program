sim:
	verilator -Wall *.cpp *.v --cc --exe --build -j 0 --trace
	./obj_dir/Vtop
	gtkwave *.vcd
