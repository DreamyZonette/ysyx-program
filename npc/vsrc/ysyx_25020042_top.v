module top (
    input clk,
    input reset,

);

wire [31:0] instrction;
wire [31:0] pc;
wire [31:0] pc_next;
wire [31:0] data;
wire [4:0] rs1;
wire [4:0] rs2;
wire [31:0] imm;
wire [31:0] result;
wire [4:0] rd;
wire jump_singnal;

ysyx_25020042_pc pc (
    .clk(clk),
    .rst(reset),
    .dout(pc),
    .din(pc_next),
    .jump(jump_singnal)
);

ysyx_25020042_rom rom (
    .addr(pc),
    .data(data)
);

ysyx_25020042_decoder decoder (
    .ins(data),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .imm(imm),
    .instruction(instruction)
);

ysyx_25020042_alu alu (
    .src1(rs1),
    .imm(imm),
    .op_ins(instruction),
    .out(result)
);



endmodule
