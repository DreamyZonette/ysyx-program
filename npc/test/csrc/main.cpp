//#include <stdio.h>
//#include <stdlib.h>
//#include <assert.h>
//#include "verilated.h"
#include <Vtop.h>
//#include "verilated_vcd_c.h"
#include <nvboard.h>
static TOP_NAME dut;

void nvboard_bind_all_pins(TOP_NAME* top);
/*static void single_cycle() {
	  dut.clk = 0; dut.eval();
	  dut.clk = 1; dut.eval();
}*/

int main(int argc,char** argv)
{
	nvboard_bind_all_pins(&dut);
	nvboard_init();

	/*VerilatedC ontext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vtop* top = new Vtop{contextp};

	VerilatedVcdC* tfp = new VerilatedVcdC;
	contextp->traceEverOn(true);
	top->trace(tfp, 9);
	tfp->open("wave.vcd");*/

	while(1){
		  nvboard_update();
			dut.eval();
} 

/* while (!contextp->gotFinish()) {
  int a = rand() & 1;
  int b = rand() & 1;
  top->a = a;
  top->b = b;
  top->eval();
  printf("a = %d, b = %d, f = %d\n", a, b, top->f);

	tfp->dump(contextp->time());
	contextp->timeInc(1);
  assert(top->f == (a ^ b));
} */ 

	//tfp->close();
	//delete( top);
	//delete (contextp);


return 0;
}
