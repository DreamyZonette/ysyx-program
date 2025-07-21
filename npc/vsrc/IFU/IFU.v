module IFU(
    input [31:0] i_pc,
    output [31:0] o_instruction
);
import "DPI-C" function int pmem_read(input int raddr, input int len);

// assign o_instruction = pmem_read(i_pc, 4);
assign o_instruction = 32'h00000013;
endmodule
