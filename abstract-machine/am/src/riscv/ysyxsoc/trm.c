#include <am.h>
#include <klib-macros.h>
#include <riscv/riscv.h>

#define UART_BASE 0x10000000
#define THR_ADDR (UART_BASE + 0x0)
#define LER_ADDR (UART_BASE + 0x1)
#define IIR_ADDR (UART_BASE + 0x2)
#define FCR_ADDR (UART_BASE + 0x2)
#define LCR_ADDR (UART_BASE + 0x3)
#define MCR_ADDR (UART_BASE + 0x4)
#define LSR_ADDR (UART_BASE + 0x5)
#define MSR_ADDR (UART_BASE + 0x6)
#define LSB_ADDR (UART_BASE + 0x0)
#define MSB_ADDR (UART_BASE + 0x1)

extern char _heap_start;
int main(const char *args);

extern char _pmem_start;
#define PMEM_SIZE (128 * 1024 * 1024)
#define PMEM_END  ((uintptr_t)&_pmem_start + PMEM_SIZE)

Area heap = RANGE(&_heap_start, PMEM_END);
static const char mainargs[MAINARGS_MAX_LEN] = TOSTRING(MAINARGS_PLACEHOLDER); // defined in CFLAGS

void putch(char ch) {
    while ((inb(LSR_ADDR) & 0x20) == 0) {
        // 空循环，等待LSR[5] (THRE) 位为1
    }
  outb(THR_ADDR, ch);
}

void halt(int code) {
  register long a0 asm("a0") = code;
  asm volatile("ebreak" : : "r"(a0));
  while (1);
}

extern unsigned char _data_start[];   // .data段SRAM运行地址（VMA）起始
extern unsigned char _data_end[];     // .data段SRAM运行地址（VMA）结束
extern unsigned char _rodata_end[];  // .stack段SRAM运行地址（VMA）起始

void _boot_loader() {
    unsigned char *src = _rodata_end;       // 源地址：ROM中的.data初始值（LMA）
    unsigned char *dst = _data_start;  // 目标地址：SRAM中的.data运行地址（VMA）
    while (dst < _data_end) {
        *dst++ = *src++;  // 逐字节复制（兼容任意位宽数据）
    }
}

void _uart_init() {
  // 配置除数寄存器
  outb(LCR_ADDR, 0x80); // LCR
  outb(LSB_ADDR, 0x36); // LSB
  outb(MSB_ADDR, 0x00); // MSB

  outb(LCR_ADDR, 0x03); // LCR
  outb(FCR_ADDR, 0x07);
  outb(MCR_ADDR, 0x03); 
  outb(LER_ADDR, 0x00);
}

void _trm_init() {
  _boot_loader();
  _uart_init();
  int ret = main(mainargs);
  halt(ret);
}
