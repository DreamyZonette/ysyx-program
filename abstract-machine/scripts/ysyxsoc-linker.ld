ENTRY(_start)
PHDRS { text PT_LOAD; data PT_LOAD; }

MEMORY {
  mrom(r x): ORIGIN = 0x20000000, LENGTH = 4K
  sram(rwx): ORIGIN = 0x0f000000, LENGTH = 8K
}

SECTIONS {
  /* _pmem_start and _entry_offset are defined in LDFLAGS */
  /* . = _mrom_start + _entry_offset; */
  . =  ORIGIN(mrom);
  /* ========== .text/.rodata：VMA与LMA均在mrom（只读） ========== */
  .text : {
    *(entry)
    *(.text*)
  } > mrom AT> mrom : text

  etext = .;
  _etext = .;

  .rodata : {
    *(.rodata*)
  } > mrom AT> mrom : text

  /* ========== .data：VMA在sram，LMA在mrom（可读写需复制） ========== */
  /* . = ORIGIN(sram); */

  .data : {
    _data_start = .;
    *(.data*)
    _data_end = .;
  } > sram AT> mrom : data

  edata = .;
  _data = .;

  /* ========== .bss：仅VMA在sram（无需加载，运行时清零） ========== */
  .bss : {
	_bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    . = ALIGN(4);
    _bss_end = .;
  } > sram : data

  /* _stack_top = ALIGN(0x1000);
  . = _stack_top + 0x2000;
  _stack_pointer = .; */

    /* ========== 替换栈定义：固定到 SRAM 区间 ========== */
  /* _stack_top = ALIGN(0x0F001FFF, 0x10); */
  _stack_top = ALIGN(ORIGIN(SRAM) + LENGTH(SRAM), 0x10);
  _stack_pointer = _stack_top;
  _stack_bottom = 0x0F001000;

  /* ========== 替换堆定义：固定到 SRAM 区间 ========== */
  _heap_start = _bss_end;
  _heap_end = _stack_bottom;
  end = .;
  _end = .;
  /* _heap_start = ALIGN(0x1000); */
}
