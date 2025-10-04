/* 触发器模板 */
module ysyx_25020042_Reg #(WIDTH = 1, RESET_VAL = 0) (
  input clk,
  input reset,
  input [WIDTH-1:0] i_data,
  output reg [WIDTH-1:0] o_data,
  input wen
);
  always @(posedge clk) begin
    if (reset) o_data <= RESET_VAL;
    else if (wen) o_data <= i_data;
  end
endmodule


