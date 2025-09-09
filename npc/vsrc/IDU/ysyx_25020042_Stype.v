module ysyx_25020042_Stype (
    input [31:0] i_inst,
    output [4:0] o_rs1,
    output [4:0] o_rs2,
    output reg [31:0] o_imm,
    output reg [3:0] o_wmask,
    output reg o_sw_signal,
    output reg o_sb_signal,
    output reg o_sh_signal,
    output o_halt_signal
);

    wire [11:0] imm;
    wire [2:0] fun;
    wire [6:0] opcode;
    reg sign_extended;
    reg zero_extended;
    reg unknown_intstruction;

    assign opcode = i_inst[6:0];
    assign fun    = i_inst[14:12];
    assign o_rs1  = i_inst[19:15];
    assign o_rs2  = i_inst[24:20];
    assign imm    = {i_inst[31:25], i_inst[11:7]};
    assign o_halt_signal = unknown_intstruction;

    always @ (*) begin
        // 初始化
        o_sw_signal     = 1'b0;
        o_sb_signal     = 1'b0;
        o_sh_signal     = 1'b0;
        sign_extended   = 1'b0;
        zero_extended   = 1'b0;
        unknown_intstruction = 1'b0;
        o_wmask = 4'b0;

        // 指令识别
    case (opcode)
        7'b0100011: begin // store
            o_sw_signal = (fun == 3'b010) ? 1'b1 : 1'b0;
            o_sb_signal = (fun == 3'b000) ? 1'b1 : 1'b0;
            o_sh_signal = (fun == 3'b001) ? 1'b1 : 1'b0;
            sign_extended = (fun == 3'b010 || fun == 3'b000 || fun == 3'b001) ? 1'b1 : 1'b0;
        end
        default: begin
            unknown_intstruction = 1'b1;
        end
    endcase


        //imm扩展
        if(sign_extended == 1'b1)begin
            o_imm =  { {20{imm[11]}}, imm};
        end
        else if(zero_extended == 1'b1) begin
            o_imm =  { {20{1'b0}}, imm};
        end
        else begin
            o_imm = 32'b0;
        end

        if (o_sw_signal == 1'b1) begin
            o_wmask = 4'd4;
        end else if (o_sb_signal == 1'b1) begin
            o_wmask = 4'd1;
    end else if (o_sh_signal == 1'b1) begin
            o_wmask = 4'd2;
        end else begin
            o_wmask = 4'd0;
        end
    end


endmodule

