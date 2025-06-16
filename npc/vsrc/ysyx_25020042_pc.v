/*
 * 
 * PC_LEN： pc的数据位
 * INS_BYTE：指令字节数
 * 
 * jump：   是否跳转
 * din：    跳转地址
 * 
 */

module ysyx_25020042_pc #(PC_LEN = 32, INS_BYTES = 4)(
    input clk,
    input rst,
    input [PC_LEN-1:0] din,
    output reg [PC_LEN-1:0] dout,
    input jump
    );
    
    always @(posedge clk) begin
        if (rst) dout <= 32'h80000000;
        else if (jump) dout <= din;
        else dout <= dout + INS_BYTES;
    end



endmodule


