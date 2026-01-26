/***************************************************************************************
* Copyright (c) 2014-2024 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <memory/host.h>
#include <memory/paddr.h>
#include <device/mmio.h>
#include <isa.h>

#define YSYXSOC 1



#if   defined(CONFIG_PMEM_MALLOC)
static uint8_t *pmem = NULL;
#else // CONFIG_PMEM_GARRAY
static uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};
uint8_t* guest_to_host(paddr_t paddr) { return pmem + paddr - CONFIG_MBASE; }
paddr_t host_to_guest(uint8_t *haddr) { return haddr - pmem + CONFIG_MBASE; }

#ifdef YSYXSOC
uint8_t sram[SRAM_SIZE] PG_ALIGN = {};
uint8_t mrom[MROM_SIZE] PG_ALIGN = {};

//划分一个地址给mrom、sram
// uint8_t* mrom_guest_to_host(paddr_t paddr) { return pmem + paddr - CONFIG_MBASE; }
// paddr_t mrom_host_to_guest(uint8_t *haddr) { return haddr - pmem + CONFIG_MBASE; }

// uint8_t* sram_guest_to_host(paddr_t paddr) { return pmem + paddr - CONFIG_MBASE + MROM_SIZE - SRAM_BASE; }
// paddr_t sram_host_to_guest(uint8_t *haddr) { return haddr - pmem + CONFIG_MBASE; }

static word_t mrom_read(paddr_t addr, int len) {
  word_t ret = 0;
  uint32_t offset = addr - MROM_BASE;
  uint8_t* mrom_addr = mrom + offset;
  switch (len) {
    case 1: ret = *mrom_addr; break;
    case 2: ret = *(uint16_t*)mrom_addr; break;
    case 4: ret = *(uint32_t*)mrom_addr; break;
    default: assert(0);
  }
  return ret;
}

static void mrom_write(paddr_t addr, int len, word_t data) {
  uint32_t offset = addr - MROM_BASE;
  uint8_t* mrom_addr = mrom + offset;
  switch (len) {
    case 1: *mrom_addr = data; break;
    case 2: *(uint16_t*)mrom_addr = data; break;
    case 4: *(uint32_t*)mrom_addr = data; break;
    default: assert(0);
  }
}

static word_t sram_read(paddr_t addr, int len) {
  word_t ret = 0;
  uint32_t offset = addr - SRAM_BASE;
  uint8_t* sram_addr = sram + offset;
  switch (len) {
    case 1: ret = *sram_addr; break;
    case 2: ret = *(uint16_t*)sram_addr; break;
    case 4: ret = *(uint32_t*)sram_addr; break;
    default: assert(0);
  }
  return ret;
}

static void sram_write(paddr_t addr, int len, word_t data) {
  uint32_t offset = addr - SRAM_BASE;
  uint8_t* sram_addr = sram + offset;
  switch (len) {
    case 1: *sram_addr = data; break;
    case 2: *(uint16_t*)sram_addr = data; break;
    case 4: *(uint32_t*)sram_addr = data; break;
    default: assert(0);
  }
}
#endif
#endif



static word_t pmem_read(paddr_t addr, int len) {
  word_t ret = host_read(guest_to_host(addr), len);
  return ret;
}

static void pmem_write(paddr_t addr, int len, word_t data) {
  host_write(guest_to_host(addr), len, data);
}

static void out_of_bound(paddr_t addr) {
  panic("address = " FMT_PADDR " is out of bound of pmem [" FMT_PADDR ", " FMT_PADDR "] at pc = " FMT_WORD,
      addr, PMEM_LEFT, PMEM_RIGHT, cpu.pc);
}

void init_mem() {
#if   defined(CONFIG_PMEM_MALLOC)
  pmem = malloc(CONFIG_MSIZE);
  assert(pmem);
#endif
#ifdef YSYXSOC
  memset(mrom, rand(), MROM_SIZE);
  #endif

  IFDEF(CONFIG_MEM_RANDOM, memset(pmem, rand(), CONFIG_MSIZE));
  Log("physical memory area [" FMT_PADDR ", " FMT_PADDR "]", PMEM_LEFT, PMEM_RIGHT);
}

word_t paddr_read(paddr_t addr, int len) {
  #ifdef CONFIG_MTRACE
    char p [128];
    snprintf(p, 127, "read :"FMT_WORD"\tlen:%d", addr, len);
    p[127] = '\0';
    log_write("%s\n", p);
  #endif
  
  if (likely(in_pmem(addr))) {
    #ifdef YSYXSOC
    if (addr >= MROM_BASE && addr < MROM_BASE + MROM_SIZE) return mrom_read(addr, len);
    if (addr >= SRAM_BASE && addr < SRAM_BASE + SRAM_SIZE) return sram_read(addr, len);
    // if (addr == 0x10000005) return 0x20;// uart lsr return 0x20 
    return 0;
    #endif

    return pmem_read(addr, len);
  }
  IFDEF(CONFIG_DEVICE, return mmio_read(addr, len));
  out_of_bound(addr);
  return 0;
}

void paddr_write(paddr_t addr, int len, word_t data) {
  #ifdef CONFIG_MTRACE
    char p [128];
    snprintf(p, 127, "write:"FMT_WORD"\tlen:%d\tdata:%u", addr, len, data);
    p[127] = '\0';
    log_write("%s\n", p);
  #endif
  // #ifdef YSYXSOC
  //   if (addr >= MROM_BASE && addr < MROM_BASE + MROM_SIZE) {mrom_write(addr - MROM_BASE, len, data);return;}
  //   if (addr >= SRAM_BASE && addr < SRAM_BASE + SRAM_SIZE) {sram_write(addr - SRAM_BASE, len, data);return;}
  // #endif
  if (likely(in_pmem(addr))) { 
    #ifdef YSYXSOC
    if (addr >= MROM_BASE && addr < MROM_BASE + MROM_SIZE) {mrom_write(addr, len, data);return;}
    if (addr >= SRAM_BASE && addr < SRAM_BASE + SRAM_SIZE) {sram_write(addr, len, data);return;}
    return;
    #endif
    pmem_write(addr, len, data);
    return; }
  IFDEF(CONFIG_DEVICE, mmio_write(addr, len, data); return);
  out_of_bound(addr);
}
