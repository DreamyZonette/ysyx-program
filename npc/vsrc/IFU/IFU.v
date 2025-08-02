module IFU(
    // input i_sys_clk,
    input [31:0] i_pc,
    output [31:0] o_instruction
);
import "DPI-C" function int pmem_read(input int raddr, input int len);

// reg [31:0] instruction;
assign o_instruction = $unsigned(pmem_read(i_pc, 4)); 
// assign o_instruction = instruction; 

// always @(negedge i_sys_clk) begin
//     instruction <= $unsigned(pmem_read(i_pc, 4)); 
// end


endmodule
