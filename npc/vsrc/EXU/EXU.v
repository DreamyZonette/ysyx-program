module EXU(
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    input wire [31:0] i_src1,
    input wire [31:0] i_src2,
    input wire [31:0] i_imm,
    input wire [31:0] i_offset,
    input wire [31:0] i_pc_data,
    input wire [5:0] i_shamt,
    input wire [31:0] i_csr_data,
    input wire i_addi_signal,
    input wire i_jalr_signal,
    input wire i_lb_signal,
    input wire i_lh_signal,
    input wire i_lw_signal,
    input wire i_lbu_signal,
    input wire i_lhu_signal,
    input wire i_xori_signal,
    input wire i_ori_signal,
    input wire i_andi_signal,
    input wire i_slli_signal,
    input wire i_srli_signal,
    input wire i_srai_signal,
    input wire i_slti_signal,
    input wire i_sltiu_signal,
    input wire i_beq_signal,
    input wire i_bne_signal,
    input wire i_blt_signal,
    input wire i_bge_signal,
    input wire i_bltu_signal,
    input wire i_bgeu_signal,
    input wire i_jal_signal,
    input wire i_sw_signal,
    input wire i_sh_signal,
    input wire i_sb_signal,
    input wire i_and_signal,
    input wire i_or_signal,
    input wire i_xor_signal,
    input wire i_srl_signal,
    input wire i_sra_signal,
    input wire i_auipc_signal,
    input wire i_lui_signal,
    input wire i_add_signal,
    input wire i_sub_signal,
    input wire i_sll_signal,
    input wire i_slt_signal,
    input wire i_sltu_signal,
    input wire i_ebreak_signal,
    input wire i_csrrs_signal,
    input wire i_csrrw_signal,
    input wire i_ecall_signal,
    input wire i_mret_signal,
    input wire i_idu_valid,
    input wire i_wbu_ready,
    input wire i_lsu_ready,
    output wire o_exu_valid,
    output wire o_exu_ready,
    output reg o_B_jump_signal,
    output reg [31:0] o_data

);

localparam IDLE      = 3'd000;
localparam ALU       = 3'd001;
localparam LS_ALU    = 3'd010;
localparam DONE      = 3'd011;
localparam LS_DONE   = 3'd100;

reg [2:0] state;
reg [2:0] next_state;
wire LS_signal;
wire alu_done;
wire B_jump_signal;
wire [31:0] data;

assign LS_signal = i_lb_signal | i_lh_signal | i_lw_signal | i_lbu_signal | i_lhu_signal | 
                    i_sw_signal | i_sh_signal | i_sb_signal;
assign alu_done = 1'b1;// 目前都是单周期实现
assign o_exu_ready = (state == IDLE);
assign o_exu_valid = (state == DONE) | (state == LS_DONE);
    
// 状态转移逻辑
always @(*) begin
    if(!i_sys_rst_n) begin
        next_state = IDLE;
    end
    else begin
        case(state) 
            IDLE: begin
                if(i_idu_valid) begin
                    if (LS_signal == 1'b1) begin
                        next_state = LS_ALU;
                    end
                    else begin
                        next_state = ALU;
                    end
                end
                else begin
                    next_state = IDLE;
                end
            end
            ALU: begin
                if(alu_done) begin
                    next_state = DONE;
                end
                else begin
                    next_state = ALU;
                end
            end
            LS_ALU: begin
                if(alu_done) begin
                    next_state = LS_DONE;
                end
                else begin
                    next_state = LS_ALU;
                end
            end
            DONE: begin
                if(i_wbu_ready) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = DONE;
                end
            end
            LS_DONE: begin
                if(i_lsu_ready) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = LS_DONE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
end

// 状态执行逻辑
always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        o_data <= 32'h0;
        o_B_jump_signal <= 1'b0;
    end
    else begin
        case(state)
            IDLE: begin
                o_data <= 32'h0;
                o_B_jump_signal <= 1'b0;
            end
            ALU: begin
                if (alu_done) begin
                    o_data <= data;
                    o_B_jump_signal <= B_jump_signal;
                end
            end
            LS_ALU: begin
                if (alu_done) begin
                    o_data <= data;
                    o_B_jump_signal <= B_jump_signal;
                end
            end
            DONE: begin end
            LS_DONE: begin end
            default: begin end
        endcase
    end               
end

// 状态更新逻辑
always @(posedge i_sys_clk) begin
    if(!i_sys_rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

// 锁存器   
reg [31:0] src1_reg;
reg [31:0] src2_reg;
reg [31:0] imm_reg;
reg [31:0] offset_reg;
reg [31:0] pc_data_reg;
reg [5:0] shamt_reg;
reg [31:0] csr_data_reg;
reg addi_signal_reg;
reg jalr_signal_reg;
reg lb_signal_reg;
reg lh_signal_reg;
reg lw_signal_reg;
reg lbu_signal_reg;
reg lhu_signal_reg;
reg xori_signal_reg;
reg ori_signal_reg;
reg andi_signal_reg;
reg slli_signal_reg;
reg srli_signal_reg;
reg srai_signal_reg;
reg slti_signal_reg;
reg sltiu_signal_reg;
reg beq_signal_reg;
reg bne_signal_reg;
reg blt_signal_reg;
reg bge_signal_reg;
reg bltu_signal_reg;
reg bgeu_signal_reg;
reg jal_signal_reg;
reg sw_signal_reg;
reg sh_signal_reg;
reg sb_signal_reg;
reg and_signal_reg;
reg or_signal_reg;
reg xor_signal_reg;
reg srl_signal_reg;
reg sra_signal_reg;
reg auipc_signal_reg;
reg lui_signal_reg;
reg add_signal_reg;
reg sub_signal_reg;
reg sll_signal_reg;
reg slt_signal_reg;
reg sltu_signal_reg;
reg ebreak_signal_reg;
reg csrrs_signal_reg;
reg csrrw_signal_reg;
reg ecall_signal_reg;
reg mret_signal_reg;

always @(posedge i_sys_clk) begin
    if(!i_sys_rst_n) begin
        src1_reg <= 32'h0;
        src2_reg <= 32'h0;
        imm_reg <= 32'h0;
        offset_reg <= 32'h0;
        pc_data_reg <= 32'h0;
        shamt_reg <= 6'h0;
        csr_data_reg <= 32'h0;
        addi_signal_reg <= 1'b0;
        jalr_signal_reg <= 1'b0;
        lb_signal_reg <= 1'b0;
        lh_signal_reg <= 1'b0;
        lw_signal_reg <= 1'b0;
        lbu_signal_reg <= 1'b0;
        lhu_signal_reg <= 1'b0;
        xori_signal_reg <= 1'b0;
        ori_signal_reg <= 1'b0;
        andi_signal_reg <= 1'b0;
        slli_signal_reg <= 1'b0;
        srli_signal_reg <= 1'b0;
        srai_signal_reg <= 1'b0;
        slti_signal_reg <= 1'b0;
        sltiu_signal_reg <= 1'b0;
        beq_signal_reg <= 1'b0;
        bne_signal_reg <= 1'b0;
        blt_signal_reg <= 1'b0;
        bge_signal_reg <= 1'b0;
        bltu_signal_reg <= 1'b0;
        bgeu_signal_reg <= 1'b0;
        jal_signal_reg <= 1'b0;
        sw_signal_reg <= 1'b0;
        sh_signal_reg <= 1'b0;
        sb_signal_reg <= 1'b0;
        and_signal_reg <= 1'b0;
        or_signal_reg <= 1'b0;
        xor_signal_reg <= 1'b0;
        srl_signal_reg <= 1'b0;
        sra_signal_reg <= 1'b0;
        auipc_signal_reg <= 1'b0;
        lui_signal_reg <= 1'b0;
        add_signal_reg <= 1'b0;
        sub_signal_reg <= 1'b0;
        sll_signal_reg <= 1'b0;
        slt_signal_reg <= 1'b0;
        sltu_signal_reg <= 1'b0;
        ebreak_signal_reg <= 1'b0;
        csrrs_signal_reg <= 1'b0;
        csrrw_signal_reg <= 1'b0;
        ecall_signal_reg <= 1'b0;
        mret_signal_reg <= 1'b0;
    end
    else if (state == IDLE && i_idu_valid)begin
        src1_reg <= i_src1;
        src2_reg <= i_src2;
        imm_reg <= i_imm;
        offset_reg <= i_offset;
        pc_data_reg <= i_pc_data;
        shamt_reg <= i_shamt;
        csr_data_reg <= i_csr_data;
        addi_signal_reg <= i_addi_signal;
        jalr_signal_reg <= i_jalr_signal;
        lb_signal_reg <= i_lb_signal;
        lh_signal_reg <= i_lh_signal;
        lw_signal_reg <= i_lw_signal;
        lbu_signal_reg <= i_lbu_signal;
        lhu_signal_reg <= i_lhu_signal;
        xori_signal_reg <= i_xori_signal;
        ori_signal_reg <= i_ori_signal;
        andi_signal_reg <= i_andi_signal;
        slli_signal_reg <= i_slli_signal;
        srli_signal_reg <= i_srli_signal;
        srai_signal_reg <= i_srai_signal;
        slti_signal_reg <= i_slti_signal;
        sltiu_signal_reg <= i_sltiu_signal;
        beq_signal_reg <= i_beq_signal;
        bne_signal_reg <= i_bne_signal;
        blt_signal_reg <= i_blt_signal;
        bge_signal_reg <= i_bge_signal;
        bltu_signal_reg <= i_bltu_signal;
        bgeu_signal_reg <= i_bgeu_signal;
        jal_signal_reg <= i_jal_signal;
        sw_signal_reg <= i_sw_signal;
        sh_signal_reg <= i_sh_signal;
        sb_signal_reg <= i_sb_signal;
        and_signal_reg <= i_and_signal;
        or_signal_reg <= i_or_signal;
        xor_signal_reg <= i_xor_signal;
        srl_signal_reg <= i_srl_signal;
        sra_signal_reg <= i_sra_signal;
        auipc_signal_reg <= i_auipc_signal;
        lui_signal_reg <= i_lui_signal;
        add_signal_reg <= i_add_signal;
        sub_signal_reg <= i_sub_signal;
        sll_signal_reg <= i_sll_signal;
        slt_signal_reg <= i_slt_signal;
        sltu_signal_reg <= i_sltu_signal;
        ebreak_signal_reg <= i_ebreak_signal;
        csrrs_signal_reg <= i_csrrs_signal;
        csrrw_signal_reg <= i_csrrw_signal;
        ecall_signal_reg <= i_ecall_signal;
        mret_signal_reg <= i_mret_signal;
    end
end





alu alu_u(
    .i_src1(src1_reg),
    .i_src2(src2_reg),
    .i_imm(imm_reg),
    .i_offset(offset_reg),
    .i_pc_data(pc_data_reg),
    .i_shamt(shamt_reg),
    .i_csr_data(csr_data_reg),
    .i_addi_signal(addi_signal_reg),
    .i_jalr_signal(jalr_signal_reg),
    .i_lb_signal(lb_signal_reg),
    .i_lh_signal(lh_signal_reg),
    .i_lw_signal(lw_signal_reg),
    .i_lbu_signal(lbu_signal_reg),
    .i_lhu_signal(lhu_signal_reg),
    .i_xori_signal(xori_signal_reg),
    .i_ori_signal(ori_signal_reg),
    .i_andi_signal(andi_signal_reg),
    .i_slli_signal(slli_signal_reg),
    .i_srli_signal(srli_signal_reg),
    .i_srai_signal(srai_signal_reg),
    .i_slti_signal(slti_signal_reg),
    .i_sltiu_signal(sltiu_signal_reg),
    .i_beq_signal(beq_signal_reg),
    .i_bne_signal(bne_signal_reg),
    .i_blt_signal(blt_signal_reg),
    .i_bge_signal(bge_signal_reg),
    .i_bltu_signal(bltu_signal_reg),
    .i_bgeu_signal(bgeu_signal_reg),
    .i_jal_signal(jal_signal_reg),
    .i_sw_signal(sw_signal_reg),
    .i_sh_signal(sh_signal_reg),
    .i_sb_signal(sb_signal_reg),
    .i_and_signal(and_signal_reg),
    .i_or_signal(or_signal_reg),
    .i_xor_signal(xor_signal_reg),
    .i_srl_signal(srl_signal_reg),
    .i_sra_signal(sra_signal_reg),
    .i_auipc_signal(auipc_signal_reg),
    .i_lui_signal(lui_signal_reg),
    .i_add_signal(add_signal_reg),
    .i_sub_signal(sub_signal_reg),
    .i_sll_signal(sll_signal_reg),
    .i_slt_signal(slt_signal_reg),
    .i_sltu_signal(sltu_signal_reg),
    .i_ebreak_signal(ebreak_signal_reg),
    .i_csrrs_signal(csrrs_signal_reg),
    .i_csrrw_signal(csrrw_signal_reg),
    .i_ecall_signal(ecall_signal_reg),
    .i_mret_signal(mret_signal_reg),
    .o_B_jump_signal(B_jump_signal),
    .o_data(data)
);


endmodule
