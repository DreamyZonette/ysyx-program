#include <common.h>
#include <cpu/cpu.h>
#include <isa/isa_def.h>
#include <cpu/difftest.h>


#define PRINT_COUNT 4
#if CONFIG_FTRACE
#include "/home/long/ysyx-workbench/npc/csrc/monitor/elf_reader.h"
  int count = 0;
#endif

// 全局结束标志和 DPI-C 函数
bool sim_finish = false;
char p[128];
int print_on = 0;
CPU_state dut = {
  .gpr = {0},            // 所有寄存器初始化为0
  .pc = 0x80000000       // PC初始化为0x80000000
};

extern "C" void dpi_ebreak() {
    sim_finish = true;  // 触发仿真结束
}
extern "C" void dpi_return() {
    sim_finish = true;  // 触发仿真结束
}

void step_and_dump_wave(){
    top->eval();
    #if CONFIG_WAVE
    contextp->timeInc(1);   
    tfp->dump(contextp->time());
    #endif
}

static void trace_and_difftest() {

  #if CONFIG_DIFFTEST
  for(int i = 0; i < 32; i++){
    dut.gpr[i] = top->reg_data[i];
  }
  dut.pc = top->de_pc;
  //printf("0x%08x 0x%08x\n", top->de_pc, top->de_next_pc);
  difftest_step(top->de_pc, top->de_next_pc);
  #endif

  #if CONFIG_FTRACE
  int is_call = 0;
  int is_ret = 0;

  uint32_t opcode = top->de_inst & 0x7F;
  uint32_t rd = (top->de_inst) >> 7 & 0x1F;
  uint32_t rs1 = (top->de_inst) >> 15 & 0x1F;
 

  if ((opcode == 0x6F && rd == 1) ||  // JAL rd=x1
      (opcode == 0x67 && rd == 1)) {  // JALR rd=x1
    is_call = 1;
  }
  if (opcode == 0x67 && rs1 == 1 && rd == 0) {
    is_ret = 1;
  }
  
  //int ret = decode_exec(s);
  char blank [40];
  int j = 0;
  if (is_call) {
    count += 2;
    for(j = 0; j < count; j ++){
      blank[j] = ' ';
    }
    blank[count] = '\0';
    for(int i = 0; i < functab_count; i ++){
      if(functab[i].value == top->de_next_pc){
        //log_write("0x%08x:%s call [%s@0x%08x]", top->de_pc, blank, functab[i].func_name, functab[i].value);
        printf("0x%08x:%s call [%s@0x%08x]\n", top->de_pc, blank, functab[i].func_name, functab[i].value);
        break;
      }
    }
  }
  else if (is_ret) {
    count -= 2;
    for(j = 0; j < count; j ++){
      blank[j] = ' ';
    }
    blank[count] = '\0';
    printf("0x%08x:%s ret [0x%08x]\n", top->de_pc, blank, top->reg_data[1]);
    //log_write("0x%08x:%s ret [0x%08x]\n", top->de_pc, blank, top->reg_data[1]);
  }
  
  //return ret;
#endif
}

void single_cycle() {
  top->sys_clk = 0; top->eval();
  step_and_dump_wave();
  top->sys_clk = 1; top->eval();
  step_and_dump_wave();
}

static void statistic() {
//   IFNDEF(CONFIG_TARGET_AM, setlocale(LC_NUMERIC, ""));
// #define NUMBERIC_FMT MUXDEF(CONFIG_TARGET_AM, "%", "%'") PRIu64
//   Log("host time spent = " NUMBERIC_FMT " us", g_timer);
//   Log("total guest instructions = " NUMBERIC_FMT, g_nr_guest_inst);
//   if (g_timer > 0) Log("simulation frequency = " NUMBERIC_FMT " inst/s", g_nr_guest_inst * 1000000 / g_timer);
//   else Log("Finish running in less than 1 us and can not calculate the simulation frequency");

if(npc_state.state == NPC_ABORT) assert(0);
}

void assert_fail_msg() {
#ifdef CONFIG_IRINGBUF
  print_iringbuf(cpu.pc);
#else
  isa_reg_display();
#endif
  statistic();
}

static void execute(uint64_t n) {
    if(n <= PRINT_COUNT) print_on = 1;
  for (;n > 0; n --) {
    #if CONFIG_ITRACE
  if(!sim_finish){
    snprintf(p, sizeof(p), "pc:%08x: %08x", top->de_pc, top->de_inst);
    printf("%s\n", p);
    p[0] = '\0';
  }
  #else
  if(!sim_finish){
    if(print_on){
      print_on = 0;
      printf("pc:0x%08x    inst:0x%08x\n", 
        top->de_pc, top->de_inst);
    }
  }
  #endif

    trace_and_difftest();
    single_cycle();

    if(sim_finish) {
      npc_state.halt_pc = top->de_pc;
      npc_state.halt_ret = top->reg_data[10]; // 寄存器返回值
      npc_state.state = NPC_END;
    }
    if(top->halt == 1){
      npc_state.halt_pc = top->de_pc;
      npc_state.halt_ret = top->reg_data[10];
      npc_state.state = NPC_ABORT;
    }

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
      Log("npc: %s at pc = 0x%08x",
          (npc_state.state == NPC_ABORT ? ANSI_FMT("ABORT", ANSI_FG_RED) :
           (npc_state.halt_ret == 0 ? ANSI_FMT("HIT GOOD TRAP", ANSI_FG_GREEN) :
            ANSI_FMT("HIT BAD TRAP", ANSI_FG_RED))),
          npc_state.halt_pc);
      // fall through
    case NPC_QUIT: statistic();
  }
}
