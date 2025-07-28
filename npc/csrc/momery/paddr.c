#include <memory/paddr.h>
#include <memory/host.h> 
#include <device/mmio.h>

#define DEVICE_BASE 0xa0000000
#define MMIO_BASE 0xa0000000
// 串口
#define SERIAL_PORT     (DEVICE_BASE + 0x00003f8)
// 时钟
#define RTC_LO_ADDR  (DEVICE_BASE + 0x0000048)
#define RTC_HI_ADDR  (DEVICE_BASE + 0x000004c)

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
  panic("address = " FMT_PADDR " is out of bound of pmem [" FMT_PADDR ", " FMT_PADDR "] at pc = " FMT_WORD,
      addr, PMEM_LEFT, PMEM_RIGHT, top->de_pc);
}

extern "C" int pmem_read(int addr, int len) {
  addr = paddr_t(addr);
  uint32_t ret;
  if (addr == RTC_LO_ADDR || addr == RTC_HI_ADDR) { 
    ret = mmio_read(addr, len);
  }
  else{
    ret = internal_pmem_read(addr, len);
    #if CONFIG_MTRACE
      // if (addr != top->de_pc)printf("DPI-RET: pmem_read(0x%08x, %d) = 0x%08x\n", addr, len, ret);
      if (addr == 0x80011071 || addr == 0x80011070)printf("DPI-RET: pmem_read(0x%08x, %d) = 0x%08x\n", addr, len, ret);

    #endif
  }
  return ret;
}

extern "C" void pmem_write(int addr, int len, int data) {
  addr = paddr_t(addr);
  data = word_t(data);
  
  if(addr == SERIAL_PORT){
    // putchar(char(data));
    mmio_write(addr, len, data);
    // printf("串口传出数据%08x\n", data);
  }
  else{
    #if CONFIG_MTRACE
    // printf("DPI-CALL: pmem_write(0x%08x, %d, 0x%08x)\n", addr, len, data);
    if (addr == 0x80011071 || addr == 0x80011070) {
      printf("DPI-CALL: pmem_write(0x%08x, %d, 0x%08x)\n", addr, len, data);
      printf("0x%08x\n", top->de_pc);
    }

  #endif
    internal_pmem_write(addr, len, data);
  }
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