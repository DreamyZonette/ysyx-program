#include <common.h>
#include <memory/paddr.h>
#include <cpu/cpu.h>

//函数申明
// extern word_t pmem_read(paddr_t addr, int len);
// extern void pmem_write(paddr_t addr, int len, word_t data);
extern void init_isa();
void init_monitor(int, char *[]);
void step_and_dump_wave();
void sim_run();

VerilatedContext* contextp;
VerilatedVcdC* tfp;
Vtop* top;


void sim_init(){
    contextp = new VerilatedContext;
    tfp = new VerilatedVcdC;
    top = new Vtop;
    contextp->traceEverOn(true);
    top->trace(tfp,0);
    tfp->open("/home/long/ysyx-workbench/npc/build/wave.vcd");
}

void sim_exit(){
    step_and_dump_wave();
    tfp->close();
}

int main(int argc, char *argv[]){
    sim_init();
    init_monitor(argc, argv);

    

    

    printf("Simulation start\n");

    sim_run();

    printf("Simulation finished\n");
    //printf("0x%08x\n", pmem_read(0x80000010, 4));
    sim_exit();
    return 0;
}