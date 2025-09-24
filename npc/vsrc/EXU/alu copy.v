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
    output reg [31:0] o_data
    );

    wire [31:0] data1, data2;

    // /*---old code---*/
    // wire [31:0] srai_result;

    // always @ (*) begin
    //     o_data = 32'b0;
    //     o_B_jump_signal = 1'b0;
    //     // I型
    //     if(i_addi_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end else if(i_jalr_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end else if(i_lb_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end else if(i_lh_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end else if(i_lw_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end else if(i_lbu_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end else if(i_lhu_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end else if(i_xori_signal == 1'b1) begin
    //         o_data = i_src1 ^ i_imm;
    //     end else if(i_ori_signal == 1'b1) begin
    //         o_data = i_src1 | i_imm;
    //     end else if(i_andi_signal == 1'b1) begin
    //         o_data = i_src1 & i_imm;
    //     end else if(i_slli_signal == 1'b1) begin
    //         o_data = i_src1 << i_shamt;
    //     end else if(i_srli_signal == 1'b1) begin
    //         o_data = i_src1 >> i_shamt;
    //     end else if(i_srai_signal == 1'b1) begin
    //         o_data = srai_result;
    //         // $strobe("alu: srai %08x\n", srai_result);
    //     end else if(i_slti_signal == 1'b1) begin
    //         o_data = $signed(i_src1) < $signed(i_imm) ? 32'h1 : 32'h0;
    //     end else if(i_sltiu_signal == 1'b1) begin
    //         o_data = i_src1 < i_imm ? 32'h1 : 32'h0;
    //     end else if(i_csrrw_signal == 1'b1) begin
    //         o_data = i_src1;
    //     end else if(i_csrrs_signal == 1'b1) begin
    //         o_data = i_csr_data | i_src1;
    //     end else if(i_ecall_signal == 1'b1) begin
    //         o_data = 0;
    //     end else if(i_mret_signal == 1'b1) begin
    //         o_data = 0;
    //     end else if(i_ebreak_signal == 1'b1) begin
    //         o_data = 0;
    //     // U型
    //     end else if(i_auipc_signal == 1'b1) begin
    //         o_data = i_pc_data + i_imm;
    //     end else if(i_lui_signal == 1'b1) begin
    //         o_data = i_imm;
    //     // R型
    //     end else if(i_add_signal == 1'b1) begin
    //         o_data = i_src1 + i_src2;
    //     end else if(i_sub_signal == 1'b1) begin
    //         o_data = i_src1 - i_src2;
    //     end else if(i_and_signal == 1'b1) begin
    //         o_data = i_src1 & i_src2;
    //     end else if(i_or_signal == 1'b1) begin
    //         o_data = i_src1 | i_src2;
    //     end else if(i_xor_signal == 1'b1) begin
    //         o_data = i_src1 ^ i_src2;
    //     end else if(i_slt_signal == 1'b1) begin
    //         o_data = $signed(i_src1) < $signed(i_src2) ? 32'h1 : 32'h0;
    //     end else if(i_sltu_signal == 1'b1) begin
    //         o_data = i_src1 < i_src2 ? 32'h1 : 32'h0;
    //     end else if(i_sll_signal == 1'b1) begin
    //         o_data = i_src1 << i_src2[4:0];
    //     end else if(i_srl_signal == 1'b1) begin
    //         o_data = i_src1 >> i_src2[4:0];
    //     end else if(i_sra_signal == 1'b1) begin
    //         o_data = $signed(i_src1) >>> i_src2[4:0];
    //     // B型
    //     end else if(i_beq_signal == 1'b1) begin
    //         o_B_jump_signal = (i_src1 == i_src2) ? 1'b1 : 1'b0;
    //         o_data = i_pc_data + i_offset;
    //     end else if(i_bne_signal == 1'b1) begin
    //         o_B_jump_signal = (i_src1!= i_src2) ? 1'b1 : 1'b0;
    //         o_data = i_pc_data + i_offset;
    //     end else if(i_blt_signal == 1'b1) begin
    //         o_B_jump_signal = ($signed(i_src1) < $signed(i_src2)) ? 1'b1 : 1'b0;
    //         o_data = i_pc_data + i_offset;
    //     end else if(i_bge_signal == 1'b1) begin
    //         o_B_jump_signal = ($signed(i_src1) >= $signed(i_src2)) ? 1'b1 : 1'b0;
    //         o_data = i_pc_data + i_offset;
    //     end else if(i_bltu_signal == 1'b1) begin
    //         o_B_jump_signal = (i_src1 < i_src2) ? 1'b1 : 1'b0;
    //         o_data = i_pc_data + i_offset;
    //     end else if(i_bgeu_signal == 1'b1) begin
    //         o_B_jump_signal = (i_src1 >= i_src2) ? 1'b1 : 1'b0;
    //         o_data = i_pc_data + i_offset;
    //     end
    //     // J型
    //     else if(i_jal_signal == 1'b1) begin
    //         o_data = i_pc_data + i_offset;
    //     // S型
    //     end else if(i_sw_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end else if(i_sh_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end else if(i_sb_signal == 1'b1) begin
    //         o_data = i_src1 + i_imm;
    //     end 
    //     else begin
    //         o_data = 32'b0;         // 无操作
    //         o_B_jump_signal = 1'b0;
    //     end
    // end
    
ArithmeticRightShift ArithmeticRightShift_u(
    .i_src1(i_src1),
    .i_shamt(i_shamt),
    .o_data(srai_result)
);

endmodule

module ArithmeticRightShift(
    input [31:0] i_src1,
    input [5:0] i_shamt,
    output  [31:0] o_data
);

    MuxKeyWithDefault #(32, 6, 32) i0 (o_data, i_shamt, 32'b0, {
    6'b000000, i_src1,
    6'b000001, {i_src1[31], i_src1[31:1]},
    6'b000010, {{2{i_src1[31]}}, i_src1[31:2]},
    6'b000011, {{3{i_src1[31]}}, i_src1[31:3]},
    6'b000100, {{4{i_src1[31]}}, i_src1[31:4]},
    6'b000101, {{5{i_src1[31]}}, i_src1[31:5]},
    6'b000110, {{6{i_src1[31]}}, i_src1[31:6]},
    6'b000111, {{7{i_src1[31]}}, i_src1[31:7]},
    6'b001000, {{8{i_src1[31]}}, i_src1[31:8]},
    6'b001001, {{9{i_src1[31]}}, i_src1[31:9]},
    6'b001010, {{10{i_src1[31]}}, i_src1[31:10]},
    6'b001011, {{11{i_src1[31]}}, i_src1[31:11]},
    6'b001100, {{12{i_src1[31]}}, i_src1[31:12]},
    6'b001101, {{13{i_src1[31]}}, i_src1[31:13]},
    6'b001110, {{14{i_src1[31]}}, i_src1[31:14]},
    6'b001111, {{15{i_src1[31]}}, i_src1[31:15]},
    6'b010000, {{16{i_src1[31]}}, i_src1[31:16]},
    6'b010001, {{17{i_src1[31]}}, i_src1[31:17]},
    6'b010010, {{18{i_src1[31]}}, i_src1[31:18]},
    6'b010011, {{19{i_src1[31]}}, i_src1[31:19]},
    6'b010100, {{20{i_src1[31]}}, i_src1[31:20]},
    6'b010101, {{21{i_src1[31]}}, i_src1[31:21]},
    6'b010110, {{22{i_src1[31]}}, i_src1[31:22]},
    6'b010111, {{23{i_src1[31]}}, i_src1[31:23]},
    6'b011000, {{24{i_src1[31]}}, i_src1[31:24]},
    6'b011001, {{25{i_src1[31]}}, i_src1[31:25]},
    6'b011010, {{26{i_src1[31]}}, i_src1[31:26]},
    6'b011011, {{27{i_src1[31]}}, i_src1[31:27]},
    6'b011100, {{28{i_src1[31]}}, i_src1[31:28]},
    6'b011101, {{29{i_src1[31]}}, i_src1[31:29]},
    6'b011110, {{30{i_src1[31]}}, i_src1[31:30]},
    6'b011111, {{31{i_src1[31]}}, i_src1[31]}
  });

endmodule

module full_1_adder (
    input x,
    input y,
    input cin,
    output sum,
    output cout
);

    assign sum = x ^ y ^ cin;
    assign cout = (x & y) | (cin & (x ^ y));

endmodule

module adder_32 (
    input [31:0] x,
    input [31:0] y,
    input cin,
    output [31:0] sum,
    output cout_carry
);
    wire [31:0] cout;
    assign cout_carry = cout[31];

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : adder_32_gen
            full_1_adder adder_i (
               .x(x[i]),
               .y(y[i]),
               .cin(i == 0 ? cin : cout[i-1]),
               .sum(sum[i]),
               .cout(cout[i])
            );
        end
    endgenerate

endmodule

module comparer_32_unsigned (
    input [31:0] x,
    input [31:0] y,
    output equal,
    output less_than,
    output greater_than
);

wire [32:0] sub_result;
wire [31:0] processed_y;
assign processed_y = ~y;
assign less_than = ~sub_result[32];
assign equal = ~(|sub_result[31:0]);
assign greater_than = sub_result[32] & (|sub_result);

adder_32 adder_sub (
   .x(x),
   .y(processed_y),
   .cin(1'b1),
   .sum(sub_result[31:0]),
   .cout_carry(sub_result[32])
);

endmodule

module comparer_32_signed (
    input [31:0] x,
    input [31:0] y,
    output equal,
    output less_than,
    output greater_than
);

wire [32:0] sub_result;
wire [31:0] processed_y;
wire sign_x, sign_y, result_sign, overflow;
wire signs_different, sign_x_result_sign_diff;
wire not_equal;
assign processed_y = ~y;
assign sign_x = x[31];
assign sign_y = y[31];
assign result_sign = sub_result[31];

adder_32 adder_sub (
   .x(x),
   .y(processed_y),
   .cin(1'b1),
   .sum(sub_result[31:0]),
   .cout_carry(sub_result[32])
);

assign signs_different = sign_x ^ sign_y;
assign sign_x_result_sign_diff = sign_x ^ result_sign;
assign overflow = signs_different & sign_x_result_sign_diff;

assign equal = ~(|sub_result[31:0]);
assign less_than = result_sign ^ overflow;
assign greater_than = ~less_than & ~equal;

endmodule

