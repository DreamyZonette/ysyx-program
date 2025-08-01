/* 触发器模板 */
module Reg #(WIDTH = 1, RESET_VAL = 0) (
  input clk,
  input sys_rst_n,
  input [WIDTH-1:0] i_data,
  output reg [WIDTH-1:0] o_data,
  input wen
);
  always @(posedge clk) begin
    if (!sys_rst_n) o_data <= RESET_VAL;
    else if (wen) o_data <= i_data;
  end
endmodule


