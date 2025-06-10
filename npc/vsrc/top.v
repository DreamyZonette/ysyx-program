module top (
    input clk,
    input reset
);

wire [7:0] op_ins;
wire [31:0] addr;
wire [31:0] pc_next;
wire [31:0] cur_data;
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
        if (cur_data == 32'h00100073) begin
            //$finish();
            dpi_ebreak();  // 调用 DPI-C 函数
        end
    end

pc u_pc (
    .clk(clk),
    .rst(reset),
    .dout(addr),
    .din(pc_next),
    .jump(jump_singnal)
);

rom u_rom (
    //.clk(clk),
    .addr(addr),
    .data(cur_data)
);

decoder u_decoder (
    .ins(cur_data),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .imm(imm),
    .instruction(op_ins)
);

gpr u_gpr (
    .clk(clk),
    .rst(reset),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .data_in(result),
    .src1(src1),
    .src2(src2)
);

alu u_alu (
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

ram u_ram (
    .clk(clk),
    .rst(reset),
    .data_in(result),
    .addr(addr),
    .byte_en(4'b1111),
    .data_out(ram_data),
    .ram_signal(ram_signal)
);


endmodule
