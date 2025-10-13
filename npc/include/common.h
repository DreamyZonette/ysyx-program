#ifndef __COMMON_H__
#define __COMMON_H__

#include <stdint.h>
#include <inttypes.h>
#include <stdbool.h>
#include <string.h>

#include "verilated.h"
#include "VysyxSoCFull.h"
#include "verilated_vcd_c.h"
#include "svdpi.h"
#include "VysyxSoCFull__Dpi.h"


typedef uint32_t word_t;
typedef uint32_t sword_t;

typedef uint32_t paddr_t;
typedef word_t vaddr_t;

#define FMT_WORD "0x%08" PRIx32

#include <generated/autoconf.h>
#include <macro.h>
#include <utils.h>

#include <assert.h>
#include <stdlib.h>


#define FMT_PADDR MUXDEF(PMEM64, "0x%016" PRIx64, "0x%08" PRIx32)
typedef uint16_t ioaddr_t;

#include <debug.h>

extern VerilatedContext* contextp;
#if CONFIG_WAVE
extern VerilatedVcdC* tfp;
#endif
extern VysyxSoCFull* top;

#endif