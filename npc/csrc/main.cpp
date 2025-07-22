#include <common.h>
#include <memory/paddr.h>
#include <cpu/cpu.h>

//函数申明
// extern word_t pmem_read(paddr_t addr, int len);
// extern void pmem_write(paddr_t addr, int len, word_t data);
extern void init_isa();
void init_monitor(int, char *[]);

VerilatedContext* contextp;
VerilatedVcdC* tfp;
Vtop* top;

// 全局结束标志和 DPI-C 函数
bool sim_finish = false;
bool is_hit_good_trap = true;
extern "C" void dpi_ebreak() {
    sim_finish = true;  // 触发仿真结束
}
extern "C" void dpi_return() {
    sim_finish = true;  // 触发仿真结束
}

int is_ebreak(int ebreak_signal);

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

    int count = 0;

    

    printf("Simulation start\n");
    top->sys_rst_n = 0;
    top->sys_clk = 0;
    step_and_dump_wave();
    top->sys_clk = 1;
    step_and_dump_wave();
    top->sys_rst_n = 1;
    // top->sys_clk = 0;
    // step_and_dump_wave();
    // top->sys_clk = 1;
    step_and_dump_wave();
    while(!sim_finish && count <= 20) {
        count ++;
        printf("%4d: pc:%08x    inst:%08x   halt:%d\n", count, top->de_pc, top->de_inst, top->halt);
        // top->sys_clk ^= 1; top->eval();
        // step_and_dump_wave();
        // top->sys_clk ^= 1; top->eval();
        // step_and_dump_wave();
        single_cycle();
        //cpu_exec(1);
        if(top->halt == 1) is_hit_good_trap = false;
    }
    printf("Simulation finished\n");
    //printf("0x%08x\n", pmem_read(0x80000010, 4));
    sim_exit();
    return 0;
}