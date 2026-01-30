    .section .text.boot, "ax"
    .global _boot_loader
_boot_loader:

    # ---------- 复制 .data 段（从 mrom 的 LMA → sram 的 VMA） ----------
    la      a0, data_lma_addr          
    la      a1, _data_start     
    la      a2, _data_end       

    beq     a1, a2, data_done   

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
    beq     a0, a1, bss_done   

    li      t0, 0
bss_loop:
    sw      t0, (a0)
    addi    a0, a0, 4
    bne     a0, a1, bss_loop

bss_done:
    ret                    