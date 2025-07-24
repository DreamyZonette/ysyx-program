module IFU(
    input i_sys_slk,
    input [31:0] i_pc,
    output [31:0] o_instruction
);
import "DPI-C" function int pmem_read(input int raddr, input int len);

reg instruction;
// assign o_instruction = $unsigned(pmem_read(i_pc, 4)); 
assign o_instruction = instruction; 

always @(posedge i_sys_slk) begin
    instruction <= $unsigned(pmem_read(i_pc, 4)); 
end


endmodule
