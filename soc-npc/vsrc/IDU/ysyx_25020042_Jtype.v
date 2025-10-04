module ysyx_25020042_Jtype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output wire [31:0] o_offset,
    output reg o_jal_signal,
    output o_halt_signal
);

    wire [6:0] opcode;
    wire [19:0] offset;
    reg unknown_intstruction;

    assign opcode   = i_inst[6:0];
    assign o_rd     = i_inst[11:7];
    assign offset = {i_inst[31], i_inst[19:12], i_inst[20], i_inst[30:21]};
    assign o_halt_signal = unknown_intstruction;
    assign o_offset  =  {{ {12{offset[19]}}, offset}} << 1;

    always @ (*) begin
        // 初始化
        o_jal_signal    = 1'b0;
        unknown_intstruction   = 1'b0;

        // 指令识别
        case (opcode)
            7'b 1101111: begin
                o_jal_signal  = 1'b1;
                // sign_extended = 1'b1;
            end
            default: begin
                unknown_intstruction   = 1'b1;
            end
        endcase
    end


endmodule
