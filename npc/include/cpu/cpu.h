// modified by long for NPC
#ifndef __CPU_H__
#define __CPU_H__

#include <common.h>

void cpu_exec(uint64_t n);
void sim_run();

extern "C" {

// DPI 函数声明
unsigned int get_pc();
unsigned int get_instruction();
}


#endif /* __CPU_H__ */