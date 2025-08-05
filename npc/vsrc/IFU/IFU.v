module IFU(
    input [31:0] i_pc,
    output [31:0] o_instruction
);
// import "DPI-C" function int pmem_read(input int raddr, input int len);

// assign o_instruction = $unsigned(pmem_read(i_pc, 4)); 

// 用来测试npc
rom rom_u(
    .addr(i_pc),
    .rdata(o_instruction)
);

endmodule
