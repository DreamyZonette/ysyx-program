/* 触发器模板 */
// module RegisterFile #(WIDTH = 1, RESET_VAL = 0) (
//   input clk,
//   input rst,
//   input [WIDTH-1:0] din,
//   output reg [WIDTH-1:0] dout,
//   input wen
// );
//   always @(posedge clk) begin
//     if (rst) dout <= RESET_VAL;
//     else if (wen) dout <= din;
//   end
// endmodule

module RegisterFile #(ADDR_WIDTH = 1, DATA_WIDTH = 1) (
  input clk,
  input rst_n,
  input wen,
  input [DATA_WIDTH-1:0] wdata,
  input [ADDR_WIDTH-1:0] waddr,
  input [ADDR_WIDTH-1:0] raddr,
  output [ADDR_WIDTH-1:0] rdata
  
);
  reg [DATA_WIDTH-1:0] rf [2**ADDR_WIDTH-1:0];
  always @(posedge clk) begin
    if (!rst_n) rf[wdata] <= 0;
    else if (wen) rf[waddr] <= wdata;
  end
  assign rdata = rf[raddr];
endmodule

