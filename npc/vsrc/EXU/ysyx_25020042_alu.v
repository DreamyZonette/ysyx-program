

module ysyx_25020042_alu (
    input [31:0] data1,
    input [31:0] data2,
    input [3:0] ALUctrl,
    output reg [31:0] o_data
);

wire [31:0] adder_out;
wire [31:0] shift_out;
wire [31:0] less_out;

always @(*) begin
    case (ALUctrl[2:0])
        3'b000: o_data = adder_out;
        3'b001: o_data = shift_out;
        3'b010: o_data = less_out;
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
    .Logic(~ALUctrl[3]),
    .Right(ALUctrl[2:0] == 3'b101),
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
    output reg [31:0]less_out
);
always @(*) begin
    if (sign) begin
        less_out = $signed(x) < $signed(y) ? 32'h00000001 : 32'h00000000;
    end else begin
        less_out = x < y ? 32'h00000001 : 32'h00000000;
    end
end

endmodule

module adder (
    input Add,
    input [31:0] x,
    input [31:0] y,
    output reg [31:0] sum
);

always @(*) begin
    if (Add)
        sum = x + y;
    else
        sum = x + ~y + 1;
end

endmodule

module barrel_shifter_param (
    input  Logic,
    input  Right,
    input  [31:0] data_i,   
    input  [4:0]  shift_amt, 
    output [31:0] data_o     
);

wire sign = Logic ? 1'b0 : data_i[31];

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
