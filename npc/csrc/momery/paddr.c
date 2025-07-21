#include <memory/paddr.h>
#include <memory/host.h> 


static uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};

uint8_t* guest_to_host(paddr_t paddr) { return pmem + paddr - CONFIG_MBASE; }
paddr_t host_to_guest(uint8_t *haddr) { return haddr - pmem + CONFIG_MBASE; }

void init_mem() {
  memset(pmem, rand(), CONFIG_MSIZE);
  printf("physical memory area [%08x, %08x]\n", PMEM_LEFT, PMEM_RIGHT);
}

static word_t internal_pmem_read(paddr_t addr, int len) {
  word_t ret = host_read(guest_to_host(addr), len);
  return ret;
}

static void internal_pmem_write(paddr_t addr, int len, word_t data) {
  host_write(guest_to_host(addr), len, data);
}

extern "C" int pmem_read(int addr, int len) {
  printf("DPI-CALL: pmem_read(0x%x, %d)\n", paddr_t(addr), len);
  return internal_pmem_read(paddr_t(addr), len);
}

extern "C" void pmem_write(int addr, int len, int data) {
  printf("DPI-CALL: pmem_write(0x%x, %d, 0x%x)\n", paddr_t(addr), len, word_t(data));
  internal_pmem_write(paddr_t(addr), len, word_t(data));
}