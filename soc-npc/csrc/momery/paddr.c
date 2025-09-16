#include <memory/paddr.h>
#include <memory/host.h> 
#include <device/mmio.h>

// #define CONFIG_SERIAL_MMIO 0xa00003f8
// #define CONFIG_RTC_MMIO 0xa0000048
// #define CONFIG_I8042_DATA_MMIO 0xa0000060
// #define CONFIG_VGA_CTL_MMIO 0xa0000100
// #define CONFIG_AUDIO_CTL_MMIO 0xa0000200
// #define CONFIG_SDCARD_CTL_MMIO 0xa3000000
// #define CONFIG_SB_ADDR 0xa1200000
// #define CONFIG_FB_ADDR 0xa1000000
// 串口
#define SERIAL_PORT_LEFT      CONFIG_SERIAL_MMIO
#define SERIAL_PORT_RIGHT    (CONFIG_SERIAL_MMIO + 7)
// 时钟
#define RTC_ADDR_LEFT  CONFIG_RTC_MMIO
#define RTC_ADDR_RIGHT  (CONFIG_RTC_MMIO + 7)
// 键盘
#define I8042_DATA_ADDR_LEFT (CONFIG_I8042_DATA_MMIO)
#define I8042_DATA_ADDR_RIGHT (CONFIG_I8042_DATA_MMIO + 3)
// 屏幕
#define VGA_CTL_ADDR_LEFT (CONFIG_VGA_CTL_MMIO)
#define VGA_CTL_ADDR_RIGHT (CONFIG_VGA_CTL_MMIO + 7)
// 声卡
#define AUDIO_CTL_ADDR_LEFT (CONFIG_AUDIO_CTL_MMIO)
#define AUDIO_CTL_ADDR_RIGHT (CONFIG_AUDIO_CTL_MMIO + 0x20 - 1)
// 存储卡
#define SDCARD_CTL_ADDR_LEFT (CONFIG_SDCARD_CTL_MMIO)
#define SDCARD_CTL_ADDR_RIGHT (CONFIG_SDCARD_CTL_MMIO + 7)
// 声卡缓存区
#define SB_ADDR_LEFT (CONFIG_SB_ADDR)
#define SB_ADDR_RIGHT (CONFIG_SB_ADDR + 0x10000 - 1)
// 帧缓存区
#define FB_ADDR_LEFT (CONFIG_FB_ADDR)
#define FB_ADDR_RIGHT (CONFIG_FB_ADDR + 0x75300 - 1)


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
  #if CONFIG_MTRACE
      if (addr != get_pc()){
        char s[128];
        sprintf(s, "DPI-RET: flash_read(0x%08x, %d)\n", addr, 4);
        printf("%s\n", s);
        log_write("%s\n", s);
      }
      //if (addr == 0x80011071 || addr == 0x80011070)printf("DPI-RET: pmem_read(0x%08x, %d) = 0x%08x\n", addr, len, ret);

    #endif
  *data = internal_pmem_read(addr, 4);
}
