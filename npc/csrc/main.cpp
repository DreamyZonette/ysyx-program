#include "verilated.h"
#include "Vtop.h"
#include "verilated_vcd_c.h"
#include "svdpi.h"
#include "Vtop__Dpi.h"
#include <cassert>
#include <cstdint>
#include <cstdio>

#define CONFIG_MBASE 0x80000000
#define CONFIG_MSIZE 0x8000000
#define PG_ALIGN __attribute((aligned(4096)))
#define RESET_VECTOR (PMEM_LEFT + CONFIG_PC_RESET_OFFSET)
#define PMEM_LEFT  ((uint32_t)CONFIG_MBASE)
#define CONFIG_PC_RESET_OFFSET 0x0

VerilatedContext* contextp;
VerilatedVcdC* tfp;
static Vtop* top;

// 全局结束标志和 DPI-C 函数
bool sim_finish = false;
extern "C" void dpi_ebreak() {
    sim_finish = true;  // 触发仿真结束
}

static uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};

static inline uint32_t host_read(void *addr, int len) {
  switch (len) {
    case 1: return *(uint8_t  *)addr;
    case 2: return *(uint16_t *)addr;
    case 4: return *(uint32_t *)addr;
    default: assert(0);
  }
}

uint8_t* guest_to_host(uint32_t paddr) { return pmem + paddr - CONFIG_MBASE; }

static inline void host_write(void *addr, int len, uint32_t data) {
  switch (len) {
    case 1: *(uint8_t  *)addr = data; return;
    case 2: *(uint16_t *)addr = data; return;
    case 4: *(uint32_t *)addr = data; return;
    default: assert(0);
  }
}

static uint32_t pmem_read(uint32_t addr, int len) {
  uint32_t ret = host_read(guest_to_host(addr), len);
  return ret;
}

static void pmem_write(uint32_t addr, int len, uint32_t data) {
  host_write(guest_to_host(addr), len, data);
}

int is_ebreak(int ebreak_signal);

void step_and_dump_wave(){
    top->eval();
    contextp->timeInc(1);   
    tfp->dump(contextp->time());
}



void sim_init(){
    contextp = new VerilatedContext;
    tfp = new VerilatedVcdC;
    top = new Vtop;
    contextp->traceEverOn(true);
    top->trace(tfp,0);
    tfp->open("wave.vcd");
}

void isa_init(){
    uint32_t addi_instruction = 0x00050193; // addi x10, x0, 5
    pmem_write(CONFIG_MBASE, 4, addi_instruction);
    // 写入 ebreak 指令以便停止仿真
    uint32_t ebreak_instruction = 0x00100073; // ebreak
    pmem_write(CONFIG_MBASE + 4, 4, ebreak_instruction);
}

void sim_exit(){
    step_and_dump_wave();
    tfp->close();
}

int main(){
    printf("1\n");
    sim_init();
    printf("2\n");
    //isa_init();
    while(!sim_finish) {
        top->clk ^= 1; 
        top->inst = pmem_read(top->o_pc, 4);
        top->eval();
        step_and_dump_wave();
    }
    printf("Simulation finished\n");
    sim_exit();
    return 0;
}