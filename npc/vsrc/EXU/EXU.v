module EXU(
    input wire [31:0] i_src1,
    input wire [31:0] i_src2,
    input wire [31:0] i_imm,
    input wire [31:0] i_offset,
    input wire [31:0] i_pc_data,
    input wire i_addi_signal,
    input wire i_jalr_signal,
    input wire i_lw_signal,
    input wire i_lbu_signal,
    input wire i_sw_signal,
    input wire i_sb_signal,
    input wire i_auipc_signal,
    input wire i_lui_signal,
    input wire i_add_signal,
    input wire i_ebreak_signal,
    output wire o_halt_signal,
    output wire [31:0] o_data

);

alu alu_u(
    .i_src1(i_src1),
    .i_src2(i_src2),
    .i_imm(i_imm),
    .i_offset(i_offset),
    .i_pc_data(i_pc_data),
    .i_addi_signal(i_addi_signal),
    .i_jalr_signal(i_jalr_signal),
    .i_lw_signal(i_lw_signal),
    .i_lbu_signal(i_lbu_signal),
    .i_sw_signal(i_sw_signal),
    .i_sb_signal(i_sb_signal),
    .i_auipc_signal(i_auipc_signal),
    .i_lui_signal(i_lui_signal),
    .i_add_signal(i_add_signal),
    .i_ebreak_signal(i_ebreak_signal),
    .o_halt_signal(o_halt_signal),
    .o_data(o_data)
);


endmodule
