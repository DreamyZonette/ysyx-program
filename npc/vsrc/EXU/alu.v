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
    output wire       o_B_jump_signal,
    output wire [31:0] o_data
    );

    wire [2:0] ALUctrl;
    wire [31:0] adder_out;
    wire [31:0] signed_shift_out;
    wire [31:0] unsigned_shift_out;
    wire [31:0] slt_out;
    wire [31:0] B_out;
    wire [31:0] XOR_out;
    wire [31:0] AND_out;
    wire [31:0] OR_out;
    wire [31:0] data1, data2;
    wire Add;
    wire Logic;
    wire Right;
    wire unsigned_less_than;
    wire signed_less_than;
    wire unsigned_greater_than;
    wire signed_greater_than;
    wire signed_equal;
    wire unsigned_equal;


    assign ALUctrl = (i_addi_signal | i_jalr_signal | i_lb_signal | i_lh_signal |
                    i_lw_signal | i_lbu_signal | i_lhu_signal | i_auipc_signal |
                    i_add_signal | i_sub_signal | i_jal_signal | i_sw_signal |
                    i_sh_signal | i_sb_signal) ? 3'b000 :
                    (i_srai_signal | i_sra_signal) ? 3'b001 :
                    (i_slli_signal | i_srli_signal | i_sll_signal | i_srl_signal ) ? 3'b010 :
                    (i_slti_signal | i_sltiu_signal | i_slt_signal | i_sltu_signal) ? 3'b011 :
                    (i_beq_signal | i_bne_signal | i_blt_signal | i_bge_signal |
                    i_bltu_signal | i_bgeu_signal) ? 3'b100 :
                    (i_xori_signal | i_xor_signal) ? 3'b101 :
                    (i_andi_signal | i_and_signal | i_lui_signal | i_csrrw_signal |
                    i_csrrs_signal | i_ecall_signal | i_mret_signal | i_ebreak_signal) ? 3'b110 :
                    (i_ori_signal | i_or_signal) ? 3'b111 : 
                         3'b000;

    MuxKeyWithDefault #(8, 3, 32) ALU_out (o_data, ALUctrl, 32'b0, {
    3'b000, adder_out,
    3'b001, signed_shift_out,
    3'b010, unsigned_shift_out,
    3'b011, slt_out,
    3'b100, B_out,
    3'b101, XOR_out,
    3'b110, AND_out,
    3'b111, OR_out
  });
  // adder 控制信号
  assign Add = (i_slt_signal | i_sltu_signal | i_slti_signal | i_sltiu_signal |
               i_beq_signal | i_bne_signal | i_blt_signal | i_bge_signal |
               i_bltu_signal | i_bgeu_signal | i_sub_signal) ? 1'b0 : 1'b1;

  assign data1 = (i_auipc_signal | i_jal_signal | i_beq_signal |i_bne_signal |
                 i_blt_signal | i_bge_signal | i_bltu_signal | i_bgeu_signal) ? i_pc_data : 
                 i_lui_signal ? i_imm : i_src1;
  assign data2 = (i_lui_signal | i_csrrw_signal) ? 32'hffffffff :
                 (i_ecall_signal | i_mret_signal | i_ebreak_signal) ? 32'h0 :
                 (i_csrrs_signal) ? i_csr_data : 
                 (i_beq_signal | i_bne_signal | i_blt_signal | i_bge_signal |
                 i_bltu_signal | i_bgeu_signal | i_jal_signal) ? i_offset :
                 (i_add_signal | i_sub_signal | i_and_signal | i_or_signal |
                 i_xor_signal | i_slt_signal | i_sltu_signal | i_sll_signal |
                 i_srl_signal | i_sra_signal) ? i_src2 : 
                 (i_slli_signal | i_srli_signal | i_srai_signal)? {26'b0 ,i_shamt}: i_imm;
  assign Logic = (i_sra_signal | i_srai_signal) ? 1'b0 : 1'b1;
  assign Right = (i_srl_signal | i_srli_signal | i_srai_signal | i_sra_signal) ? 1'b1 : 1'b0;

  assign XOR_out = data1 ^ data2;
  assign AND_out = data1 & data2;
  assign OR_out  = data1 | data2;
  assign slt_out[0] = (i_sltiu_signal & unsigned_less_than) | (i_slti_signal & signed_less_than) |
                      (i_sltu_signal & unsigned_less_than) | (i_slt_signal & signed_less_than);
  assign slt_out[31:1] = 31'b0;
  assign B_out = (i_beq_signal | i_bne_signal | i_blt_signal | i_bge_signal |
                 i_bltu_signal | i_bgeu_signal) ? adder_out : 32'b0;
  assign o_B_jump_signal = (i_beq_signal & unsigned_equal) |
                          (i_bne_signal & ~unsigned_equal) |
                          (i_blt_signal & signed_less_than) |
                          (i_bge_signal & (signed_greater_than | signed_equal)) |
                          (i_bltu_signal & unsigned_less_than) |
                          (i_bgeu_signal & (unsigned_greater_than | unsigned_equal));

  wire cin, overflow;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
  adder adder_u (
    .Add(Add),
    .x(data1),
    .y(data2),
    .sum(adder_out),
    .cout_carry(overflow)
  );

assign unsigned_shift_out = signed_shift_out;
 barrel_shifter_param barrel_shifter_param_u(
    .Logic(Logic),
    .Right(Right),
    .data_i(data1),   
    .shift_amt(data2[4:0]), 
    .data_o(signed_shift_out)     
);

assign unsigned_less_than = ~overflow;
assign unsigned_equal = ~(|adder_out[31:0]);
assign unsigned_greater_than = overflow & (|adder_out);

wire signs_different, sign_x_result_sign_diff;
wire sign_x, sign_y, result_sign, signed_overflow;
assign sign_x = data1[31];
assign sign_y = data2[31];
assign result_sign = adder_out[31];
assign signs_different = sign_x ^ sign_y;
assign sign_x_result_sign_diff = sign_x ^ result_sign;
assign signed_overflow = signs_different & sign_x_result_sign_diff;

assign signed_equal = ~(|adder_out[31:0]);
assign signed_less_than = result_sign ^ signed_overflow;
assign signed_greater_than = ~signed_less_than & ~signed_equal;

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
    
// ArithmeticRightShift ArithmeticRightShift_u(
//     .i_src1(i_src1),
//     .i_shamt(i_shamt),
//     .o_data(srai_result)
// );

endmodule

// module ArithmeticRightShift(
//     input [31:0] i_src1,
//     input [5:0] i_shamt,
//     output  [31:0] o_data
// );
//     wire [4:0] shamt;
//     assign shamt = i_shamt[4:0];
//     MuxKeyWithDefault #(32, 5, 32) i0 (o_data, shamt, 32'b0, {
//     5'b00000, i_src1,
//     5'b00001, {i_src1[31], i_src1[31:1]},
//     5'b00010, {{2{i_src1[31]}}, i_src1[31:2]},
//     5'b00011, {{3{i_src1[31]}}, i_src1[31:3]},
//     5'b00100, {{4{i_src1[31]}}, i_src1[31:4]},
//     5'b00101, {{5{i_src1[31]}}, i_src1[31:5]},
//     5'b00110, {{6{i_src1[31]}}, i_src1[31:6]},
//     5'b00111, {{7{i_src1[31]}}, i_src1[31:7]},
//     5'b01000, {{8{i_src1[31]}}, i_src1[31:8]},
//     5'b01001, {{9{i_src1[31]}}, i_src1[31:9]},
//     5'b01010, {{10{i_src1[31]}}, i_src1[31:10]},
//     5'b01011, {{11{i_src1[31]}}, i_src1[31:11]},
//     5'b01100, {{12{i_src1[31]}}, i_src1[31:12]},
//     5'b01101, {{13{i_src1[31]}}, i_src1[31:13]},
//     5'b01110, {{14{i_src1[31]}}, i_src1[31:14]},
//     5'b01111, {{15{i_src1[31]}}, i_src1[31:15]},
//     5'b10000, {{16{i_src1[31]}}, i_src1[31:16]},
//     5'b10001, {{17{i_src1[31]}}, i_src1[31:17]},
//     5'b10010, {{18{i_src1[31]}}, i_src1[31:18]},
//     5'b10011, {{19{i_src1[31]}}, i_src1[31:19]},
//     5'b10100, {{20{i_src1[31]}}, i_src1[31:20]},
//     5'b10101, {{21{i_src1[31]}}, i_src1[31:21]},
//     5'b10110, {{22{i_src1[31]}}, i_src1[31:22]},
//     5'b10111, {{23{i_src1[31]}}, i_src1[31:23]},
//     5'b11000, {{24{i_src1[31]}}, i_src1[31:24]},
//     5'b11001, {{25{i_src1[31]}}, i_src1[31:25]},
//     5'b11010, {{26{i_src1[31]}}, i_src1[31:26]},
//     5'b11011, {{27{i_src1[31]}}, i_src1[31:27]},
//     5'b11100, {{28{i_src1[31]}}, i_src1[31:28]},
//     5'b11101, {{29{i_src1[31]}}, i_src1[31:29]},
//     5'b11110, {{30{i_src1[31]}}, i_src1[31:30]},
//     5'b11111, {{31{i_src1[31]}}, i_src1[31]}
//   });

// endmodule

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

module adder (
    input Add,
    input [31:0] x,
    input [31:0] y,
    output [31:0] sum,
    output cout_carry
);

wire cin;
wire [31:0] processed_y;
assign cin = Add ? 1'b0 : 1'b1;
assign processed_y = Add ? y : ~y;

adder_32 adder_32_u (
   .x(x),
   .y(processed_y),
   .cin(cin),
   .sum(sum),
   .cout_carry(cout_carry)
);

endmodule

// module comparer_32_unsigned (
//     input [31:0] x,
//     input [31:0] y,
//     output equal,
//     output less_than,
//     output greater_than
// );

// wire [32:0] sub_result;
// wire [31:0] processed_y;
// assign processed_y = ~y;
// assign less_than = ~sub_result[32];
// assign equal = ~(|sub_result[31:0]);
// assign greater_than = sub_result[32] & (|sub_result);

// adder_32 adder_sub (
//    .x(x),
//    .y(processed_y),
//    .cin(1'b1),
//    .sum(sub_result[31:0]),
//    .cout_carry(sub_result[32])
// );

// endmodule

// module comparer_32_signed (
//     input [31:0] x,
//     input [31:0] y,
//     output equal,
//     output less_than,
//     output greater_than
// );

// wire [32:0] sub_result;
// wire [31:0] processed_y;
// wire sign_x, sign_y, result_sign, overflow;
// wire signs_different, sign_x_result_sign_diff;
// wire not_equal;
// assign processed_y = ~y;
// assign sign_x = x[31];
// assign sign_y = y[31];
// assign result_sign = sub_result[31];

// adder_32 adder_sub (
//    .x(x),
//    .y(processed_y),
//    .cin(1'b1),
//    .sum(sub_result[31:0]),
//    .cout_carry(sub_result[32])
// );

// assign signs_different = sign_x ^ sign_y;
// assign sign_x_result_sign_diff = sign_x ^ result_sign;
// assign overflow = signs_different & sign_x_result_sign_diff;

// assign equal = ~(|sub_result[31:0]);
// assign less_than = result_sign ^ overflow;
// assign greater_than = ~less_than & ~equal;

// endmodule

module barrel_shifter_param (
    input  Logic,
    input  Right,
    input  [31:0] data_i,   
    input  [4:0]  shift_amt, 
    output [31:0] data_o     
);

wire sign = Logic ? 1'b0 : data_i[31];

/* verilator lint_off UNUSEDSIGNAL */
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

assign Lstage1 = shift_amt[1] ? {Lstage0[29:0], 2'b0} : stage0;

assign Lstage2 = shift_amt[2] ? {Lstage1[27:0], 4'b0}: stage1;

assign Lstage3 = shift_amt[3] ? {Lstage2[23:0], 8'b0}: stage2;

assign Lstage4 = shift_amt[4] ? {Lstage3[15:0], 16'b0} : stage3;

assign data_o = Right ? stage4 : Lstage4; 
/* verilator lint_on UNUSEDSIGNAL */
endmodule
