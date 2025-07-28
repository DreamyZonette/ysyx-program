   module top (
        input sys_clk,
        input sys_rst_n,
        // input [31:0] inst,
        output [31:0] de_pc,
        output [31:0] de_next_pc,
        output [31:0] de_inst,
        output halt,
        output [31:0] reg_data [0:31]
    );

    import "DPI-C" function void dpi_ebreak();
    // import "DPI-C" function void dpi_return();

    always @(posedge sys_clk) begin
            if (ebreak_signal == 1'b1) begin
                dpi_ebreak();  // 调用 DPI-C 函数
            end
            // else if (instruction == 32'h0000006F) begin
            //     dpi_return();
            // end
        end

    assign halt = EXU_halt_signal | IDU_halt_signal;
    assign de_pc = pc;
    assign de_next_pc = next_pc;
    assign de_inst = instruction;

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
    // wire mul_signal;
    // wire mulh_signal;
    // wire mulhu_signal;
    // wire mulhsu_signal;
    // wire div_signal;
    // wire divu_signal;
    // wire rem_signal;
    // wire remu_signal;
    wire sra_signal;
    wire srl_signal;
    wire beq_signal;
    wire bne_signal;
    wire bge_signal;
    wire bgeu_signal;
    wire blt_signal;
    wire bltu_signal;
    wire sh_signal;
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
    wire [31:0] data;
    wire [31:0] rdata;
    wire o_B_jump_signal;
    wire load_signal;


    PC PC_u(
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_next_pc(next_pc),
    .o_pc(pc)
    );
    
    IFU IFU_u (
    //.i_sys_clk(sys_clk),
    .i_pc(pc),
    .o_instruction(instruction)
    );

    IDU IDU_u (
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_inst(instruction),
    .i_wdata(wdata),
    .o_src1(src1),
    .o_src2(src2),
    .o_imm(imm),
    .o_offset(offset),
    .o_shamt(shamt),
    .o_wmask(wmask),
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
    // .o_mul_signal(mul_signal),
    // .o_mulh_signal(mulh_signal),
    // .o_mulhu_signal(mulhu_signal),
    // .o_mulhsu_signal(mulhsu_signal),
    // .o_div_signal(div_signal),
    // .o_divu_signal(divu_signal),
    // .o_rem_signal(rem_signal),
    // .o_remu_signal(remu_signal),
    .o_sra_signal(sra_signal),
    .o_srl_signal(srl_signal),
    .o_beq_signal(beq_signal),
    .o_bne_signal(bne_signal),
    .o_bge_signal(bge_signal),
    .o_bgeu_signal(bgeu_signal),
    .o_blt_signal(blt_signal),
    .o_bltu_signal(bltu_signal),
    .o_sh_signal(sh_signal),
    .o_halt_signal(IDU_halt_signal),
    .o_reg_data(reg_data)
    );

    EXU EXU_u (
    .i_src1(src1),
    .i_src2(src2),
    .i_imm(imm),
    .i_offset(offset),
    .i_pc_data(pc),
    .i_shamt(shamt),
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
    // .i_mul_signal(mul_signal),
    // .i_mulh_signal(mulh_signal),
    // .i_mulhu_signal(mulhu_signal),
    // .i_mulhsu_signal(mulhsu_signal),
    // .i_div_signal(div_signal),
    // .i_divu_signal(divu_signal),
    // .i_rem_signal(rem_signal),
    // .i_remu_signal(remu_signal),
    .i_auipc_signal(auipc_signal),
    .i_lui_signal(lui_signal),
    .i_add_signal(add_signal),
    .i_sub_signal(sub_signal),
    .i_sll_signal(sll_signal),
    .i_slt_signal(slt_signal),
    .i_sltu_signal(sltu_signal),
    .i_ebreak_signal(ebreak_signal),
    .o_B_jump_signal(o_B_jump_signal),
    .o_halt_signal(EXU_halt_signal),
    .o_data(data)
    );

    WBU WBU_u (
    .i_sys_rst_n(sys_rst_n),
    .i_B_jump_signal(o_B_jump_signal),
    .i_jal_signal(jal_signal),
    .i_jalr_signal(jalr_signal),
    .i_load_signal(load_signal),
    .i_load_wdata(rdata),
    .i_cur_pc(pc),
    .i_sys_wdata(data),
    .o_reg_wdata(wdata),
    .o_next_pc(next_pc)
    );

    LSU LSU_u (
    .i_sys_clk(sys_clk),
    //.i_sys_rst_n(sys_rst_n),
    .i_lbu_signal(lbu_signal),
    .i_lhu_signal(lhu_signal),
    .i_lb_signal(lb_signal),
    .i_lh_signal(lh_signal),
    .i_lw_signal(lw_signal),
    .i_sb_signal(sb_signal),
    .i_sh_signal(sh_signal),
    .i_sw_signal(sw_signal),
    .i_src2(src2),
    .i_data(data),
    .i_wmask(wmask),
    .o_load_signal(load_signal),
    .o_rdata(rdata)
);
   
    endmodule
