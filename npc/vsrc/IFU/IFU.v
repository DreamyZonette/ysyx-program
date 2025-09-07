module IFU(
    input clock,
    input [31:0] ifu_raddr,
    output [31:0] o_instruction
);
import "DPI-C" function int pmem_read(input int raddr, input int len);

assign o_instruction = $unsigned(pmem_read(ifu_raddr, 4)); 

// always @(posedge clock) begin
//   ifu_rdata <= pmem_read(pmem_read(ifu_raddr, 4));
// end

endmodule
