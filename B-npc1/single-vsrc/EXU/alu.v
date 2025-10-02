// Modified by Long for NPC
module alu (
    input [31:0] i_src1,
    input [31:0] i_src2,
    input [31:0] i_imm ,
    input [31:0] i_offset,
    input [31:0] i_pc_data,
    input [5:0]       i_shamt,
    input [31:0]      i_csr_data,
    input             i_addi_signal,
    input             i_jalr_signal,
    input             i_lb_signal,
    input             i_lh_signal,
    input             i_lw_signal,
    input             i_lbu_signal,
    input             i_lhu_signal,
    input             i_xori_signal,
    input             i_ori_signal,
    input             i_andi_signal,
    input             i_slli_signal,
    input             i_srli_signal,
    input             i_srai_signal,
    input             i_slti_signal,
    input             i_sltiu_signal,
    input             i_beq_signal,
    input             i_bne_signal,
    input             i_blt_signal,
    input             i_bge_signal,
    input             i_bltu_signal,
    input             i_bgeu_signal,
    input             i_jal_signal,
    input             i_sw_signal,
    input             i_sh_signal,
    input             i_sb_signal,
    input             i_and_signal,
    input             i_or_signal,
    input             i_xor_signal,
    input             i_srl_signal,
    input             i_sra_signal,
    // input             i_mul_signal,
    // input             i_mulh_signal,
    // input             i_mulhu_signal,
    // input             i_mulhsu_signal,
    // input             i_div_signal,
    // input             i_divu_signal,
    // input             i_rem_signal,
    // input             i_remu_signal,
    input             i_auipc_signal,
    input             i_lui_signal,
    input             i_add_signal,
    input             i_sub_signal,
    input             i_sll_signal,
    input             i_slt_signal,
    input             i_sltu_signal,
    input             i_ebreak_signal,
    input             i_csrrs_signal,
    input             i_csrrw_signal,
    input             i_ecall_signal,
    input             i_mret_signal,
    output reg        o_B_jump_signal,
    output reg        o_halt_signal,
    output reg [31:0] o_data
    );

    wire [31:0] srai_result;

    always @ (*) begin
        o_data = 32'b0;
        o_B_jump_signal = 1'b0;
        o_halt_signal = 1'b0;
        // I型
        if(i_addi_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_jalr_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lb_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lh_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lw_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lbu_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lhu_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_xori_signal == 1'b1) begin
            o_data = i_src1 ^ i_imm;
        end else if(i_ori_signal == 1'b1) begin
            o_data = i_src1 | i_imm;
        end else if(i_andi_signal == 1'b1) begin
            o_data = i_src1 & i_imm;
        end else if(i_slli_signal == 1'b1) begin
            o_data = i_src1 << i_shamt;
        end else if(i_srli_signal == 1'b1) begin
            o_data = i_src1 >> i_shamt;
        end else if(i_srai_signal == 1'b1) begin
            o_data = srai_result;
        end else if(i_slti_signal == 1'b1) begin
            o_data = $signed(i_src1) < $signed(i_imm) ? 32'h1 : 32'h0;
        end else if(i_sltiu_signal == 1'b1) begin
            o_data = i_src1 < i_imm ? 32'h1 : 32'h0;
        end else if(i_csrrw_signal == 1'b1) begin
            o_data = i_src1;
        end else if(i_csrrs_signal == 1'b1) begin
            o_data = i_csr_data | i_src1;
        end else if(i_ecall_signal == 1'b1) begin
            o_data = 0;
        end else if(i_mret_signal == 1'b1) begin
            o_data = 0;
        end else if(i_ebreak_signal == 1'b1) begin
            o_data = 0;
        // U型
        end else if(i_auipc_signal == 1'b1) begin
            o_data = i_pc_data + i_imm;
        end else if(i_lui_signal == 1'b1) begin
            o_data = i_imm;
        // R型
        end else if(i_add_signal == 1'b1) begin
            o_data = i_src1 + i_src2;
        end else if(i_sub_signal == 1'b1) begin
            o_data = i_src1 - i_src2;
        end else if(i_and_signal == 1'b1) begin
            o_data = i_src1 & i_src2;
        end else if(i_or_signal == 1'b1) begin
            o_data = i_src1 | i_src2;
        end else if(i_xor_signal == 1'b1) begin
            o_data = i_src1 ^ i_src2;
        end else if(i_slt_signal == 1'b1) begin
            o_data = $signed(i_src1) < $signed(i_src2) ? 32'h1 : 32'h0;
        end else if(i_sltu_signal == 1'b1) begin
            o_data = i_src1 < i_src2 ? 32'h1 : 32'h0;
        end else if(i_sll_signal == 1'b1) begin
            o_data = i_src1 << i_src2[4:0];
        end else if(i_srl_signal == 1'b1) begin
            o_data = i_src1 >> i_src2[4:0];
        end else if(i_sra_signal == 1'b1) begin
            o_data = $signed(i_src1) >>> i_src2[4:0];
        // end else if(i_mul_signal == 1'b1) begin
        //     o_data = i_src1 * i_src2;
        // end else if(i_mulh_signal == 1'b1) begin
        //     o_data = $signed(i_src1) * $signed(i_src2) >> 32;
        // end else if(i_mulhu_signal == 1'b1) begin
        //     o_data = i_src1 * i_src2 >> 32;
        // end else if(i_mulhsu_signal == 1'b1) begin
        //     o_data = $signed(i_src1) * i_src2 >> 32;
        // end else if(i_div_signal == 1'b1) begin
        //     o_data = $signed(i_src1) / $signed(i_src2);
        // end else if(i_divu_signal == 1'b1) begin
        //     o_data = i_src1 / i_src2;
        // end else if(i_rem_signal == 1'b1) begin
        //     o_data = $signed(i_src1) % $signed(i_src2);
        // end else if(i_remu_signal == 1'b1) begin
        //     o_data = i_src1 % i_src2;
        // B型
        end else if(i_beq_signal == 1'b1) begin
            o_B_jump_signal = (i_src1 == i_src2) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_bne_signal == 1'b1) begin
            o_B_jump_signal = (i_src1!= i_src2) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_blt_signal == 1'b1) begin
            o_B_jump_signal = ($signed(i_src1) < $signed(i_src2)) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_bge_signal == 1'b1) begin
            o_B_jump_signal = ($signed(i_src1) >= $signed(i_src2)) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_bltu_signal == 1'b1) begin
            o_B_jump_signal = (i_src1 < i_src2) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_bgeu_signal == 1'b1) begin
            o_B_jump_signal = (i_src1 >= i_src2) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end
        // J型
        else if(i_jal_signal == 1'b1) begin
            o_data = i_pc_data + i_offset;
        // S型
        end else if(i_sw_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_sh_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_sb_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end 
        else begin
            //o_halt_signal = 1'b1;
            o_data = 32'b0;         // 无操作
            o_B_jump_signal = 1'b0;
            o_halt_signal = 1'b0;   // 不停止
        end
    end
    
ArithmeticRightShift ArithmeticRightShift_u(
    .i_src1(i_src1),
    .i_shamt(i_shamt),
    .o_data(srai_result)
);

endmodule
