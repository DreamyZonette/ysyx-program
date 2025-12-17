ENTRY(_start)
PHDRS { text PT_LOAD; data PT_LOAD; }

SECTIONS {
  /* _pmem_start and _entry_offset are defined in LDFLAGS */
  . = _mrom_start + _entry_offset;
  .text : {
    *(entry)
    *(.text*)
  } : text
  etext = .;
  _etext = .;
  .rodata : {
    *(.rodata*)
  }
  .data : {
    *(.data*)
  } : data
  edata = .;
  _data = .;
  .bss : {
	_bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
  }
  /* _stack_top = ALIGN(0x1000);
  . = _stack_top + 0x2000;
  _stack_pointer = .; */
    /* ========== 替换栈定义：固定到 SRAM 区间 ========== */
  _stack_top = ALIGN(0x0F001FFF, 0x10);  
  _stack_pointer = _stack_top + 1;
  _stack_bottom = 0x0F000000;
  /* ========== 替换堆定义：固定到 SRAM 区间 ========== */

  end = .;
  _end = .;
  _heap_start = ALIGN(0x1000);
}
