module Btype (
    input [31:0] i_inst,
    output [4:0] o_rs1,
    output [4:0] o_rs2,
    output reg [31:0] o_offset,
    output reg o_beq_signal,
    output reg o_bne_signal,
    output reg o_bge_signal,
    output reg o_bgeu_signal,
    output reg o_blt_signal,
    output reg o_bltu_signal,
    output o_halt_signal
);

    wire [11:0] offset;
    wire [6:0] opcode;
    wire [2:0] fun1;
    reg sign_extended;
    reg zero_extended;
    reg unknown_intstruction;

    assign opcode  = i_inst[6:0];
    assign fun1    = i_inst[14:12];
    assign o_rs1   = i_inst[19:15];
    assign o_rs2   = i_inst[24:20];
    assign offset  = {i_inst[31], i_inst[7], i_inst[30:25], i_inst[11:8]};
    assign o_halt_signal = unknown_intstruction;
    
    always @(*) begin
        o_beq_signal  = 1'b0;
        o_bne_signal  = 1'b0;
        o_bge_signal  = 1'b0;
        o_bgeu_signal = 1'b0;
        o_blt_signal  = 1'b0;
        o_bltu_signal = 1'b0;
        sign_extended = 1'b0;
        zero_extended = 1'b0;
        unknown_intstruction = 1'b0;

        case (opcode)
            7'b1100011: begin
                o_beq_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                o_bne_signal  = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                o_bge_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                o_bgeu_signal = (fun1 == 3'b111) ? 1'b1 : 1'b0;
                o_blt_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
                o_bltu_signal = (fun1 == 3'b110) ? 1'b1 : 1'b0;
                if(fun1 == 3'b000 || fun1 == 3'b101 || fun1 == 3'b001 || fun1 == 3'b100 || fun1 == 3'b110 || fun1 == 3'b111) begin
                    sign_extended = 1'b1;
                end else begin
                    zero_extended = 1'b1;
                end
            end
            default begin
                unknown_intstruction = 1'b1;
            end
        endcase
    end

    always @(*) begin
        if(sign_extended == 1'b1) begin
            o_offset = {{20{offset[11]}}, offset} << 1;
        end else if(zero_extended == 1'b1) begin
            o_offset = {20'b0, offset} << 1;
        end else begin
            o_offset = {20'b0, offset} << 1;
        end
    end

endmodule
