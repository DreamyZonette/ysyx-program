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
VysyxSoCFull* top;


void sim_init(){
    contextp = new VerilatedContext;
    #if CONFIG_WAVE
    tfp = new VerilatedVcdC;
    #endif
    top = new VysyxSoCFull;
    #if CONFIG_WAVE
    contextp->traceEverOn(true);
    top->trace(tfp,0);
    tfp->open("/home/long/ysyx-workbench/soc-npc/build/wave.vcd");
    #endif
    svSetScope(svGetScopeFromName("TOP.ysyxSoCFull.gpr_u"));
}

void sim_exit(){
    step_and_dump_wave();
    #if CONFIG_WAVE
    tfp->close();
    #endif
}



void npc_engine_start(){
     
    printf("Start npc engine\n");
    top->clock = 0;
    top->reset = 1;
    step_and_dump_wave();
    int n = 9;
    while (n--) {
        top->clock = 1;
        step_and_dump_wave();
        top->clock = 0;
        step_and_dump_wave();
    }
    top->clock = 1;
    step_and_dump_wave();
    top->reset = 0;
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
