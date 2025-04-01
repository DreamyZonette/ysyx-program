module top (
    input clk,
    input reset

);

wire [7:0] op_ins;
wire [31:0] addr;
wire [31:0] pc_next;
wire [31:0] data;
wire [31:0] ram_data;
wire [4:0] rs1;
wire [4:0] rs2;
wire [31:0] imm;
wire [31:0] src1;
wire [31:0] src2;
wire [31:0] result;
wire [4:0] rd;
wire jump_singnal;
wire ram_signal;

ysyx_25020042_pc pc (
    .clk(clk),
    .rst(reset),
    .dout(addr),
    .din(pc_next),
    .jump(jump_singnal)
);

ysyx_25020042_rom rom (
    .clk(clk),
    .addr(addr),
    .data(data)
);

ysyx_25020042_decoder decoder (
    .ins(data),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .imm(imm),
    .instruction(op_ins)
);

ysyx_25020042_gpr gpr (
    .clk(clk),
    .rst(reset),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .data_in(result),
    .src1(src1),
    .src2(src2)
);

ysyx_25020042_alu alu (
    .src1(src1),
    .src2(src2),
    .imm(imm),
    .op_ins(op_ins),
    .out(result),
    .ram_signal(ram_signal),
    .jump_signal(jump_singnal),
    .pc_next(pc_next),
    .ram_data(ram_data)
);

ysyx_25020042_ram ram (
    .clk(clk),
    .rst(reset),
    .data_in(result),
    .addr(addr),
    .byte_en(4'b1111),
    .data_out(ram_data),
    .ram_signal(ram_signal)
);


endmodule
