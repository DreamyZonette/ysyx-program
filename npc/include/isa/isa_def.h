#ifndef __ISA_DEF_H__
#define __ISA_DEF_H__

#include <common.h>

typedef struct {
  word_t gpr[32];
  vaddr_t pc;
  vaddr_t next_pc;
  vaddr_t diff_mstatus;
  vaddr_t diff_mepc;
  vaddr_t diff_mtvec;
  vaddr_t diff_mcause;
} riscv32_CPU_state;

#define CPU_state riscv32_CPU_state

extern CPU_state dut;



#endif /* __ISA_DEF_H__ */