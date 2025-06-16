module top (
    input [31:0] inst,
    input clk,
    input reset,
    output [31:0] o_pc
);

wire [7:0] op_ins;
wire [31:0] pc_next;
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
// reg ebreak_signal;

import "DPI-C" function void dpi_ebreak();


// initial begin
//    $display("%x + %x = %x", 1, 2, add(1,2));
// end

always @(posedge clk) begin
        if (inst == 32'h00100073) begin
            dpi_ebreak();  // 调用 DPI-C 函数
        end
    end

ysyx_25020042_pc pc (
    .clk(clk),
    .rst(reset),
    .dout(o_pc),
    .din(pc_next),
    .jump(jump_singnal)
);

ysyx_25020042_decoder decoder (
    .ins(inst),
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
    .addr(o_pc),
    .byte_en(4'b1111),
    .data_out(ram_data),
    .ram_signal(ram_signal)
);


endmodule
