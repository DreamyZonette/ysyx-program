ENTRY(_start)
PHDRS { text PT_LOAD; data PT_LOAD; }

MEMORY {
  mrom (r x): ORIGIN = 0x20000000, LENGTH = 4K
  sram (rwx): ORIGIN = 0x0f000000, LENGTH = 8K
  flash(r x): ORIGIN = 0x30000000, LENGTH = 16M
  psram(rwx): ORIGIN = 0x80000000, LENGTH = 4M
}

SECTIONS {
  /* . =  ORIGIN(flash); */
  .text : {
    _text_start = .;
    *(entry)
    *(.text*)
  } > psram AT> flash : text

  etext = .;
  _etext = .;

  .rodata : {
    *(.rodata*)
  } > psram AT> flash : text
  _text_end = .;
  text_lma_addr = LOADADDR(.text);

/***********************/

  .data : {
    _data_start = .;
    *(.sdata .sdata.*)
    *(.data .data.*)
    _data_end = .;
  } > psram AT> flash : data

  data_lma_addr = LOADADDR(.data);
  edata = .;
  _data = .;

  .bss : {
	_bss_start = .;
    *(.sbss .sbss.*)
    *(.scommon)
    *(.bss .bss.*)
    . = ALIGN(16);
    _bss_end = .;
  } > psram

  _heap_start = .;
  _heap_end = ORIGIN(psram) + LENGTH(psram);

  _stack_top = ALIGN(ORIGIN(sram) + LENGTH(sram), 16);
  _stack_pointer = _stack_top;
  _stack_bottom = ORIGIN(sram);


  
  end = .;
  _end = .;
}
