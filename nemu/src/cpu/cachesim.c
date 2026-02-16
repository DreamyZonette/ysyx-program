// #include <cpu/cpu.h>
// #include <cpu/decode.h>
// #include <cpu/difftest.h>
// #include <locale.h>
// #include <memory/vaddr.h>

// #define  CACHE_BLOCK_SIZE   16
// #define  CACHE_BLOCK_BANK   4
// #define  CACHE_BLOCK_COUNT  (CACHE_BLOCK_SIZE / 4)
// #define  m                  4 // $clog2(CACHE_BLOCK_SIZE);
// #define  n                  2 // $clog2(CACHE_BLOCK_BANK)
// #define  SDRAM_BASE_ADDR    0xa0000000
// #define  SDRAM_SIZE         0x20000000
// static char *cache_img_file = "/home/long/ysyx-workbench/am-kernels/tests/cpu-tests/build/dummy-riscv32e-ysyxsoc.bin";
// // #define icache_access_time  1
// // #define icache_miss_penalty  19 // 36 apb delay_on dram // 19 axiburst

// static uint32_t cache_addr[CACHE_BLOCK_BANK];
// static uint32_t cache_valid[CACHE_BLOCK_BANK];
// static uint32_t cache_pc = 0;
// static uint32_t cache_dnpc = 0;
// static uint32_t cache_snpc = 0;


// void cache_init() {
//     for (int i = 0; i < CACHE_BLOCK_BANK; i++) {
//         cache_addr[i] = 0;
//         cache_valid[i] = 0;
//     }
//     cache_pc = 0x30000000; // flash
//     cache_snpc = 0x30000004; 
//     cache_dnpc = cache_snpc; 
// }

// void cachesim_mainloop() {

// }

// void cache_trace() {

// }

