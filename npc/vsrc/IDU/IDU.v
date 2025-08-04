module IDU (
    input wire i_sys_clk,
    input wire i_sys_rst_n, 
    input wire [31:0]  i_inst,
    input wire i_ifu_valid,
    input wire i_exu_ready,
    input wire i_lsu_ready,
    output wire o_idu_ready,
    output wire o_idu_valid,
    output wire [4:0] o_rs1,
    output wire [4:0] o_rs2,
    output wire [4:0] o_rd,
    output wire [31:0]  o_imm,
    output wire [31:0]  o_offset,
    output wire [5:0]   o_shamt,
    output wire [11:0]  o_csr_addr,
    output wire o_addi_signal,
    output wire o_andi_signal,
    output wire o_xori_signal,
    output wire o_ori_signal,
    output wire o_ebreak_signal,
    output wire o_jalr_signal,
    output wire o_lbu_signal,
    output wire o_lw_signal,
    output wire o_auipc_signal,
    output wire o_lui_signal,
    output wire o_lb_signal,
    output wire o_lh_signal,
    output wire o_lhu_signal,
    output wire o_srai_signal,
    output wire o_slli_signal,
    output wire o_sb_signal,
    output wire o_slti_signal,
    output wire o_sltiu_signal,
    output wire o_srli_signal,
    output wire o_sll_signal,
    output wire o_jal_signal,
    output wire o_sw_signal,
    output wire o_add_signal,
    output wire o_and_signal,
    output wire o_or_signal,
    output wire o_xor_signal,
    output wire o_sub_signal,
    output wire o_slt_signal,
    output wire o_sltu_signal,
    output wire o_sra_signal,
    output wire o_srl_signal,
    output wire o_beq_signal,
    output wire o_bne_signal,
    output wire o_bge_signal,
    output wire o_bgeu_signal,
    output wire o_blt_signal,
    output wire o_bltu_signal,
    output wire o_sh_signal,
    output wire o_csrrs_signal,
    output wire o_csrrw_signal,
    output wire o_ecall_signal,
    output wire o_mret_signal,
    output wire o_unknown_inst
    );

    localparam IDLE = 2'b00;
    localparam DECODE = 2'b01;
    // localparam VALID = 2'b10;

    reg [1:0] state;
    reg [1:0] next_state;

    wire [6:0]  opcode;
    wire [31:0] J_offset;
    wire [31:0] I_imm;
    wire [4:0]  I_rs1;
    wire [4:0]  I_rd;
    wire [5:0]  I_shamt;
    wire [11:0] I_csr_addr;
    wire [4:0]  U_rd;
    wire [31:0] U_imm;
    wire [4:0]  J_rd;
    wire [4:0]  S_rs1;
    wire [4:0]  S_rs2;
    wire [31:0] S_imm;
    wire [4:0]  R_rd;
    wire [4:0]  R_rs1;
    wire [4:0]  R_rs2;
    wire [4:0]  B_rs1;
    wire [4:0]  B_rs2;
    wire [31:0] B_offset;
    wire J_unknown_inst;
    wire S_unknown_inst;
    wire R_unknown_inst;
    wire I_unknown_inst;
    wire U_unknown_inst;
    wire B_unknown_inst;
    wire decode_valid;
    reg Btype_signal;
    reg Itype_signal;
    reg Jtype_signal;
    reg Rtype_signal;
    reg Stype_signal;
    reg Utype_signal;
    reg invalid_opcode_signal;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg [31:0] imm;
    reg [31:0] offset;
    reg [11:0] csr_addr;
    reg [5:0] shamt;
    // 指令寄存器
    reg [31:0] inst_reg;

    assign o_idu_ready = (state == IDLE);
    assign o_idu_valid = (state == DECODE && decode_valid);
    assign o_offset = offset;
    assign o_imm = imm;
    assign o_shamt = shamt;
    assign o_rs1 = rs1;
    assign o_rs2 = rs2;
    assign o_rd = rd;
    assign o_csr_addr = csr_addr;
    assign decode_valid = 1'b1;// 暂时不考虑

    // 状态转移逻辑
    always @ (*) begin
        if(!i_sys_rst_n) begin
            next_state = IDLE;
        end
        else begin
            case (state)
                IDLE: begin
                    if(i_ifu_valid) begin
                        next_state = DECODE;
                    end
                    else begin
                        next_state = IDLE;
                    end
                end
                DECODE: begin
                    if(decode_valid && i_lsu_ready && i_exu_ready) begin
                        next_state = IDLE;
                    end
                    else begin
                        next_state = DECODE;
                    end
                end
                // VALID: begin
                //     if (i_lsu_ready && i_exu_ready) begin
                //         next_state = IDLE;
                //     end
                //     else begin
                //         next_state = VALID;
                //     end
                // end 
                default: begin
                    next_state = IDLE;
                end
            endcase
        end
    end

    always @(posedge i_sys_clk) begin
        if(!i_sys_rst_n) begin
            inst_reg <= 32'b0;
        end
        else if (state == IDLE && i_ifu_valid)begin
            inst_reg <= i_inst;         
        end
    end 

    // 状态转移
    always @(posedge i_sys_clk) begin
        if(!i_sys_rst_n) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    assign opcode = inst_reg[6:0];
    assign o_unknown_inst = (invalid_opcode_signal | 
        (J_unknown_inst & Jtype_signal)| (S_unknown_inst & Stype_signal) | 
        (R_unknown_inst & Rtype_signal)| (I_unknown_inst & Itype_signal) | 
        (U_unknown_inst & Utype_signal)| (B_unknown_inst & Btype_signal));

    //根据操作码判断类型
    always @ (*) begin
        Btype_signal = 1'b0;
        Itype_signal = 1'b0;
        Jtype_signal = 1'b0;
        Rtype_signal = 1'b0;
        Stype_signal = 1'b0;
        Utype_signal = 1'b0;
        invalid_opcode_signal = 1'b0;
        case(opcode)
        // I型
            7'b1100111:begin
                Itype_signal = 1'b1;
            end
            7'b0000011:begin
                Itype_signal = 1'b1;
            end
            7'b0010011:begin
                Itype_signal = 1'b1;
            end
            7'b0001111:begin
                Itype_signal = 1'b1;
            end
            7'b1110011:begin
                Itype_signal = 1'b1;
            end
        // J型
            7'b1101111:begin
                Jtype_signal = 1'b1;
            end
        // U型
            7'b0110111:begin
                Utype_signal = 1'b1;
            end
            7'b0010111:begin
                Utype_signal = 1'b1;
            end
        // B型
            7'b1100011:begin
                Btype_signal = 1'b1;
            end
        // R型
            7'b0110011:begin
                Rtype_signal = 1'b1;
            end
        // S型
            7'b0100011:begin
                Stype_signal = 1'b1;
            end
            default: begin
                invalid_opcode_signal = 1'b1;
            end
        endcase
    end

    // 用时序发现会落后一个周期，所以还是用组合逻辑
    always @(*) begin
        if(!i_sys_rst_n) begin
            imm = 32'b0;
            offset = 32'b0;
            rs1 = 5'b0;
            rs2 = 5'b0;
            rd  = 5'b0;
            shamt  = 6'b0;
            csr_addr = 12'b0;
        end
        else if (state == DECODE) begin
            if(Itype_signal == 1'b1) begin
                rs1 = I_rs1;
                rs2 = 5'b0;
                rd  = I_rd;
                imm = I_imm;
                shamt = I_shamt;
                offset = 32'b0;
                csr_addr = I_csr_addr;
            end
            else if(Utype_signal == 1'b1) begin
                rs1 = 5'b0;
                rs2 = 5'b0;
                rd  = U_rd;
                imm = U_imm;
                offset = 32'b0;
                shamt  = 6'b0;
                csr_addr = 12'b0;
            end
            else if(Btype_signal == 1'b1) begin
                offset = B_offset;
                rs1 = B_rs1;
                rs2 = B_rs2;
                rd  = 5'b0;
                shamt = 6'b0;
                imm = 32'b0;
                csr_addr = 12'b0;
            end
            else if(Jtype_signal == 1'b1) begin
                offset  = J_offset;
                rs1 = 5'b0;
                rs2 = 5'b0;
                rd  = J_rd;
                shamt  = 6'b0;
                imm = 32'b0;
                csr_addr = 12'b0;
            end
            else if(Stype_signal == 1'b1) begin
                imm  = S_imm;
                rs1  = S_rs1;
                rs2  = S_rs2;
                rd   = 5'b0;
                shamt = 6'b0;
                offset = 32'b0;
                csr_addr = 12'b0;
            end
            else if(Rtype_signal == 1'b1) begin
                imm = 32'b0;
                rs1 = R_rs1;
                rs2 = R_rs2;
                rd  = R_rd;
                shamt = 6'b0;
                offset = 32'b0;
                csr_addr = 12'b0;
            end
            // 避免锁存器
            else begin
                imm = 32'b0;
                rs1 = 5'b0;
                rs2 = 5'b0;
                rd  = 5'b0;
                shamt = 6'b0;
                offset = 32'b0;
                csr_addr = 12'b0;
            end
        end
        // 避免锁存器
            else begin
            imm = 32'b0;
            rs1 = 5'b0;
            rs2 = 5'b0;
            rd  = 5'b0;
            shamt = 6'b0;
            offset = 32'b0;
            csr_addr = 12'b0;
        end
    end

    Itype Itype_u(
        .i_inst(inst_reg),
        .o_imm(I_imm),
        .o_rs1(I_rs1),
        .o_shamt(I_shamt),
        .o_rd(I_rd),
        .o_csr_addr(I_csr_addr),
        .o_addi_signal(o_addi_signal),
        .o_ebreak_signal(o_ebreak_signal),
        .o_jalr_signal(o_jalr_signal),
        .o_lbu_signal(o_lbu_signal),
        .o_lw_signal(o_lw_signal),
        .o_slli_signal(o_slli_signal),
        .o_srai_signal(o_srai_signal),
        .o_srli_signal(o_srli_signal),
        .o_lb_signal(o_lb_signal),
        .o_lh_signal(o_lh_signal),
        .o_lhu_signal(o_lhu_signal),
        .o_andi_signal(o_andi_signal),
        .o_xori_signal(o_xori_signal),
        .o_ori_signal(o_ori_signal),
        .o_slti_signal(o_slti_signal),
        .o_sltiu_signal(o_sltiu_signal),
        .o_csrrs_signal(o_csrrs_signal),
        .o_csrrw_signal(o_csrrw_signal),
        .o_ecall_signal(o_ecall_signal),
        .o_mret_signal(o_mret_signal), // 原本是Rtype_u的输出
        .o_unknown_inst(I_unknown_inst)
    );
    Utype Utype_u(
        .i_inst(inst_reg),
        .o_rd(U_rd),
        .o_imm(U_imm),
        .o_auipc_signal(o_auipc_signal),
        .o_lui_signal(o_lui_signal),
        .o_unknown_inst(U_unknown_inst)
    );
    Btype Btype_u(
        .i_inst(inst_reg),
        .o_rs1(B_rs1),
        .o_rs2(B_rs2),
        .o_offset(B_offset),
        .o_beq_signal(o_beq_signal),
        .o_bne_signal(o_bne_signal),
        .o_bge_signal(o_bge_signal),
        .o_bgeu_signal(o_bgeu_signal),
        .o_blt_signal(o_blt_signal),
        .o_bltu_signal(o_bltu_signal),
        .o_unknown_inst(B_unknown_inst)
    );
    Jtype Jtype_u(
        .i_inst(inst_reg),
        .o_offset(J_offset),
        .o_rd(J_rd),
        .o_jal_signal(o_jal_signal),
        .o_unknown_inst(J_unknown_inst)
    );
    Stype Stype_u(
    .i_inst(inst_reg),
    .o_rs1(S_rs1),
    .o_rs2(S_rs2),
    .o_imm(S_imm),
    .o_sw_signal(o_sw_signal),
    .o_sb_signal(o_sb_signal),
    .o_sh_signal(o_sh_signal),
    .o_unknown_inst(S_unknown_inst)
    );
    Rtype Rtype_u(
    .i_inst(inst_reg),
    .o_rd(R_rd),
    .o_rs1(R_rs1),
    .o_rs2(R_rs2),
    .o_add_signal(o_add_signal),
    .o_and_signal(o_and_signal),
    .o_or_signal(o_or_signal),
    .o_xor_signal(o_xor_signal),
    .o_sub_signal(o_sub_signal),
    .o_slt_signal(o_slt_signal),
    .o_sltu_signal(o_sltu_signal),
    .o_sll_signal(o_sll_signal),
    .o_sra_signal(o_sra_signal),
    .o_srl_signal(o_srl_signal),
    .o_unknown_inst(R_unknown_inst)
    );
    endmodule

