module IFU(
    input i_sys_clk,
    input [31:0] i_pc,
    output reg [31:0] o_instruction
);
import "DPI-C" function int pmem_read(input int raddr, input int len);
reg [31:0] instruction;
assign instruction = pmem_read(i_pc, 4);

always @(posedge i_sys_clk) begin
    o_instruction <= instruction;
end

endmodule
