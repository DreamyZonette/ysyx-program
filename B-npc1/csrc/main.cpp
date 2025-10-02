#include <common.h>
#include <memory/paddr.h>
#include <cpu/cpu.h>

//函数申明
// extern word_t pmem_read(paddr_t addr, int len);
// extern void pmem_write(paddr_t addr, int len, word_t data);
extern void init_isa();
void init_monitor(int, char *[]);
void step_and_dump_wave();
void sdb_mainloop();
// void sim_run();
// void engine_start();

VerilatedContext* contextp;
#if CONFIG_WAVE
VerilatedVcdC* tfp;
#endif
Vysyx_25020042* top;


void sim_init(){
    contextp = new VerilatedContext;
    #if CONFIG_WAVE
    tfp = new VerilatedVcdC;
    #endif
    top = new Vysyx_25020042;
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
    top->reset_n = 0;
    step_and_dump_wave();
    top->clock = 1;
    step_and_dump_wave();
    top->reset_n = 1;
    top->clock = 0;
    step_and_dump_wave();
}

int main(int argc, char *argv[]){
    sim_init();
    
    init_monitor(argc, argv);

    npc_engine_start();
    
    sdb_mainloop();

    sim_exit();
    return 0;
}