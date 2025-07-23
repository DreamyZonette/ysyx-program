#include <common.h>
#include <cpu/cpu.h>

#define PRINT_COUNT 4

// 全局结束标志和 DPI-C 函数
bool sim_finish = false;
bool is_hit_good_trap = true;
char p[128];
int print_on = 0;

extern "C" void dpi_ebreak() {
    // is_hit_good_trap = false;
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

static void trace_and_difftest() {
  #ifdef CONFIG_ITRACE
    snprintf(p, sizeof(p), "pc:%08x: %08x", top->de_pc, top->de_inst);
    printf("%s\n", p);
    p[0] = '\0';
  #else
  if(print_on){
    printf("pc:0x%08x    inst:0x%08x\n", 
      top->de_pc, top->de_inst);
  #endif
  
}

void single_cycle() {
  top->sys_clk ^= 1; top->eval();
  step_and_dump_wave();
  top->sys_clk ^= 1; top->eval();
  step_and_dump_wave();
 
}



static void execute(uint64_t n) {
    
  for (;n > 0; n --) {
    single_cycle();

    if(n <= PRINT_COUNT) print_on = 1;
    trace_and_difftest();

    if(sim_finish) {
        if(is_hit_good_trap)npc_state.state = NPC_END;
    }


    if(npc_state.halt_ret != 1) {
      npc_state.halt_pc = top->de_pc;
      npc_state.halt_ret = top->halt;
    }
    else {
        npc_state.state = NPC_ABORT;
    }
    // else{
    //     npc_state.state = NPC_STOP;
    // }
    if (npc_state.state != NPC_RUNNING) break;
  }
}

void cpu_exec(uint64_t n){
    if(sim_finish) npc_state.state = NPC_END;
    switch (npc_state.state) {
    case NPC_END: case NPC_ABORT: case NPC_QUIT:
      printf("Program execution has ended. To restart the program, exit NPC and run again.\n");
      return;
    default: npc_state.state = NPC_RUNNING;
  }

    execute(n);

    switch (npc_state.state) {
    case NPC_RUNNING: npc_state.state = NPC_STOP; break;

    case NPC_END: case NPC_ABORT:
      printf("npc: %s at pc = 0x%08x\n",
          (npc_state.state == NPC_ABORT ? ANSI_FMT("ABORT", ANSI_FG_RED) :
           (npc_state.halt_ret == 0 ? ANSI_FMT("HIT GOOD TRAP", ANSI_FG_GREEN) :
            ANSI_FMT("HIT BAD TRAP", ANSI_FG_RED))),
          npc_state.halt_pc);
      // fall through
    case NPC_QUIT: break;//statistic();
  }
}
