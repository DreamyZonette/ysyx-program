sim:
	verilator -Wall *.cpp *.v --cc --exe --build -j 0 --trace
	./obj_dir/Vtop
clean:
	rm -rf *.vcd obj_dir/

wave:
	gtkwave *.vcd
