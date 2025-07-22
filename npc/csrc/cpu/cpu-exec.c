#include <cpu/cpu.h>

void step_and_dump_wave(){
    top->eval();
    contextp->timeInc(1);   
    tfp->dump(contextp->time());
}

void single_cycle() {
  top->sys_clk ^= 1; top->eval();
  step_and_dump_wave();
  top->sys_clk ^= 1; top->eval();
  step_and_dump_wave();
}

void cpu_exec(uint64_t n){
    for(uint64_t i=0; i<n; i++){
        single_cycle()
    }
}