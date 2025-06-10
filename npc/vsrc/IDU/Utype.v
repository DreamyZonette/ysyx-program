module Utype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output reg [31:0] o_imm,
    output reg o_lui_signal
);

    wire [6:0] opcode;
    wire [19:0] imm;
    reg sign_extended;
    reg zero_extended;

    assign opcode = i_inst[6:0];
    assign o_rd   = i_inst[11:7];
    assign imm    = i_inst[31:12];

    always @ (*) begin
        // 初始化
        o_lui_signal    = 1'b0;
        sign_extended   = 1'b0;
        zero_extended   = 1'b0;

        // 指令识别
        case (opcode)
            7'b0110111: begin
                o_lui_signal  = 1'b1;
                sign_extended = 1'b1;
            end
            //待扩展
            default: begin
                
            end
        endcase

        // imm扩展
        if(sign_extended == 1'b1)begin
            o_imm =  { {12{imm[19]}}, imm} << 12;
        end
        else if(zero_extended == 1'b1) begin
            o_imm =  { {12{1'b0}}, imm} << 12;
        end
        else begin
            o_imm = 32'b0;
        end
    end


endmodule
