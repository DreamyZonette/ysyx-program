#include "verilated.h"
#include "Vtop.h"
#include "verilated_vcd_c.h"
#include "svdpi.h"
#include "Vtop__Dpi.h"

VerilatedContext* contextp;
VerilatedVcdC* tfp;
static Vtop* top;

// 全局结束标志和 DPI-C 函数
bool sim_finish = false;
extern "C" void dpi_ebreak() {
    sim_finish = true;  // 触发仿真结束
}

int is_ebreak(int ebreak_signal);

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
    while(!Verilated::gotFinish() && !sim_finish) {
        single_cycle();
    }
    printf("Simulation finished\n");
    sim_exit();
    return 0;
}