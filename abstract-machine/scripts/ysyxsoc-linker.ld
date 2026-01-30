ENTRY(_start)
PHDRS { text PT_LOAD; data PT_LOAD; }

MEMORY {
  mrom (r x): ORIGIN = 0x20000000, LENGTH = 4K
  sram (rwx): ORIGIN = 0x0f000000, LENGTH = 8K
  flash(r x): ORIGIN = 0x30000000, LENGTH = 16M
  psram(rwx): ORIGIN = 0x80000000, LENGTH = 4M
}

SECTIONS {
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
  . =  ORIGIN(psram);

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
    . = ALIGN(4);
    _bss_end = .;
  } > psram 

  . = ALIGN(16);
  _heap_start = .;
  PROVIDE(__heap_start = .);
  PROVIDE(_end = .);
  PROVIDE(end = .);

  _stack_top = ALIGN(ORIGIN(psram) + LENGTH(psram), 16);
  _stack_pointer = _stack_top;
  PROVIDE(__stack_top = _stack_top);

  _heap_end = _stack_top;

  _stack_bottom = _heap_end;

  ASSERT(_stack_top == ORIGIN(psram) + LENGTH(psram) || _stack_top <= ORIGIN(psram) + LENGTH(psram), "Stack top overflows PSRAM!")
  ASSERT(_heap_start < _heap_end, "No space left for heap/stack (BSS too large or overlap)!")
  
  end = .;
  _end = .;
}
