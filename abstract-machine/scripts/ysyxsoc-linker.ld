ENTRY(_start)
PHDRS { text PT_LOAD; data PT_LOAD; }

MEMORY {
  mrom (r x): ORIGIN = 0x20000000, LENGTH = 4K
  sram (rwx): ORIGIN = 0x0f000000, LENGTH = 8K
  flash(r x): ORIGIN = 0x30000000, LENGTH = 16M
  psram(rwx): ORIGIN = 0x80000000, LENGTH = 4M
}

SECTIONS {
  /* _pmem_start and _entry_offset are defined in LDFLAGS */
  /* . = _mrom_start + _entry_offset; */
  /* . =  ORIGIN(mrom);
  .text : {
    *(entry)
    *(.text*)
  } > mrom AT> mrom : text

  etext = .;
  _etext = .;

  .rodata : {
    *(.rodata*)
  } > mrom AT> mrom : text */

  . =  ORIGIN(flash);
  .text : {
    *(entry)
    *(.text*)
  } > flash AT> flash : text

  etext = .;
  _etext = .;

  .rodata : {
    *(.rodata*)
  } > flash AT> flash : text

/***********************/
  . =  ORIGIN(sram);
  /* .data : {
    _data_start = .;
    *(.sdata .sdata.*)
    *(.data .data.*)
    _data_end = .;
  } > sram AT> mrom : data */

  .data : {
    _data_start = .;
    *(.sdata .sdata.*)
    *(.data .data.*)
    _data_end = .;
  } > sram AT> flash : data

  data_lma_addr = LOADADDR(.data);
  edata = .;
  _data = .;

  .bss : {
	_bss_start = .;
    *(.sbss .sbss.*)
    *(.scommon)
    *(.bss .bss.*)
    . = ALIGN(4);
    _bss_end = .;
  } > sram : data

  _heap_start = _bss_end;
  _heap_end = _stack_bottom;

  _stack_top = ALIGN(0x0F001FFF, 0x10);
  _stack_pointer = _stack_top;
  _stack_bottom = 0x0F001000;

  /* _heap_start = _bss_end;

  _stack_top = ALIGN(ORIGIN(sram) + LENGTH(sram), 0x10);
  _stack_pointer = _stack_top;
  _stack_bottom = .;
  _heap_end = _stack_bottom; 

  .stack : {
    . = . + (_stack_top - _stack_bottom);
    . = ALIGN(4);
  } > sram : data

  ASSERT(_stack_top <= ORIGIN(sram) + LENGTH(sram), "Stack overflow SRAM!")
  ASSERT(_heap_start < _heap_end, "Heap size is zero (BSS overlaps stack)!") */
  
  end = .;
  _end = .;
}
