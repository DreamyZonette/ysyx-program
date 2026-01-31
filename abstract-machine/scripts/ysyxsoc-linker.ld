ENTRY(_start)
PHDRS { text PT_LOAD; rodata PT_LOAD; data PT_LOAD; bss PT_LOAD;}

MEMORY {
  mrom (r x): ORIGIN = 0x20000000, LENGTH = 4K
  sram (rwx): ORIGIN = 0x0f000000, LENGTH = 8K
  flash(r x): ORIGIN = 0x30000000, LENGTH = 16M
  psram(rwx): ORIGIN = 0x80000000, LENGTH = 4M
}

SECTIONS {
  .text : {
    _text_start = .;
    *(entry)
    *(.text*)
  } > flash AT> flash : text

  etext = .;
  _etext = .;
  text_lma_addr = LOADADDR(.text);

  .rodata : {
    _rodata_start = .;
    *(.rodata*)
    . = ALIGN(16);
    _rodata_end = .;
  } > psram AT> flash : rodata
  _text_end = .;
  rodata_lma_addr = LOADADDR(.rodata);

/***********************/

  .data : {
    _data_start = .;
    *(.sdata .sdata.*)
    *(.data .data.*)
    . = ALIGN(16);
    _data_end = .;
  } > psram AT> flash : data

  data_lma_addr = LOADADDR(.data);
  edata = .;
  _data = .;

  .bss (NOLOAD) : {
	_bss_start = .;
    *(.sbss .sbss.*)
    *(.scommon)
    *(.bss .bss.*)
    . = ALIGN(16);
    _bss_end = .;
  } > psram : bss

  _heap_start = .;
  _heap_end = ORIGIN(psram) + LENGTH(psram);

  _stack_top = ORIGIN(sram) + LENGTH(sram);
  _stack_pointer = _stack_top;
  _stack_bottom = ORIGIN(sram);


  
  end = .;
  _end = .;
}
