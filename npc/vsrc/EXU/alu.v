// Modified by Long for NPC
module alu (
    input [31:0] i_src1,
    input [31:0] i_src2,
    input [31:0] i_imm ,
    input [31:0] i_pc_data,
    input             i_addi_signal,
    input             i_jalr_signal,
    input             i_lw_signal,
    input             i_lbu_signal,
    input             i_sw_signal,
    input             i_sb_signal,
    input             i_auipc_signal,
    input             i_lui_signal,
    input             i_add_signal,
    input             i_ebreak_signal,
    output reg        o_halt_signal,
    output reg [31:0] o_data
    );

    always @ (*) begin
        o_data = 32'b0;
        o_halt_signal = 1'b0;
        // I型
        if(i_addi_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_jalr_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lw_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lbu_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
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
        // S型
        end else if(i_sw_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_sb_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end 
        else begin
            //o_halt_signal = 1'b1;
            o_data = 32'b0;         // 无操作
            o_halt_signal = 1'b0;   // 不停止
        end
    end

endmodule
