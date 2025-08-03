/* 触发器模板 */
module Reg #(WIDTH = 1) (
  input clk,
  input sys_rst_n,
  input wen,
  input [WIDTH-1:0] i_data,
  output reg [WIDTH-1:0] o_data
);
  always @(posedge clk) begin
    if (!sys_rst_n) o_data <= 0;
    else if (wen) o_data <= i_data;
  end
endmodule


