module Rtype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output [4:0] o_rs1,
    output [4:0] o_rs2,
    output reg o_add_signal,
    output reg o_and_signal,
    output reg o_or_signal,
    output reg o_xor_signal,
    output reg o_sub_signal,
    output reg o_slt_signal,
    output reg o_sltu_signal,
    // output reg o_mul_signal,
    // output reg o_mulh_signal,
    // output reg o_mulhu_signal,
    // output reg o_mulhsu_signal,
    // output reg o_div_signal,
    // output reg o_divu_signal,
    // output reg o_rem_signal,
    // output reg o_remu_signal,
    output reg o_sll_signal,
    output reg o_sra_signal,
    output reg o_srl_signal,
    output o_unknown_inst
);

    wire [2:0] fun1;
    wire [6:0] fun2;
    wire [6:0] opcode;
    reg unknown_intstruction;

    assign opcode = i_inst[6:0];
    assign o_rd   = i_inst[11:7];
    assign fun1   = i_inst[14:12];
    assign o_rs1  = i_inst[19:15];
    assign o_rs2  = i_inst[24:20];
    assign fun2   = i_inst[31:25];
    assign o_unknown_inst = unknown_intstruction;

    always @ (*) begin
        // 初始化
        o_add_signal    = 1'b0;
        o_and_signal    = 1'b0;
        o_or_signal     = 1'b0;
        o_xor_signal    = 1'b0;
        o_sub_signal    = 1'b0;
        o_slt_signal    = 1'b0;
        o_sltu_signal   = 1'b0;
        // o_mul_signal    = 1'b0;
        // o_mulh_signal   = 1'b0;
        // o_mulhu_signal  = 1'b0;
        // o_mulhsu_signal = 1'b0;
        // o_div_signal    = 1'b0;
        // o_divu_signal   = 1'b0;
        // o_rem_signal    = 1'b0;
        // o_remu_signal   = 1'b0;
        o_sll_signal    = 1'b0;
        o_sra_signal    = 1'b0;
        o_srl_signal    = 1'b0;
        unknown_intstruction = 1'b0;

        // 指令识别
        case (opcode)
            7'b0110011: begin
                if (fun2 == 7'b0000000) begin
                    o_add_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                    o_and_signal  = (fun1 == 3'b111) ? 1'b1 : 1'b0;
                    o_or_signal   = (fun1 == 3'b110) ? 1'b1 : 1'b0;
                    o_xor_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
                    o_slt_signal  = (fun1 == 3'b010) ? 1'b1 : 1'b0;
                    o_sltu_signal = (fun1 == 3'b011) ? 1'b1 : 1'b0;
                    o_sll_signal  = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                    o_srl_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                end
                else if (fun2 == 7'b0100000) begin
                    o_sub_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                    o_sra_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                end
                // else if (fun2 == 7'b0000001) begin
                    // o_mul_signal   = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                    // o_mulh_signal  = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                    // o_mulhu_signal = (fun1 == 3'b010) ? 1'b1 : 1'b0;
                    // o_mulhsu_signal= (fun1 == 3'b011) ? 1'b1 : 1'b0;
                    // o_div_signal   = (fun1 == 3'b100) ? 1'b1 : 1'b0;
                    // o_divu_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                    // o_rem_signal   = (fun1 == 3'b110) ? 1'b1 : 1'b0;
                    // o_remu_signal  = (fun1 == 3'b111) ? 1'b1 : 1'b0;
                // end
                else begin
                    unknown_intstruction = 1'b1;
                end
            end
            //待扩展
            default: begin
                unknown_intstruction = 1'b1;
            end
        endcase
    end


endmodule
