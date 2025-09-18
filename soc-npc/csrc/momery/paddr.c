#include <memory/paddr.h>
#include <memory/host.h> 
#include <device/mmio.h>


static uint8_t flash_mem[CONFIG_FLASH_SIZE] PG_ALIGN = {};

uint8_t* guest_to_host(paddr_t paddr) { return flash_mem + paddr - CONFIG_FLASH_BASE; }
paddr_t host_to_guest(uint8_t *haddr) { return haddr - flash_mem + CONFIG_FLASH_BASE; }

void init_mem() {
  memset(flash_mem, rand(), CONFIG_FLASH_SIZE);
  Log("physical memory area [%08x, %08x]", PMEM_LEFT, PMEM_RIGHT);
}

static word_t internal_flash_read(paddr_t addr, int len) {
  word_t ret = host_read(guest_to_host(addr), len);
  return ret;
}

static void internal_flash_write(paddr_t addr, int len, word_t data) {
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
  uint32_t raddr = CONFIG_FLASH_BASE + (uint32_t)addr;
  *data = internal_flash_read(raddr, 4);
  #if CONFIG_DTRACE
      // if (addr != get_pc()){
        char s[128];
        sprintf(s, "DPI-RET: flash_read(0x%08x, %d) = 0x%08x\n", raddr, 4, *data);
        printf("%s\n", s);
        log_write("%s\n", s);
      // }

    #endif
}
