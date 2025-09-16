#include <memory/paddr.h>
#include <memory/host.h> 
#include <device/mmio.h>

#define FLASH_BASE 0x30000000

static uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};

uint8_t* guest_to_host(paddr_t paddr) { return pmem + paddr - CONFIG_MBASE; }
paddr_t host_to_guest(uint8_t *haddr) { return haddr - pmem + CONFIG_MBASE; }

void init_mem() {
  memset(pmem, rand(), CONFIG_MSIZE);
  Log("physical memory area [%08x, %08x]", PMEM_LEFT, PMEM_RIGHT);
}

static word_t internal_pmem_read(paddr_t addr, int len) {
  word_t ret = host_read(guest_to_host(addr), len);
  return ret;
}

static void internal_pmem_write(paddr_t addr, int len, word_t data) {
  host_write(guest_to_host(addr), len, data);
}

static void out_of_bound(paddr_t addr) {
 
}

extern "C" int pmem_read(int addr, int len) {
 
  return 1;
}
extern uint64_t g_nr_guest_inst;
extern "C" void pmem_write(int addr, int len, int data) {
 
}

word_t paddr_read(paddr_t addr, int len) {
  if (likely(in_pmem(addr))) return pmem_read(addr, len);
  #if CONFIG_DEVICE
  return mmio_read(addr, len);
  #endif
    out_of_bound(addr);
  return 0;
}

void paddr_write(paddr_t addr, int len, word_t data) {
  if (likely(in_pmem(addr))) { pmem_write(addr, len, data); return; }
  #if CONFIG_DEVICE
  mmio_write(addr, len, data);
  return;
  #endif
  out_of_bound(addr);
}

extern "C" void flash_read(int32_t addr, int32_t *data) {
  uint32_t raddr = FLASH_BASE + addr;
  #if CONFIG_MTRACE
      // if (addr != get_pc()){
        char s[128];
        sprintf(s, "DPI-RET: flash_read(0x%08x, %d)\n", raddr, 4);
        printf("%s\n", s);
        log_write("%s\n", s);
      // }

    #endif
  *data = internal_pmem_read(raddr, 4);
}
