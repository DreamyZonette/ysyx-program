module Itype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output [4:0] o_rs1,
    output [5:0] o_shamt,
    output reg [31:0] o_imm,
    output     [11:0] o_csr_addr,
    output reg o_jalr_signal,
    output reg o_addi_signal,
    output reg o_lw_signal,
    output reg o_lbu_signal,
    output reg o_ebreak_signal,
    output reg o_slli_signal,
    output reg o_srai_signal,
    output reg o_srli_signal,
    output reg o_lb_signal,
    output reg o_lh_signal,
    output reg o_lhu_signal,
    output reg o_andi_signal,
    output reg o_xori_signal,
    output reg o_slti_signal,
    output reg o_sltiu_signal,
    output reg o_ori_signal,
    output reg o_csrrs_signal,
    output reg o_csrrw_signal,
    output reg o_ecall_signal,
    output reg o_mret_signal,
    output o_unknown_inst
);

    wire [11:0] imm;
    wire [2:0] fun1;
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [6:0] shamt_detect;
    wire [11:0] csr_addr;
    reg sign_extended;
    reg zero_extended;
    reg [4:0] jalr_rd;
    reg shamt_signal;
    reg unknown_intstruction;
    reg shamt_halt;

    assign opcode       = i_inst[6:0];
    assign rd           = i_inst[11:7];
    assign fun1         = i_inst[14:12];
    assign o_rs1        = i_inst[19:15];
    assign o_shamt      = i_inst[25:20];
    assign imm          = i_inst[31:20];
    assign shamt_detect = i_inst[31:25];
    assign o_rd         = (o_jalr_signal == 1'b1) ? jalr_rd : rd;
    assign o_unknown_inst =  unknown_intstruction | shamt_halt;
    assign csr_addr     = i_inst[31:20];
    assign o_csr_addr   = (o_csrrs_signal == 1'b1 || o_csrrw_signal == 1'b1) ? csr_addr : 12'b0;

    always @ (*) begin
        // 初始化
        o_jalr_signal   = 1'b0;
        o_addi_signal   = 1'b0;
        o_ebreak_signal = 1'b0;
        o_lw_signal     = 1'b0;
        o_lbu_signal    = 1'b0;
        o_slli_signal   = 1'b0;
        o_srai_signal   = 1'b0;
        o_srli_signal   = 1'b0;
        o_lb_signal     = 1'b0;
        o_lh_signal     = 1'b0;
        o_lhu_signal    = 1'b0;
        o_andi_signal   = 1'b0;
        o_xori_signal   = 1'b0;
        o_ori_signal    = 1'b0;
        o_sltiu_signal  = 1'b0;
        o_slti_signal   = 1'b0;
        sign_extended   = 1'b0;
        zero_extended   = 1'b0;
        shamt_signal    = 1'b0;
        o_csrrs_signal  = 1'b0;
        o_csrrw_signal  = 1'b0;
        o_ecall_signal  = 1'b0;
        o_mret_signal   = 1'b0;
        unknown_intstruction = 1'b0;
        jalr_rd = 5'b0;
        
        // 指令识别
    case (opcode)
        7'b1100111: begin // jalr
            if (fun1 == 3'b000) begin
                o_jalr_signal   = 1'b1;
                sign_extended = 1'b1;
                // if(rd == 5'b0) begin
                //     jalr_rd = 5'b1;
                // end
                // else begin
                    jalr_rd = rd;
                // end
            end
        end
        7'b0010011: begin // I-type ALU
            o_addi_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
            o_andi_signal  = (fun1 == 3'b111) ? 1'b1 : 1'b0;
            o_xori_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
            o_ori_signal   = (fun1 == 3'b110) ? 1'b1 : 1'b0;
            o_sltiu_signal = (fun1 == 3'b011) ? 1'b1 : 1'b0;
            o_slti_signal  = (fun1 == 3'b010) ? 1'b1 : 1'b0;
            // 涉及shamt
            if(shamt_detect == 7'b0000000) begin
                // 7'b0000000
                o_slli_signal = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                o_srli_signal = (fun1 == 3'b101) ? 1'b1 : 1'b0; 
            end else if(shamt_detect == 7'b0100000) begin
                // 7'b0100000
                o_srai_signal = (fun1 == 3'b101) ? 1'b1 : 1'b0; 
            end
            shamt_signal = o_slli_signal | o_srli_signal | o_srai_signal;
           
            // 根据指令类型选择扩展方式
            sign_extended = (fun1 == 3'b000 || fun1 == 3'b111 || fun1 == 3'b100 || fun1 == 3'b010 || fun1 == 3'b110 || fun1 == 3'b011) ? 1'b1 : 1'b0; // addi/andi/xori/slti/ori
            
        end
        7'b1110011: begin  // ebreak
            if(i_inst == 32'b 00000000000100000000000001110011) begin
                o_ebreak_signal = 1'b1;
            end else if(i_inst == 32'h00000073) begin
                o_ecall_signal = 1'b1;
                // $strobe("idu_ecall_on");
            end else if(i_inst == 32'h30200073) begin
                o_mret_signal = 1'b1;
            end else begin
                o_csrrw_signal = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                o_csrrs_signal = (fun1 == 3'b010) ? 1'b1 : 1'b0;
            end
        end
        7'b0000011: begin  // load
            o_lw_signal   = (fun1 == 3'b010) ? 1'b1 : 1'b0;
            o_lb_signal   = (fun1 == 3'b000) ? 1'b1 : 1'b0;
            o_lh_signal   = (fun1 == 3'b001) ? 1'b1 : 1'b0;
            o_lbu_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
            o_lhu_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
            sign_extended = (fun1 == 3'b010 || fun1 == 3'b000 || fun1 == 3'b001 || fun1 == 3'b100 || fun1 == 3'b101) ? 1'b1 : 1'b0; // lw/lb/lh/ lbu/lhu
            //zero_extended = () ? 1'b1 : 1'b0; 
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

    always @(*) begin
        if(shamt_signal == 1'b1) begin
            shamt_halt = o_shamt[5];
        end
        else begin
            shamt_halt = 1'b0;
        end
    end


endmodule
