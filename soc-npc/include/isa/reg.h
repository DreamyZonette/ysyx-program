#ifndef __RISCV_REG_H__
#define __RISCV_REG_H__

#include <common.h>

// extern VerilatedContext* contextp;
// extern VerilatedVcdC* tfp;
// extern Vysyx_25020042* top;

static inline int check_reg_idx(int idx) {
  assert(idx >= 0 && idx < 32);
  return idx;
}

#define gpr(idx) (top->asic->cpu->cpu->gpr_u->reg_data[check_reg_idx(idx)])

static inline const char* reg_name(int idx) {
  extern const char* regs[];
  return regs[check_reg_idx(idx)];
}

#endif