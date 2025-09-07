   module ysyx_25020042 (
        input clock,
        input reset_n,
        output [31:0] de_pc,
        output [31:0] de_next_pc,
        output [31:0] de_inst,
        output halt,
        output [31:0] reg_data [0:15],
        output [31:0] de_mstatus,
        output [31:0] de_mtvec,
        output [31:0] de_mepc,
        output [31:0] de_mcause
    );

    import "DPI-C" function void dpi_ebreak();
    // import "DPI-C" function void dpi_return();

    always @(posedge clock) begin
            if (ebreak_signal == 1'b1) begin
                dpi_ebreak();  // 调用 DPI-C 函数
            end
        end

    assign halt = EXU_halt_signal | IDU_halt_signal;
    assign de_pc = pc;
    assign de_next_pc = next_pc;
    assign de_inst = instruction;
    assign de_mstatus = mstatus;
    assign de_mtvec = mtvec;
    assign de_mepc = mepc;
    assign de_mcause = mcause;


    wire wbu_valid;
    wire pc_valid;
    wire lsu_ready;
    wire wbu_ready;
    wire ifu_valid;
    wire lsu_valid;

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
    wire IDU_halt_signal;
    wire EXU_halt_signal;
    wire [31:0] wdata;
    wire [31:0] imm;
    wire [31:0] src1;
    wire [31:0] src2;
    wire [31:0] offset;
    wire [5:0] shamt;
    wire [31:0] next_pc;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [3:0] wmask;
    wire [31:0] exu_data;
    wire [31:0] rdata;
    wire o_B_jump_signal;
    wire lsu_busy;
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
    wire [4:0]  rs1;
    wire [4:0]  rs2;
    wire [4:0]  rd;



    PC PC_u(
    .clock(clock),
    .reset_n(reset_n),
    .i_next_pc(next_pc),
    .wbu_valid(wbu_valid),
    .pc_valid(pc_valid),
    .o_pc(pc)
    );
    
    IFU IFU_u (
    .clock(clock),
    .reset_n(reset_n),
    .ifu_raddr(pc),
    .pc_valid(pc_valid),
    .lsu_ready(lsu_ready),
    .wbu_ready(wbu_ready),
    .ifu_valid(ifu_valid),
    .ifu_rdata(instruction)
    );

    IDU IDU_u (
    // .clock(clock),
    // .reset_n(reset_n),
    .i_inst(instruction),
    .o_imm(imm),
    .o_offset(offset),
    .o_shamt(shamt),
    .o_wmask(wmask),
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
    .o_halt_signal(IDU_halt_signal),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd)
    );

    EXU EXU_u (
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
    .o_B_jump_signal(o_B_jump_signal),
    .o_halt_signal(EXU_halt_signal),
    .o_data(exu_data)
    );

    WBU WBU_u (
    .clock(clock),
    .reset_n(reset_n),
    .i_exu_data(exu_data),
    .i_cur_pc(pc),
    .i_B_jump_signal(o_B_jump_signal),
    .i_jal_signal(jal_signal),
    .i_jalr_signal(jalr_signal),
    .i_lsu_busy(lsu_busy),
    .i_csrrw_signal(csrrw_signal),
    .i_csrrs_signal(csrrs_signal),
    .i_mret_signal(mret_signal),
    .i_ecall_signal(ecall_signal),
    .i_load_wdata(rdata),
    .i_csr_rdata(csr_data),
    .i_mstatus_rdata(mstatus),
    .i_mtvec_rdata(mtvec),
    .i_mepc_rdata(mepc),
    .i_mcause_rdata(mcause),
    .ifu_valid(ifu_valid),
    .lsu_valid(lsu_valid),
    .wbu_ready(wbu_ready),
    .wbu_valid(wbu_valid),
    .csr_wdata(csr_wdata),
    .reg_wdata(wdata),
    .o_mstatus_wdata(mstatus_wdata),
    .o_mtvec_wdata(mtvec_wdata),
    .o_mepc_wdata(mepc_wdata),
    .o_mcause_wdata(mcause_wdata),
    .next_pc(next_pc)
    );

    LSU LSU_u (
    .clock(clock),
    .reset_n(reset_n),
    .i_lbu_signal(lbu_signal),
    .i_lhu_signal(lhu_signal),
    .i_lb_signal(lb_signal),
    .i_lh_signal(lh_signal),
    .i_lw_signal(lw_signal),
    .i_sb_signal(sb_signal),
    .i_sh_signal(sh_signal),
    .i_sw_signal(sw_signal),
    .i_src2(src2),
    .i_data(exu_data),
    .i_wmask(wmask),
    .ifu_valid(ifu_valid),
    .wbu_ready(wbu_ready),
    .lsu_valid(lsu_valid),
    .lsu_ready(lsu_ready),
    .o_lsu_busy(lsu_busy),
    .o_rdata(rdata)
);
    csr csr_u (
    .clock(clock),
    .reset_n(reset_n),
    .i_ecall_signal(ecall_signal),
    .i_csr_wdata(csr_wdata),
    .i_csr_addr(csr_addr),
    .i_mcause_wdata(mcause_wdata),
    .i_mstatus_wdata(mstatus_wdata),
    .i_mtvec_wdata(mtvec_wdata),
    .i_mepc_wdata(mepc_wdata),
    .wbu_valid(wbu_valid),
    .o_mstatus(mstatus),
    .o_mtvec(mtvec),
    .o_mepc(mepc),
    .o_mcause(mcause),
    .o_csr_rdata(csr_data)
);
   gpr gpr_u(
    .clock(clock),
    .reset_n(reset_n), 
    .i_rs1(rs1),
    .i_rs2(rs2),
    .i_rd(rd),
    .i_data(wdata),
    .wbu_valid(wbu_valid),
    .o_src1(src1),
    .o_src2(src2),
    .o_reg_data(reg_data)
);
    endmodule
