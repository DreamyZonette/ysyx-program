run:
	verilator --cc --exe --build -j 0 -Wall *.cpp *.v
	./obj_dir/Vtop

trace:
	verilator --cc --trace --exe --build -j 0 -Wall main.cpp top.v

wave:
	gtkwave *.vcd

clean:
	rm -rf obj_dir *.vcd

