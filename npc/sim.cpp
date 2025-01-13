#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "verilated.h"
#include "Vtop.h"
#include "include/nvboard.h"

static TOP_NAME dut;

void nvboard_bind_all_pins(TOP_NAME* top);

static void single_cycle() { 
	dut.clk = 0; dut.eval();
	dut.clk = 1; dut.eval(); 
}

int main(int argc,char** argv)
{
	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vtop* top = new Vtop{contextp};

	nvboard_bind_all_pins(&dut);
	nvboard_init();

while ((!contextp->gotFinish()) {
  int a = rand() & 1;
  int b = rand() & 1;
  top->a = a;
  top->b = b;
  top->eval();
  printf("a = %d, b = %d, f = %d\n", a, b, top->f);
  assert(top->f == (a ^ b));
}

delete top;
delete contextp;

while(1){
	nvboard_update();
	single_cycle();
	}

return 0;
}
