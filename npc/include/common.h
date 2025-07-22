#ifndef __COMMON_H__
#define __COMMON_H__

#include <stdint.h>
#include <inttypes.h>
#include <stdbool.h>
#include <string.h>

#include "verilated.h"
#include "Vtop.h"
#include "verilated_vcd_c.h"
#include "svdpi.h"
#include "Vtop__Dpi.h"


typedef uint32_t word_t;
typedef uint32_t sword_t;

typedef uint32_t paddr_t;
typedef word_t vaddr_t;

#include <generated/autoconf.h>
#include <macro.h>
#include <utils.h>

#include <assert.h>
#include <stdlib.h>

#include <debug.h>

#endif