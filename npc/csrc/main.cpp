#include "verilated.h"
#include "Vtop.h"
#include "verilated_vcd_c.h"
#include "svdpi.h"
#include "Vtop__Dpi.h"
#include <stdint.h>

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

static uint32_t pmem_read(uint32_t addr, int len) {
  uint32_t ret = host_read(guest_to_host(addr), len);
  return ret;
}

static long load_img() {
  if (img_file == NULL) {
    printf("No image is given. Use the default build-in image.");
    return 4096; // built-in image size
  }

  FILE *fp = fopen(img_file, "rb");
  Assert(fp, "Can not open '%s'", img_file);
  long size = 0;

  
    // BIN文件处理逻辑（保持不变）
    fseek(fp, 0, SEEK_END);
    size = ftell(fp);
    printf("The image is %s, size = %ld", img_file, size);
    fseek(fp, 0, SEEK_SET);
    ret = fread(guest_to_host(RESET_VECTOR), size, 1, fp);
    assert(ret == 1);
    fclose(fp);
  return size;
}

int is_ebreak(int ebreak_signal);

void step_and_dump_wave(){
    top->eval();
    contextp->timeInc(1);   
    tfp->dump(contextp->time());
}

// void single_cycle() {
//   top->clk = 0; top->eval();
//   step_and_dump_wave();
//   top->clk = 1; top->eval();
//   step_and_dump_wave();
// }

void sim_init(){
    contextp = new VerilatedContext;
    tfp = new VerilatedVcdC;
    top = new Vtop;
    contextp->traceEverOn(true);
    top->trace(tfp,0);
    tfp->open("wave.vcd");
}

void sim_exit(){
    step_and_dump_wave();
    tfp->close();
}

int main(){
    sim_init();
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