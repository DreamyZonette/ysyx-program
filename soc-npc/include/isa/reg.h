#ifndef __RISCV_REG_H__
#define __RISCV_REG_H__

#include <common.h>

// extern VerilatedContext* contextp;
// extern VerilatedVcdC* tfp;
// extern Vysyx_25020042* top;

static inline int check_reg_idx(int idx) {
  assert(idx >= 0 && idx < 16);
  return idx;
}


extern "C" {

// DPI 函数声明
unsigned int get_register_value(int idx);

}

// #define gpr(idx) (TOP->ysyxSoCFull->asic->cpu->cpu->gpr_u->reg_file[check_reg_idx(idx)])
#define gpr(idx) (get_register_value(check_reg_idx(idx)))

static inline const char* reg_name(int idx) {
  extern const char* regs[];
  return regs[check_reg_idx(idx)];
}

#endif