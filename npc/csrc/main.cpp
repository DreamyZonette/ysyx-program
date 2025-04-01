#include "verilated.h"
#include "Vtop.h"
#include "verilated_vcd_c.h"

VerilatedContext* contextp;
VerilatedVcdC* tfp;

static Vtop* top;

void step_and_dump_wave(){
    top->eval();
    contextp->timeInc(1);   
    tfp->dump(contextp->time());
}

void single_cycle() {
  top->clk = 0; top->eval();
  step_and_dump_wave();
  top->clk = 1; top->eval();
  step_and_dump_wave();
}

void sim_init(){
    contextp = new VerilatedContext;
    tfp = new VerilatedVcdC;
    top = new Vtop;
    contextp->traceEverOn(true);
    top->trace(tfp,0);
    tfp->open("wave.vcd");
}

void sim_exit(){
    step_and_dump_wave();
    tfp->close();
}

int main(){
    sim_init();

   // int i = 10;
    while(1) {
        single_cycle();
        if(top->ebreak_signal == 1) break;
        //i--;
    }
    // top->x0 = 0;top->x1 = 1;top->x2 = 2;top->x3 = 3;top->sel = 0;step_and_dump_wave();
    // top->sel = 1;step_and_dump_wave();
    // top->sel = 2;step_and_dump_wave();
    // top->sel = 3;step_and_dump_wave();
    sim_exit();
}