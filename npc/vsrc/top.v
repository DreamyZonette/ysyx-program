   module top (
        input sys_clk,
        input sys_rst_n,
        output [31:0] de_pc,
        output [31:0] de_next_pc,
        output [31:0] de_inst,
        output halt,
        output [31:0] reg_data [0:31],
        output [31:0] de_mstatus,
        output [31:0] de_mtvec,
        output [31:0] de_mepc,
        output [31:0] de_mcause
    );

    import "DPI-C" function void dpi_ebreak();

    always @(posedge sys_clk) begin
            if (ebreak_signal == 1'b1) begin
                dpi_ebreak();  // 调用 DPI-C 函数
            end
        end

    // 调试信号
    assign halt = unknown_instruction;
    assign de_pc = pc;
    assign de_next_pc = next_pc;
    assign de_inst = instruction;
    assign de_mstatus = mstatus;
    assign de_mtvec = mtvec;
    assign de_mepc = mepc;
    assign de_mcause = mcause;

    // 多周期协议信号
    wire pc_valid;
    wire pc_ready;
    wire wbu_valid;
    wire wbu_ready;
    wire ifu_valid;
    wire ifu_ready;
    wire idu_valid;
    wire idu_ready;
    wire exu_valid;
    wire exu_ready;
    wire lsu_valid;
    wire lsu_ready;
    wire csr_valid;
    wire csr_ready;
    wire load_valid; // 存储成功信号
    wire store_valid; // 存储成功信号
    // 没有实现存储器，所以恒为1
    assign load_valid = 1'b1;
    assign store_valid = 1'b1;

    // 译码指令信号
    wire addi_signal;
    wire andi_signal;
    wire slti_signal;
    wire xori_signal;
    wire ori_signal;
    wire ebreak_signal;
    wire jalr_signal;
    wire lbu_signal;
    wire lw_signal;
    wire auipc_signal;
    wire lui_signal;
    wire lb_signal;
    wire lh_signal;
    wire lhu_signal;
    wire srai_signal;
    wire slli_signal;
    wire sb_signal;
    wire sltiu_signal;
    wire srli_signal;
    wire sll_signal;
    wire jal_signal;
    wire sw_signal;
    wire add_signal;
    wire and_signal;
    wire or_signal;
    wire xor_signal;
    wire sub_signal;
    wire slt_signal;
    wire sltu_signal;
    wire sra_signal;
    wire srl_signal;
    wire beq_signal;
    wire bne_signal;
    wire bge_signal;
    wire bgeu_signal;
    wire blt_signal;
    wire bltu_signal;
    wire sh_signal;
    wire csrrs_signal;
    wire csrrw_signal;
    wire ecall_signal;
    wire mret_signal;
    wire unknown_instruction;

    // 数据传输信号
    wire [31:0] wdata;
    wire [31:0] imm;
    wire [31:0] src1;
    wire [31:0] src2;
    wire [31:0] offset;
    wire [5:0] shamt;
    wire [31:0] next_pc;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] exu_data;
    wire [31:0] rdata;
    wire o_B_jump_signal;
    wire load_signal;
    wire [11:0] csr_addr;
    wire [31:0] csr_data;
    wire [31:0] mstatus;
    wire [31:0] mtvec;
    wire [31:0] mepc;
    wire [31:0] mcause;
    wire [31:0] mcause_wdata;
    wire [31:0] mstatus_wdata;
    wire [31:0] mtvec_wdata;
    wire [31:0] mepc_wdata;
    wire [31:0] csr_wdata;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;

    // 实例化模块
    PC PC_u(
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_wbu_valid(wbu_valid),
    .i_ifu_ready(ifu_ready),
    .i_next_pc(next_pc),
    .o_pc_valid(pc_valid),
    .o_pc_ready(pc_ready), 
    .o_pc(pc)
    );
    
    IFU IFU_u (
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_pc(pc),
    .i_pc_valid(pc_valid),
    .i_idu_ready(idu_ready),
    .o_ifu_valid(ifu_valid),
    .o_ifu_ready(ifu_ready),
    .o_instruction(instruction)
    );

    IDU IDU_u (
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_inst(instruction),
    .i_ifu_valid(ifu_valid),
    .i_exu_ready(exu_ready),
    .i_lsu_ready(lsu_ready),
    .o_idu_ready(idu_ready),
    .o_idu_valid(idu_valid),
    .o_rs1(rs1),
    .o_rs2(rs2),
    .o_rd(rd),
    .o_imm(imm),
    .o_offset(offset),
    .o_shamt(shamt),
    .o_csr_addr(csr_addr),
    .o_addi_signal(addi_signal),
    .o_andi_signal(andi_signal),
    .o_slti_signal(slti_signal),
    .o_xori_signal(xori_signal),
    .o_ori_signal(ori_signal),
    .o_ebreak_signal(ebreak_signal),
    .o_jalr_signal(jalr_signal),
    .o_lbu_signal(lbu_signal),
    .o_lw_signal(lw_signal),
    .o_auipc_signal(auipc_signal),
    .o_lui_signal(lui_signal),
    .o_lb_signal(lb_signal),
    .o_lh_signal(lh_signal),
    .o_lhu_signal(lhu_signal),
    .o_srai_signal(srai_signal),
    .o_slli_signal(slli_signal),
    .o_sb_signal(sb_signal),
    .o_sltiu_signal(sltiu_signal),
    .o_srli_signal(srli_signal),
    .o_sll_signal(sll_signal),
    .o_jal_signal(jal_signal),
    .o_sw_signal(sw_signal),
    .o_add_signal(add_signal),
    .o_and_signal(and_signal),
    .o_or_signal(or_signal),
    .o_xor_signal(xor_signal),
    .o_sub_signal(sub_signal),
    .o_slt_signal(slt_signal),
    .o_sltu_signal(sltu_signal),
    .o_sra_signal(sra_signal),
    .o_srl_signal(srl_signal),
    .o_beq_signal(beq_signal),
    .o_bne_signal(bne_signal),
    .o_bge_signal(bge_signal),
    .o_bgeu_signal(bgeu_signal),
    .o_blt_signal(blt_signal),
    .o_bltu_signal(bltu_signal),
    .o_sh_signal(sh_signal),
    .o_csrrs_signal(csrrs_signal),
    .o_csrrw_signal(csrrw_signal),
    .o_ecall_signal(ecall_signal),
    .o_mret_signal(mret_signal),
    .o_unknown_inst(unknown_instruction),
    );

    EXU EXU_u (
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_src1(src1),
    .i_src2(src2),
    .i_imm(imm),
    .i_offset(offset),
    .i_pc_data(pc),
    .i_shamt(shamt),
    .i_csr_data(csr_data),
    .i_addi_signal(addi_signal),
    .i_jalr_signal(jalr_signal),
    .i_lb_signal(lb_signal),
    .i_lh_signal(lh_signal),
    .i_lw_signal(lw_signal),
    .i_lbu_signal(lbu_signal),
    .i_lhu_signal(lhu_signal),
    .i_xori_signal(xori_signal),
    .i_ori_signal(ori_signal),
    .i_andi_signal(andi_signal),
    .i_slli_signal(slli_signal),
    .i_srli_signal(srli_signal),
    .i_srai_signal(srai_signal),
    .i_slti_signal(slti_signal),
    .i_sltiu_signal(sltiu_signal),
    .i_beq_signal(beq_signal),
    .i_bne_signal(bne_signal),
    .i_blt_signal(blt_signal),
    .i_bge_signal(bge_signal),
    .i_bltu_signal(bltu_signal),
    .i_bgeu_signal(bgeu_signal),
    .i_jal_signal(jal_signal),
    .i_sw_signal(sw_signal),
    .i_sh_signal(sh_signal),
    .i_sb_signal(sb_signal),
    .i_and_signal(and_signal),
    .i_or_signal(or_signal),
    .i_xor_signal(xor_signal),
    .i_srl_signal(srl_signal),
    .i_sra_signal(sra_signal),
    .i_auipc_signal(auipc_signal),
    .i_lui_signal(lui_signal),
    .i_add_signal(add_signal),
    .i_sub_signal(sub_signal),
    .i_sll_signal(sll_signal),
    .i_slt_signal(slt_signal),
    .i_sltu_signal(sltu_signal),
    .i_ebreak_signal(ebreak_signal),
    .i_csrrs_signal(csrrs_signal),
    .i_csrrw_signal(csrrw_signal),
    .i_ecall_signal(ecall_signal),
    .i_mret_signal(mret_signal),
    .i_idu_valid(idu_valid),
    .i_wbu_ready(wbu_ready),
    .i_lsu_ready(lsu_ready),
    .o_exu_valid(exu_valid),
    .o_exu_ready(exu_ready),
    .o_B_jump_signal(o_B_jump_signal),
    .o_data(exu_data)
    );

    WBU WBU_u (
    .i_sys_rst_n(sys_rst_n),
    .i_sys_clk(sys_clk),
    .i_exu_data(exu_data),
    .i_cur_pc(pc),
    .i_B_jump_signal(o_B_jump_signal),
    .i_jal_signal(jal_signal),
    .i_jalr_signal(jalr_signal),
    .i_load_signal(load_signal),
    .i_csrrw_signal(csrrw_signal),
    .i_csrrs_signal(csrrs_signal),
    .i_mret_signal(mret_signal),
    .i_ecall_signal(ecall_signal),
    .i_exu_valid(exu_valid), 
    .i_lsu_valid(lsu_valid), 
    .i_csr_valid(csr_valid), 
    .i_pc_ready(pc_ready), 
    .i_load_wdata(rdata),
    .i_csr_rdata(csr_data),
    .i_mstatus_rdata(mstatus),
    .i_mtvec_rdata(mtvec),
    .i_mepc_rdata(mepc),
    .i_mcause_rdata(mcause),
    .o_csr_wdata(csr_wdata),
    .o_reg_wdata(wdata),
    .o_mstatus_wdata(mstatus_wdata),
    .o_mtvec_wdata(mtvec_wdata),
    .o_mepc_wdata(mepc_wdata),
    .o_mcause_wdata(mcause_wdata),
    .o_next_pc(next_pc),
    .o_wbu_ready(wbu_ready), 
    .o_wbu_valid(wbu_valid) 
    );

    LSU LSU_u (
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_lbu_signal(lbu_signal),
    .i_lhu_signal(lhu_signal),
    .i_lb_signal(lb_signal),
    .i_lh_signal(lh_signal),
    .i_lw_signal(lw_signal),
    .i_sb_signal(sb_signal),
    .i_sh_signal(sh_signal),
    .i_sw_signal(sw_signal),
    .i_exu_valid(exu_valid),
    .i_idu_valid(idu_valid),
    .i_wbu_ready(wbu_ready),
    .i_load_valid(load_valid),
    .i_store_valid(store_valid),
    .i_src2(src2),
    .i_data(exu_data),
    .o_load_signal(load_signal),
    .o_rdata(rdata),
    .o_lsu_valid(lsu_valid),
    .o_lsu_ready(lsu_ready)
);
    csr csr_u (
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_ecall_signal(ecall_signal),
    .i_csr_wdata(csr_wdata),
    .i_csr_addr(csr_addr),
    .i_mcause_wdata(mcause_wdata),
    .i_mstatus_wdata(mstatus_wdata),
    .i_mtvec_wdata(mtvec_wdata),
    .i_mepc_wdata(mepc_wdata),
    .o_mstatus(mstatus),
    .o_mtvec(mtvec),
    .o_mepc(mepc),
    .o_mcause(mcause),
    .o_csr_rdata(csr_data),
    .o_csr_valid(csr_valid),
    .o_csr_ready(csr_ready)
);
gpr gpr_u(
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n), 
    .i_rs1(rs1),
    .i_rs2(rs2),
    .i_rd(rd),
    .i_data(wdata),
    .o_src1(src1),
    .o_src2(src2),
    .o_reg_data(reg_data)
);

   
    endmodule
