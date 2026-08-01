`timescale 1ns/1ns 

module ysyx_25020042_alu (
    input [31:0] data1,
    input [31:0] data2,
    input [3:0] ALUctrl,
    output reg [31:0] o_data
);

wire [31:0] adder_out;
wire [31:0] shift_out;
wire        less_out;
wire        is_right;
assign is_right = ALUctrl[2:0] == 3'b101;

always @(*) begin
    o_data = 32'h00000000;
    case (ALUctrl[2:0])
        3'b000: o_data = adder_out;
        3'b001: o_data = shift_out;
        3'b010: o_data = {31'b0, less_out};
        3'b011: o_data = data2;
        3'b100: o_data = data1 ^ data2;
        3'b101: o_data = shift_out;
        3'b110: o_data = data1 | data2;
        3'b111: o_data = data1 & data2;
    endcase
end

adder u_adder (
    .Add(~ALUctrl[3]),
    .x(data1),
    .y(data2),
    .sum(adder_out)
);

barrel_shifter_param u_shift (
    .logic_en(~ALUctrl[3]),
    .Right(is_right),
    .data_i(data1),   
    .shift_amt(data2[4:0]), 
    .data_o(shift_out)  
);

comparer u_comparer (
    .sign(~ALUctrl[3]),
    .x(data1),
    .y(data2),
    .less_out(less_out)
);

endmodule

module comparer (
    input sign,
    input [31:0] x,
    input [31:0] y,
    output        less_out
);
// 翻转符号位把有符号比较变成无符号比较，避免 $signed，面积更小
wire [31:0] x_cmp = {x[31] ^ sign, x[30:0]};
wire [31:0] y_cmp = {y[31] ^ sign, y[30:0]};
assign less_out = (x_cmp < y_cmp) ? 1'b1 : 1'b0;

endmodule

module adder (
    input Add,
    input [31:0] x,
    input [31:0] y,
    output wire [31:0] sum
);

assign sum = Add ? x + y : x + ~y + 1;

endmodule

module barrel_shifter_param (
    input  logic_en,
    input  Right,
    input  [31:0] data_i,   
    input  [4:0]  shift_amt, 
    output [31:0] data_o     
);

wire sign = logic_en ? 1'b0 : data_i[31];

wire [31:0] stage0, stage1, stage2, stage3, stage4;
wire [31:0] Lstage0, Lstage1, Lstage2, Lstage3, Lstage4;
// 右
assign stage0 = shift_amt[0] ? {sign, data_i[31:1]} : data_i;

assign stage1 = shift_amt[1] ? {{2{sign}}, stage0[31:2]} : stage0;

assign stage2 = shift_amt[2] ? {{4{sign}}, stage1[31:4]} : stage1;

assign stage3 = shift_amt[3] ? {{8{sign}}, stage2[31:8]} : stage2;

assign stage4 = shift_amt[4] ? {{16{sign}}, stage3[31:16]} : stage3;
// 左
assign Lstage0 = shift_amt[0] ? {data_i[30:0], 1'b0} : data_i;

assign Lstage1 = shift_amt[1] ? {Lstage0[29:0], 2'b0} : Lstage0;

assign Lstage2 = shift_amt[2] ? {Lstage1[27:0], 4'b0}: Lstage1;

assign Lstage3 = shift_amt[3] ? {Lstage2[23:0], 8'b0}: Lstage2;

assign Lstage4 = shift_amt[4] ? {Lstage3[15:0], 16'b0} : Lstage3;

assign data_o = Right ? stage4 : Lstage4; 
endmodule
