#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "verilated.h"
#include "Vtop.h"
#include <signal.h>
#include "verilated_vcd_c.h"

VerilatedContext* contextp;
Vtop* top;
VerilatedVcdC* tfp;

void handle_signal(int signum){
if (signum == SIGINT) {
     printf("Received interrupt signal, shutting down gracefully...\n");
     tfp->close();
     delete top;
     delete contextp;
     exit(0);
}	
}
int main(int argc,char** argv)
{

	contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vtop* top = new Vtop{contextp};
		
	contextp->traceEverOn(true); 
	tfp = new VerilatedVcdC;
	top->trace(tfp, 99);
	tfp->open("waveform.vcd");

	signal(SIGINT, handle_signal);

while (!contextp->gotFinish()) {
	  int a = rand() & 1;
	  int b = rand() & 1;
	  top->a = a;
	  top->b = b;
	  top->eval();
	  printf("a = %d, b = %d, f = %d\n", a, b, top->f);
		tfp->dump(contextp->time());
		contextp->timeInc(1);
	  assert(top->f == (a ^ b));
}


		tfp->close();
		delete(top);
		delete(contextp);
return 0;
}
