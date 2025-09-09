#include <common.h>




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
    while (1){
        single_cycle()
    }

    sim_exit();
    return 0;
}