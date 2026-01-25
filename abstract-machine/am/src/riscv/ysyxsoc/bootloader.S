    .section .text.boot, "ax"
    .global _boot_loader
_boot_loader:

    # ==================== 推荐写法：简单、安全的逐字节版本 ====================
    # 优点：代码最短、最安全，不依赖任何对齐要求
    # 适合你的小系统（4K ROM + 8K SRAM），完全够用

    # ---------- 复制 .data 段（从 mrom 的 LMA → sram 的 VMA） ----------
    la      a0, _etext          # src = mrom 中的 .data 初始值（紧跟 .rodata 后）
    la      a1, _data_start     # dst = sram 中的 .data 运行地址
    la      a2, _data_end       # end

    beq     a1, a2, data_done   # 如果 .data 段为空，直接跳过

data_loop:
    lw      t0, 0(a0)        
    sw      t0, 0(a1)         
    addi    a0, a0, 4
    addi    a1, a1, 4
    bne     a1, a2, data_loop

data_done:

    # ---------- 清零 .bss 段 ----------
    la      a0, _bss_start
    la      a1, _bss_end
    beq     a0, a1, bss_done    # 如果 .bss 段为空，直接跳过

    li      t0, 0
bss_loop:
    sw      t0, (a0)
    addi    a0, a0, 4
    bne     a0, a1, bss_loop

bss_done:
    ret                         # 返回到 C 的 _trm_init()，继续执行 main