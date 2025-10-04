/* verilator lint_off DECLFILENAME */
module ysyx_25020042_IDU (
    input   [31:0]  i_inst,
    output wire [31:0]  o_imm,
    output wire [31:0]  o_offset,
    output wire [5:0]   o_shamt,
    output     [3:0]  o_wmask,
    output     [11:0]  o_csr_addr,
    output  o_addi_signal,
    output  o_andi_signal,
    output  o_xori_signal,
    output  o_ori_signal,
    output  o_ebreak_signal,
    output  o_jalr_signal,
    output  o_lbu_signal,
    output  o_lw_signal,
    output  o_auipc_signal,
    output  o_lui_signal,
    output  o_lb_signal,
    output  o_lh_signal,
    output  o_lhu_signal,
    output  o_srai_signal,
    output  o_slli_signal,
    output  o_sb_signal,
    output  o_slti_signal,
    output  o_sltiu_signal,
    output  o_srli_signal,
    output  o_sll_signal,
    output  o_jal_signal,
    output  o_sw_signal,
    output  o_add_signal,
    output  o_and_signal,
    output  o_or_signal,
    output  o_xor_signal,
    output  o_sub_signal,
    output  o_slt_signal,
    output  o_sltu_signal,
    output  o_sra_signal,
    output  o_srl_signal,
    output  o_beq_signal,
    output  o_bne_signal,
    output  o_bge_signal,
    output  o_bgeu_signal,
    output  o_blt_signal,
    output  o_bltu_signal,
    output  o_sh_signal,
    output  o_csrrs_signal,
    output  o_csrrw_signal,
    output  o_ecall_signal,
    output  o_mret_signal,
    output  o_unknown_signal,
    output wire [4:0] rd,
    output wire [4:0] rs1,
    output wire [4:0] rs2
    );

    wire [6:0]  opcode;
    wire [31:0] J_offset;
    wire [31:0] I_imm;
    wire [4:0]  I_rs1;
    wire [4:0]  I_rd;
    wire [5:0]  I_shamt;
    wire [4:0]  U_rd;
    wire [31:0] U_imm;
    wire [4:0]  J_rd;
    wire [4:0]  S_rs1;
    wire [4:0]  S_rs2;
    wire [31:0] S_imm;
    wire [4:0]  R_rd;
    wire [4:0]  R_rs1;
    wire [4:0]  R_rs2;
    wire [4:0]  B_rs1;
    wire [4:0]  B_rs2;
    wire [31:0] B_offset;
    wire J_halt_signal;
    wire S_halt_signal;
    wire R_halt_signal;
    wire I_halt_signal;
    wire U_halt_signal;
    wire B_halt_signal;
    reg Btype_signal;
    reg Itype_signal;
    reg Jtype_signal;
    reg Rtype_signal;
    reg Stype_signal;
    reg Utype_signal;
    reg invalid_opcode_signal;

    assign opcode = i_inst[6:0];
    assign o_unknown_signal = (invalid_opcode_signal | 
        (J_halt_signal & Jtype_signal)| (S_halt_signal & Stype_signal) | 
        (R_halt_signal & Rtype_signal)| (I_halt_signal & Itype_signal) | 
        (U_halt_signal & Utype_signal)| (B_halt_signal & Btype_signal));

    //根据操作码判断类型
    always @ (*) begin
        Btype_signal = 1'b0;
        Itype_signal = 1'b0;
        Jtype_signal = 1'b0;
        Rtype_signal = 1'b0;
        Stype_signal = 1'b0;
        Utype_signal = 1'b0;
        invalid_opcode_signal = 1'b0;
        case(opcode)
        // I型
            7'b1100111:begin
                Itype_signal = 1'b1;
            end
            7'b0000011:begin
                Itype_signal = 1'b1;
            end
            7'b0010011:begin
                Itype_signal = 1'b1;
            end
            7'b0001111:begin
                Itype_signal = 1'b1;
            end
            7'b1110011:begin
                Itype_signal = 1'b1;
            end
        // J型
            7'b1101111:begin
                Jtype_signal = 1'b1;
            end
        // U型
            7'b0110111:begin
                Utype_signal = 1'b1;
            end
            7'b0010111:begin
                Utype_signal = 1'b1;
            end
        // B型
            7'b1100011:begin
                Btype_signal = 1'b1;
            end
        // R型
            7'b0110011:begin
                Rtype_signal = 1'b1;
            end
        // S型
            7'b0100011:begin
                Stype_signal = 1'b1;
            end
            default: begin
                invalid_opcode_signal = 1'b1;
            end
        endcase
    end
//     MuxKeyWithDefault #(8, 3, 32) ALU_out (o_data, ALUctrl, 32'b0, {
//     3'b000, adder_out,
//     3'b001, signed_shift_out,
//     3'b010, unsigned_shift_out,
//     3'b011, slt_out,
//     3'b100, B_out,
//     3'b101, XOR_out,
//     3'b110, AND_out,
//     3'b111, OR_out
//   });
    ysyx_25020042_MuxKeyWithDefault #(3, 3, 32) imm_out (o_imm, {Itype_signal, Utype_signal, Stype_signal}, 32'b0, {
    3'b100, I_imm,
    3'b010, U_imm,
    3'b001, S_imm
  });
    ysyx_25020042_MuxKeyWithDefault #(4, 4, 5) rs1_out (rs1, {Itype_signal, Btype_signal, Stype_signal, Rtype_signal}, 5'b0, {
    4'b1000, I_rs1,
    4'b0100, B_rs1,
    4'b0010, S_rs1,
    4'b0001, R_rs1
  });
    ysyx_25020042_MuxKeyWithDefault #(3, 3, 5) rs2_out (rs2, {Btype_signal, Stype_signal, Rtype_signal}, 5'b0, {
    3'b100, B_rs2,
    3'b010, S_rs2,
    3'b001, R_rs2
  });
    ysyx_25020042_MuxKeyWithDefault #(4, 4, 5) rd_out (rd, {Itype_signal, Utype_signal, Jtype_signal, Rtype_signal}, 5'b0, {
    4'b1000, I_rd,
    4'b0100, U_rd,
    4'b0010, J_rd,
    4'b0001, R_rd
  });
    ysyx_25020042_MuxKeyWithDefault #(2, 2, 32) offset_out (o_offset, {Btype_signal, Jtype_signal}, 32'b0, {
    2'b10, B_offset,
    2'b01, J_offset
  });
  assign o_shamt = Itype_signal ? I_shamt : 6'b0;

    ysyx_25020042_Itype Itype_u(
        .i_inst(i_inst),
        .o_imm(I_imm),
        .o_rs1(I_rs1),
        .o_shamt(I_shamt),
        .o_rd(I_rd),
        .o_csr_addr(o_csr_addr),
        .o_addi_signal(o_addi_signal),
        .o_ebreak_signal(o_ebreak_signal),
        .o_jalr_signal(o_jalr_signal),
        .o_lbu_signal(o_lbu_signal),
        .o_lw_signal(o_lw_signal),
        .o_slli_signal(o_slli_signal),
        .o_srai_signal(o_srai_signal),
        .o_srli_signal(o_srli_signal),
        .o_lb_signal(o_lb_signal),
        .o_lh_signal(o_lh_signal),
        .o_lhu_signal(o_lhu_signal),
        .o_andi_signal(o_andi_signal),
        .o_xori_signal(o_xori_signal),
        .o_ori_signal(o_ori_signal),
        .o_slti_signal(o_slti_signal),
        .o_sltiu_signal(o_sltiu_signal),
        .o_csrrs_signal(o_csrrs_signal),
        .o_csrrw_signal(o_csrrw_signal),
        .o_ecall_signal(o_ecall_signal),
        .o_mret_signal(o_mret_signal), // 原本是Rtype_u的输出
        .o_halt_signal(I_halt_signal)
    );
    ysyx_25020042_Utype Utype_u(
        .i_inst(i_inst),
        .o_rd(U_rd),
        .o_imm(U_imm),
        .o_auipc_signal(o_auipc_signal),
        .o_lui_signal(o_lui_signal),
        .o_halt_signal(U_halt_signal)
    );
    ysyx_25020042_Btype Btype_u(
        .i_inst(i_inst),
        .o_rs1(B_rs1),
        .o_rs2(B_rs2),
        .o_offset(B_offset),
        .o_beq_signal(o_beq_signal),
        .o_bne_signal(o_bne_signal),
        .o_bge_signal(o_bge_signal),
        .o_bgeu_signal(o_bgeu_signal),
        .o_blt_signal(o_blt_signal),
        .o_bltu_signal(o_bltu_signal),
        .o_halt_signal(B_halt_signal)
    );
    ysyx_25020042_Jtype Jtype_u(
        .i_inst(i_inst),
        .o_offset(J_offset),
        .o_rd(J_rd),
        .o_jal_signal(o_jal_signal),
        .o_halt_signal(J_halt_signal)
    );
    ysyx_25020042_Stype Stype_u(
    .i_inst(i_inst),
    .o_rs1(S_rs1),
    .o_rs2(S_rs2),
    .o_imm(S_imm),
    .o_sw_signal(o_sw_signal),
    .o_sb_signal(o_sb_signal),
    .o_sh_signal(o_sh_signal),
    .o_halt_signal(S_halt_signal),
    .o_wmask(o_wmask)
    );
    ysyx_25020042_Rtype Rtype_u(
    .i_inst(i_inst),
    .o_rd(R_rd),
    .o_rs1(R_rs1),
    .o_rs2(R_rs2),
    .o_add_signal(o_add_signal),
    .o_and_signal(o_and_signal),
    .o_or_signal(o_or_signal),
    .o_xor_signal(o_xor_signal),
    .o_sub_signal(o_sub_signal),
    .o_slt_signal(o_slt_signal),
    .o_sltu_signal(o_sltu_signal),
    .o_sll_signal(o_sll_signal),
    .o_sra_signal(o_sra_signal),
    .o_srl_signal(o_srl_signal),
    .o_halt_signal(R_halt_signal)
    );

    endmodule

/* verilator lint_on DECLFILENAME */
