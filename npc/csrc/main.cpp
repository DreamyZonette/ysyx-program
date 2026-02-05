#include <common.h>
#include <memory/paddr.h>
#include <cpu/cpu.h>
#include <nvboard.h>

//函数申明
extern void init_isa();
void init_monitor(int, char *[]);
void step_and_dump_wave();
void sdb_mainloop();

VerilatedContext* contextp;
#if CONFIG_WAVE
VerilatedFstC* tfp;
#endif
VysyxSoCFull* top;

#if CONFIG_NVBOARD
void nvboard_bind_all_pins(VysyxSoCFull* top);
#endif

void sim_init(){
    contextp = new VerilatedContext;
    #if CONFIG_WAVE
    tfp = new VerilatedFstC;
    // tfp = new VerilatedVcdC;
    #endif
    top = new VysyxSoCFull;
    #if CONFIG_WAVE
    contextp->traceEverOn(true);
    top->trace(tfp,0);
    tfp->open("/home/long/ysyx-workbench/npc/build/wave.fst");
    #endif
    svSetScope(svGetScopeFromName("TOP.ysyxSoCFull.asic.cpu.cpu.IFU_u"));
    #if CONFIG_NVBOARD
        nvboard_bind_all_pins(top);
        nvboard_init();
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
    int n = 18;
    while (n--) {
        top->clock ^= 1;
        step_and_dump_wave();
    }
    top->reset = 0;
    top->clock = 0;
    step_and_dump_wave();
}

int main(int argc, char *argv[]){
    Verilated::commandArgs(argc, argv);
    sim_init();
    
    init_monitor(argc, argv);

    npc_engine_start();
    
    sdb_mainloop();

    sim_exit();
    return 0;
}