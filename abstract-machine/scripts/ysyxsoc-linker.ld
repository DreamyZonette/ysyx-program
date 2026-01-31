ENTRY(_start)
PHDRS { text PT_LOAD; data PT_LOAD;}

MEMORY {
  mrom (r x): ORIGIN = 0x20000000, LENGTH = 4K
  flash(r x): ORIGIN = 0x30000000, LENGTH = 16M
  psram(rwx): ORIGIN = 0x80000000, LENGTH = 4M
  sram (rwx): ORIGIN = 0x0f000000, LENGTH = 8K
}

SECTIONS {
  . = ORIGIN(flash);
  
  .text : {
    _text_start = .;
    *(entry)
    *(.text*)
  } > flash AT> flash : text

  etext = .;
  _etext = .;
  text_lma_addr = LOADADDR(.text);

  . = ORIGIN(psram);
  .rodata : ALIGN(4) {
    _rodata_start = .;
    *(.rodata*)
    *(.srodata*)
    *(.srodata.*)
    . = ALIGN(4);
    _rodata_end = .;
  } > psram AT> flash : data
  _text_end = .;
  rodata_lma_addr = LOADADDR(.rodata);

/***********************/
  /* INCLUDE extra.ld; */

  .data : ALIGN(4) {
    _data_start = .;
    *(.data .data.*)
    *(.sdata .sdata.*)

    /* section information for finsh shell */
    __fsymtab_start = .;
    KEEP(*(FSymTab))
    __fsymtab_end = .;
    . = ALIGN(8);
    __vsymtab_start = .;
    KEEP(*(VSymTab))
    __vsymtab_end = .;
    . = ALIGN(8);

    /* section information for initial. */
    . = ALIGN(8);
    __rt_init_start = .;
    KEEP(*(SORT(.rti_fn*)))
    __rt_init_end = .;
    . = ALIGN(8);

    __rt_utest_tc_tab_start = .;
    KEEP(*(UtestTcTab))
    __rt_utest_tc_tab_end = .;

    . = ALIGN(8);
    __am_apps_data_start = .;
    *(__am_apps.data*)
    *(__am_apps.sdata*)
    __am_apps_data_end = .;

    . = ALIGN(4);
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
    /* *(.bss.extra) */
    . = ALIGN(8);
    __am_apps_bss_start = .;
    *(__am_apps.bss*)
    *(__am_apps.sbss*)
    *(__am_apps.scommon*)
    __am_apps_bss_end = .;
    . = ALIGN(8);
    
    _bss_end = .;
  } > psram : data

  _heap_start = .;
  _heap_end = ORIGIN(psram) + LENGTH(psram);

  _stack_top = ORIGIN(sram) + LENGTH(sram);
  _stack_pointer = _stack_top;
  _stack_bottom = ORIGIN(sram);


  
  end = .;
  _end = .;
}
