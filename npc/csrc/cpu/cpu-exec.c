#include <cpu/cpu.h>

// 全局结束标志和 DPI-C 函数
bool sim_finish = false;
bool is_hit_good_trap = true;
extern "C" void dpi_ebreak() {
    is_hit_good_trap = false;
    sim_finish = true;  // 触发仿真结束
}
extern "C" void dpi_return() {
    sim_finish = true;  // 触发仿真结束
}

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
    while(n--){
        single_cycle();
    }
    
}

void sim_run(){
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
        //printf("%4d: pc:%08x    inst:%08x   halt:%d\n", count, top->de_pc, top->de_inst, top->halt);
        //single_cycle();
        cpu_exec(1);
        if(top->halt == 1) is_hit_good_trap = false;
    }
    if(is_hit_good_trap) printf("npc:%s at pc:0x%08x\n", ANSI_FMT("HIT GOOD TRAP", ANSI_FG_GREEN), top->de_pc);
    else printf("npc:%s at pc:0x%08x\n", ANSI_FMT("HIT BAD TRAP", ANSI_FG_RED), top->de_pc);
    
}