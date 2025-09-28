#ifndef __MEMORY_PADDR_H__
#define __MEMORY_PADDR_H__

#include <common.h>

#define PMEM_LEFT  ((paddr_t)CONFIG_FLASH_BASE)
#define PMEM_RIGHT ((paddr_t)CONFIG_FLASH_BASE + CONFIG_FLASH_SIZE - 1)
#define RESET_VECTOR (PMEM_LEFT + CONFIG_PC_RESET_OFFSET)

uint8_t* guest_to_host(paddr_t paddr);

paddr_t host_to_guest(uint8_t *haddr);

extern "C" {
    int pmem_read(int addr, int len);
    void pmem_write(int addr, int len, int data);
    void flash_read(int32_t addr, int32_t *data);
}



static inline bool in_pmem(paddr_t addr) {
  return addr - CONFIG_FLASH_BASE < CONFIG_FLASH_SIZE;
}

word_t paddr_read(paddr_t addr, int len);
void paddr_write(paddr_t addr, int len, word_t data);

#endif