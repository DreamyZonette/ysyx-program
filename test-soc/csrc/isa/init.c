#include <memory/paddr.h>
#include <common.h>

static const uint32_t img [] = {
  0x00500093, // ADDI x1, x0, 5   # x1 = x0 + 5 = 0 + 5 = 5
  0xffd08113, // ADDI x2, x1, -3  # x2 = x1 + (-3) = x1 - 3
  0x00018193, // ADDI x3, x3, 0   # x3 = x3 + 0 = x3（无操作，可用于寄存器依赖同步）
  0x7ff20213, // ADDI x4, x4, 2047  # x4 = x4 + 2047
  0x80028293, // ADDI x5, x5, -2048  # x5 = x5 - 2048
   // 1. 整数计算指令 (除ADDI外)
    0x00500093,        // ADDI x1, x0, 5       -> x1 = 5
    0xffd08113,        // ADDI x2, x1, -3      -> x2 = 2
    0x002081b3,        // ADD x3, x1, x2       -> x3 = 5 + 2 = 7
    0x40210233,        // SUB x4, x2, x2       -> x4 = 2 - 2 = 0
    0x0030a2b3,        // SLT x5, x1, x3       -> x5 = (5 < 7) ? 1 : 0
    0x003135b3,        // SLTU x11, x2, x3     -> x11 = (2 < 7) ? 1 : 0 (无符号比较)
    0x00114633,        // XOR x12, x2, x1      -> x12 = 2 XOR 5
    0x001175b3,        // AND x11, x2, x1      -> x11 = 2 AND 5
    0x001165b3,        // OR x11, x2, x1       -> x11 = 2 OR 5

    // 2. 移位指令
    0x00115733,        // SLL x14, x2, x1      -> x14 = 2 << 5
    0x401157b3,        // SRA x15, x2, x1      -> x15 = 2 >> 5 (算术右移)
    0x40115833,        // SRL x16, x2, x1      -> x16 = 2 >> 5 (逻辑右移)

    // 3. 立即数变种指令
    0x00a00693,        // ADDI x13, x0, 10     -> x13 = 10
    0x00a0c713,        // SLLI x14, x1, 10     -> x14 = 5 << 10
    0x40a0d793,        // SRAI x15, x1, 10     -> x15 = 5 >> 10 (算术)
    0x00a0d813,        // SRLI x16, x1, 10     -> x16 = 5 >> 10 (逻辑)
    0x00a0c593,        // SLLI x11, x1, 10     -> 另一种立即数移位
  0x00100073, // ebreak
};



void init_isa() {
  /* Load built-in image. */
  memcpy(guest_to_host(RESET_VECTOR), img, sizeof(img));
}