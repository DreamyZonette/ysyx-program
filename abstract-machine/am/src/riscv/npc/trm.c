// #include <am.h>
// #include <klib-macros.h>
// #include <riscv/riscv.h>

// # define DEVICE_BASE 0xa0000000
// #define SERIAL_PORT     (DEVICE_BASE + 0x00003f8)

// extern char _heap_start;
// int main(const char *args);

// extern char _pmem_start;
// #define PMEM_SIZE (128 * 1024 * 1024)
// #define PMEM_END  ((uintptr_t)&_pmem_start + PMEM_SIZE)

// Area heap = RANGE(&_heap_start, PMEM_END);
// static const char mainargs[MAINARGS_MAX_LEN] = TOSTRING(MAINARGS_PLACEHOLDER); // defined in CFLAGS

// void putch(char ch) {
//   outb(SERIAL_PORT, ch);
// }

// void halt(int code) {
//   register long a0 asm("a0") = code;
//   asm volatile("ebreak" : : "r"(a0));
//   while (1);
// }

// void _trm_init() {
//   int ret = main(mainargs);
//   halt(ret);
// }

// 适配D阶段SOC
#include <am.h>
#include <klib-macros.h>
#include <riscv/riscv.h>

# define DEVICE_BASE 0xa0000000
#define SERIAL_PORT     (DEVICE_BASE + 0x00003f8)

extern char _heap_start;
int main(const char *args);

extern char _pmem_start;
#define PMEM_SIZE (128 * 1024 * 1024)
#define PMEM_END  ((uintptr_t)&_pmem_start + PMEM_SIZE)

Area heap = RANGE(&_heap_start, PMEM_END);
static const char mainargs[MAINARGS_MAX_LEN] = TOSTRING(MAINARGS_PLACEHOLDER); // defined in CFLAGS

#define UART_BASE 0x10000000

void putch(char ch) {
  // while ((inb(UART_BASE + 0x3) & 0x20) == 0) {
  //       // 空循环，等待LSR[5] (THRE) 位为1
  //   }
  outb(SERIAL_PORT, ch);
}

void halt(int code) {
  register long a0 asm("a0") = code;
  asm volatile("ebreak" : : "r"(a0));
  while (1);
}


void _trm_init() {
  outb(UART_BASE + 0x3, 0x83); // LCR
  outb(UART_BASE + 0x0, 0x36); // LSB
  outb(UART_BASE + 0x1, 0x00); // MSB
  outb(UART_BASE + 0x3, 0x03); // LCR
  outb(UART_BASE + 0x1, 0x00); // IER
  outb(UART_BASE + 0x2, 0x07); // FCR
  outb(UART_BASE + 0x4, 0x00); // MCR
  int ret = main(mainargs);
  halt(ret);
}
