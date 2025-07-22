#include <cpu/cpu.h>

void cpu_exec(uint64_t n){
    top->sys_clk ^= 1; top->eval();
        step_and_dump_wave();
        top->sys_clk ^= 1; top->eval();
        step_and_dump_wave();
}