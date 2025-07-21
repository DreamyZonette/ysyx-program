module IFU(
    input [31:0] i_pc,
    output [31:0] o_instruction
);
import "DPI-C" function uint32_t pmem_read(input uint32_t raddr, int len);

assign o_instruction = pmem_read(i_pc, 4);

endmodule
