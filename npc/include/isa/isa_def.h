#ifndef __ISA_DEF_H__
#define __ISA_DEF_H__

#include <common.h>

typedef struct {
  word_t gpr[32];
  vaddr_t pc;
} riscv32_CPU_state;

riscv32_CPU_state cpu;


#endif /* __ISA_DEF_H__ */