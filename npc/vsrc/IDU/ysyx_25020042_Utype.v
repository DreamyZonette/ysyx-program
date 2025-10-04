module ysyx_25020042_Utype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output wire [31:0] o_imm,
    output reg o_auipc_signal,
    output reg o_lui_signal,
    output o_halt_signal
);

    wire [6:0] opcode;
    wire [19:0] imm;
    reg unknown_intstruction;

    assign opcode = i_inst[6:0];
    assign o_rd   = i_inst[11:7];
    assign imm    = i_inst[31:12];
    assign o_halt_signal = unknown_intstruction;
    assign o_imm =  { {12{imm[19]}}, imm} << 12;

    always @ (*) begin
        // 初始化
        o_lui_signal    = 1'b0;
        o_auipc_signal  = 1'b0;
        unknown_intstruction   = 1'b0;

        // 指令识别
        case (opcode)
            7'b0110111: begin
                o_lui_signal  = 1'b1;
            end
            7'b0010111: begin
                o_auipc_signal  = 1'b1;
            end
            default: begin
                unknown_intstruction = 1'b1;
            end
        endcase
    end


endmodule
