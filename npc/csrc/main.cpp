//#include <common.h>
#include "verilated.h"
#include "VysyxSoCFull.h"
#include "verilated_vcd_c.h"
#include "svdpi.h"
#include "VysyxSoCFull__Dpi.h"


extern "C" void flash_read(int32_t addr, int32_t *data) { assert(0); }
#define CONFIG_WAVE 1
VerilatedContext* contextp;
#if CONFIG_WAVE
VerilatedVcdC* tfp;
#endif
VysyxSoCFull* top;


void step_and_dump_wave(){
    top->eval();
    #if CONFIG_WAVE
    contextp->timeInc(1);   
    tfp->dump(contextp->time());
    #endif
}

void single_cycle() {
  top->clock ^= 1; top->eval();
  step_and_dump_wave();
  top->clock ^= 1; top->eval();
  step_and_dump_wave();
}


void sim_init(){
    contextp = new VerilatedContext;
    #if CONFIG_WAVE
    tfp = new VerilatedVcdC;
    #endif
    top = new VysyxSoCFull;
    #if CONFIG_WAVE
    contextp->traceEverOn(true);
    top->trace(tfp,0);
    tfp->open("/home/long/ysyx-workbench/npc/build/wave.vcd");
    #endif
}

void sim_exit(){
    step_and_dump_wave();
    #if CONFIG_WAVE
    tfp->close();
    #endif
}



void npc_engine_start() {
    top->clock = 0;
    top->reset = 1;
    step_and_dump_wave();
    top->clock = 1;
    step_and_dump_wave();
    top->reset = 0;
    top->clock = 0;
    step_and_dump_wave();
}

int main(int argc, char *argv[]){
    sim_init();
    int n = 10000
    while (n --){
        single_cycle();
    }

    sim_exit();
    return 0;
}