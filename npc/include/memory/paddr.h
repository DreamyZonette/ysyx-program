#ifndef __MEMORY_PADDR_H__
#define __MEMORY_PADDR_H__

#include <common.h>

// #if CONFIG_YSYXSOC
#define CONFIG_MROM_SIZE 0x1000
#define CONFIG_MROM_BASE 0x20000000
#define MROM_LEFT  ((paddr_t)CONFIG_MROM_BASE)
#define MROM_RIGHT ((paddr_t)CONFIG_MROM_BASE + CONFIG_MROM_SIZE - 1)
#define MROM_RESET_VECTOR (MROM_LEFT + CONFIG_PC_RESET_OFFSET)
#define SRAM_BASE 0x0f000000
#define SRAM_SIZE 8 * 1024
#define MROM_BASE 0x20000000
#define MROM_SIZE 4 * 1024
// #endif

#define PMEM_LEFT  ((paddr_t)CONFIG_MBASE)
#define PMEM_RIGHT ((paddr_t)CONFIG_MBASE + CONFIG_MSIZE - 1)
#define RESET_VECTOR (PMEM_LEFT + CONFIG_PC_RESET_OFFSET)


uint8_t* guest_to_host(paddr_t paddr);
uint8_t* mrom_guest_to_host(paddr_t paddr);
paddr_t host_to_guest(uint8_t *haddr);

extern "C" {
    int pmem_read(int addr, int len);
    void pmem_write(int addr, int len, int data);
    void flash_read(int32_t addr, int32_t *data);
    void mrom_read(int32_t addr, int32_t *data);
}

static inline bool in_pmem(paddr_t addr) {
  return addr - CONFIG_MBASE < CONFIG_MSIZE;
}

word_t paddr_read(paddr_t addr, int len);
void paddr_write(paddr_t addr, int len, word_t data);

#endif