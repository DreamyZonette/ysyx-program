module Itype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output [4:0] o_rs1,
    output reg [31:0] o_imm,
    output reg o_jalr_signal,
    output reg o_addi_signal,
    output reg o_lw_signal,
    output reg o_lbu_signal,
    output reg o_ebreak_signal,
    output o_halt_signal
);

    wire [11:0] imm;
    wire [2:0] fun1;
    wire [6:0] opcode;
    wire [4:0] rd;
    reg sign_extended;
    reg zero_extended;
    reg unknown_intstruction;

    assign opcode       = i_inst[6:0];
    assign rd           = i_inst[11:7];
    assign fun1         = i_inst[14:12];
    assign o_rs1        = i_inst[19:15];
    assign imm          = i_inst[31:20];
    assign o_rd         = rd;
    assign o_halt_signal =  unknown_intstruction;

    always @ (*) begin
        // 初始化
        o_jalr_signal   = 1'b0;
        o_addi_signal   = 1'b0;
        o_ebreak_signal = 1'b0;
        o_lw_signal     = 1'b0;
        o_lbu_signal    = 1'b0;
        sign_extended   = 1'b0;
        zero_extended   = 1'b0;
        unknown_intstruction = 1'b0;
        
        // 指令识别
    case (opcode)
        7'b1100111: begin // jalr
            if (fun1 == 3'b000) begin
                o_jalr_signal   = 1'b1;
                sign_extended = 1'b1;
            end
        end
        7'b0010011: begin // I-type ALU
            o_addi_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
            // 涉及shamt
           
            // 根据指令类型选择扩展方式
            sign_extended = (fun1 == 3'b000) ? 1'b1 : 1'b0; // addi/
        end
        7'b1110011: begin  // ebreak
            if(i_inst == 32'b 00000000000100000000000001110011) begin
                o_ebreak_signal = 1'b1;
            end
        end
        7'b0000011: begin  // load
            o_lw_signal   = (fun1 == 3'b010) ? 1'b1 : 1'b0;
            o_lbu_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
            sign_extended = (fun1 == 3'b010 || fun1 == 3'b100) ? 1'b1 : 1'b0; // lw/lbu
            
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
    end


endmodule
