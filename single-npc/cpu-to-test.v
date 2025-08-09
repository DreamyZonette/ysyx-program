   module top (
        input sys_clk,
        input sys_rst_n// ,
        // // input [31:0] inst,
        // output [31:0] de_pc,
        // output [31:0] de_next_pc,
        // output [31:0] de_inst,
        // output halt,
        // output [31:0] reg_data [0:31],
        // output [31:0] de_mstatus,
        // output [31:0] de_mtvec,
        // output [31:0] de_mepc,
        // output [31:0] de_mcause
    );

    // import "DPI-C" function void dpi_ebreak();
    // // import "DPI-C" function void dpi_return();

    // always @(posedge sys_clk) begin
    //         if (ebreak_signal == 1'b1) begin
    //             dpi_ebreak();  // 调用 DPI-C 函数
    //         end
    //         // else if (instruction == 32'h0000006F) begin
    //         //     dpi_return();
    //         // end
    //     end

    // assign halt = EXU_halt_signal | IDU_halt_signal;
    // assign de_pc = pc;
    // assign de_next_pc = next_pc;
    // assign de_inst = instruction;
    // assign de_mstatus = mstatus;
    // assign de_mtvec = mtvec;
    // assign de_mepc = mepc;
    // assign de_mcause = mcause;


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
    .o_csrrs_signal(csrrs_signal),
    .o_csrrw_signal(csrrw_signal),
    .o_ecall_signal(ecall_signal),
    .o_mret_signal(mret_signal),
    .o_halt_signal(IDU_halt_signal)// ,
    // .o_reg_data(reg_data)
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
    .i_csrrs_signal(csrrs_signal),
    .i_csrrw_signal(csrrw_signal),
    .i_ecall_signal(ecall_signal),
    .i_mret_signal(mret_signal),
    .o_B_jump_signal(o_B_jump_signal),
    .o_halt_signal(EXU_halt_signal),
    .o_data(exu_data)
    );

    WBU WBU_u (
    .i_sys_rst_n(sys_rst_n),
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
    .i_data(exu_data),
    .i_wmask(wmask),
    .o_load_signal(load_signal),
    .o_rdata(rdata)
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
    .o_csr_rdata(csr_data)
);
   
    endmodule

module csr (
    input i_sys_clk,
    input i_sys_rst_n,
    input i_ecall_signal,
    input [31:0] i_csr_wdata,
    input [11:0] i_csr_addr,
    input [31:0] i_mstatus_wdata,
    input [31:0] i_mtvec_wdata,
    input [31:0] i_mepc_wdata,
    input [31:0] i_mcause_wdata,
    output [31:0] o_mstatus,
    output [31:0] o_mtvec,
    output [31:0] o_mepc,
    output [31:0] o_mcause,
    output reg [31:0] o_csr_rdata
);

reg [3:0] wen;
wire [31:0] mstatus_wdata;
wire [31:0] mtvec_wdata;
wire [31:0] mepc_wdata;
wire [31:0] mcause_wdata;

assign mstatus_wdata = (i_ecall_signal == 1'b1) ? i_mstatus_wdata : i_csr_wdata;
assign mtvec_wdata   = (i_ecall_signal == 1'b1) ? i_mtvec_wdata   : i_csr_wdata;
assign mepc_wdata    = (i_ecall_signal == 1'b1) ? i_mepc_wdata    : i_csr_wdata;
assign mcause_wdata  = (i_ecall_signal == 1'b1) ? i_mcause_wdata  : i_csr_wdata;


always @(*) begin
    wen = 4'b0;
    o_csr_rdata = 32'b0;
    if(i_ecall_signal == 1'b1) begin
        wen = 4'b1111;
        o_csr_rdata = 32'b0;
    end else if(i_csr_addr == 12'h300) begin
        wen[0] = 1'b1;
        o_csr_rdata = o_mstatus;
    end else if(i_csr_addr == 12'h305) begin
        wen[1] = 1'b1;
        o_csr_rdata = o_mtvec;
    end else if(i_csr_addr == 12'h341) begin
        wen[2] = 1'b1;
        o_csr_rdata = o_mepc;
    end else if(i_csr_addr == 12'h342) begin
        wen[3] = 1'b1;
        o_csr_rdata = o_mcause;
    end
end

Reg #(32, 32'h1800) mstatus (i_sys_clk, i_sys_rst_n, mstatus_wdata, o_mstatus ,  wen[0]);
Reg #(32, 32'b0)    mtvec   (i_sys_clk, i_sys_rst_n, mtvec_wdata  , o_mtvec   ,  wen[1]);
Reg #(32, 32'b0)    mepc    (i_sys_clk, i_sys_rst_n, mepc_wdata   , o_mepc    ,  wen[2]);
Reg #(32, 32'b0)    mcause  (i_sys_clk, i_sys_rst_n, mcause_wdata , o_mcause  ,  wen[3]);

endmodule

module EXU(
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
    // input wire i_mul_signal,
    // input wire i_mulh_signal,
    // input wire i_mulhu_signal,
    // input wire i_mulhsu_signal,
    // input wire i_div_signal,
    // input wire i_divu_signal,
    // input wire i_rem_signal,
    // input wire i_remu_signal,
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
    output wire o_B_jump_signal,
    output wire o_halt_signal,
    output wire [31:0] o_data

);

alu alu_u(
    .i_src1(i_src1),
    .i_src2(i_src2),
    .i_imm(i_imm),
    .i_offset(i_offset),
    .i_pc_data(i_pc_data),
    .i_shamt(i_shamt),
    .i_csr_data(i_csr_data),
    .i_addi_signal(i_addi_signal),
    .i_jalr_signal(i_jalr_signal),
    .i_lb_signal(i_lb_signal),
    .i_lh_signal(i_lh_signal),
    .i_lw_signal(i_lw_signal),
    .i_lbu_signal(i_lbu_signal),
    .i_lhu_signal(i_lhu_signal),
    .i_xori_signal(i_xori_signal),
    .i_ori_signal(i_ori_signal),
    .i_andi_signal(i_andi_signal),
    .i_slli_signal(i_slli_signal),
    .i_srli_signal(i_srli_signal),
    .i_srai_signal(i_srai_signal),
    .i_slti_signal(i_slti_signal),
    .i_sltiu_signal(i_sltiu_signal),
    .i_beq_signal(i_beq_signal),
    .i_bne_signal(i_bne_signal),
    .i_blt_signal(i_blt_signal),
    .i_bge_signal(i_bge_signal),
    .i_bltu_signal(i_bltu_signal),
    .i_bgeu_signal(i_bgeu_signal),
    .i_jal_signal(i_jal_signal),
    .i_sw_signal(i_sw_signal),
    .i_sh_signal(i_sh_signal),
    .i_sb_signal(i_sb_signal),
    .i_and_signal(i_and_signal),
    .i_or_signal(i_or_signal),
    .i_xor_signal(i_xor_signal),
    .i_srl_signal(i_srl_signal),
    .i_sra_signal(i_sra_signal),
    // .i_mul_signal(i_mul_signal),
    // .i_mulh_signal(i_mulh_signal),
    // .i_mulhu_signal(i_mulhu_signal),
    // .i_mulhsu_signal(i_mulhsu_signal),
    // .i_div_signal(i_div_signal),
    // .i_divu_signal(i_divu_signal),
    // .i_rem_signal(i_rem_signal),
    // .i_remu_signal(i_remu_signal),
    .i_auipc_signal(i_auipc_signal),
    .i_lui_signal(i_lui_signal),
    .i_add_signal(i_add_signal),
    .i_sub_signal(i_sub_signal),
    .i_sll_signal(i_sll_signal),
    .i_slt_signal(i_slt_signal),
    .i_sltu_signal(i_sltu_signal),
    .i_ebreak_signal(i_ebreak_signal),
    .i_csrrs_signal(i_csrrs_signal),
    .i_csrrw_signal(i_csrrw_signal),
    .i_ecall_signal(i_ecall_signal),
    .i_mret_signal(i_mret_signal),
    .o_B_jump_signal(o_B_jump_signal),
    .o_halt_signal(o_halt_signal),
    .o_data(o_data)
);


endmodule

// Modified by Long for NPC
module alu (
    input [31:0] i_src1,
    input [31:0] i_src2,
    input [31:0] i_imm ,
    input [31:0] i_offset,
    input [31:0] i_pc_data,
    input [5:0]       i_shamt,
    input [31:0]      i_csr_data,
    input             i_addi_signal,
    input             i_jalr_signal,
    input             i_lb_signal,
    input             i_lh_signal,
    input             i_lw_signal,
    input             i_lbu_signal,
    input             i_lhu_signal,
    input             i_xori_signal,
    input             i_ori_signal,
    input             i_andi_signal,
    input             i_slli_signal,
    input             i_srli_signal,
    input             i_srai_signal,
    input             i_slti_signal,
    input             i_sltiu_signal,
    input             i_beq_signal,
    input             i_bne_signal,
    input             i_blt_signal,
    input             i_bge_signal,
    input             i_bltu_signal,
    input             i_bgeu_signal,
    input             i_jal_signal,
    input             i_sw_signal,
    input             i_sh_signal,
    input             i_sb_signal,
    input             i_and_signal,
    input             i_or_signal,
    input             i_xor_signal,
    input             i_srl_signal,
    input             i_sra_signal,
    // input             i_mul_signal,
    // input             i_mulh_signal,
    // input             i_mulhu_signal,
    // input             i_mulhsu_signal,
    // input             i_div_signal,
    // input             i_divu_signal,
    // input             i_rem_signal,
    // input             i_remu_signal,
    input             i_auipc_signal,
    input             i_lui_signal,
    input             i_add_signal,
    input             i_sub_signal,
    input             i_sll_signal,
    input             i_slt_signal,
    input             i_sltu_signal,
    input             i_ebreak_signal,
    input             i_csrrs_signal,
    input             i_csrrw_signal,
    input             i_ecall_signal,
    input             i_mret_signal,
    output reg        o_B_jump_signal,
    output reg        o_halt_signal,
    output reg [31:0] o_data
    );

    wire [31:0] srai_result;

    always @ (*) begin
        o_data = 32'b0;
        o_B_jump_signal = 1'b0;
        o_halt_signal = 1'b0;
        // I型
        if(i_addi_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_jalr_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lb_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lh_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lw_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lbu_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_lhu_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_xori_signal == 1'b1) begin
            o_data = i_src1 ^ i_imm;
        end else if(i_ori_signal == 1'b1) begin
            o_data = i_src1 | i_imm;
        end else if(i_andi_signal == 1'b1) begin
            o_data = i_src1 & i_imm;
        end else if(i_slli_signal == 1'b1) begin
            o_data = i_src1 << i_shamt;
        end else if(i_srli_signal == 1'b1) begin
            o_data = i_src1 >> i_shamt;
        end else if(i_srai_signal == 1'b1) begin
            o_data = srai_result;
        end else if(i_slti_signal == 1'b1) begin
            o_data = $signed(i_src1) < $signed(i_imm) ? 32'h1 : 32'h0;
        end else if(i_sltiu_signal == 1'b1) begin
            o_data = i_src1 < i_imm ? 32'h1 : 32'h0;
        end else if(i_csrrw_signal == 1'b1) begin
            o_data = i_src1;
        end else if(i_csrrs_signal == 1'b1) begin
            o_data = i_csr_data | i_src1;
        end else if(i_ecall_signal == 1'b1) begin
            o_data = 0;
        end else if(i_mret_signal == 1'b1) begin
            o_data = 0;
        end else if(i_ebreak_signal == 1'b1) begin
            o_data = 0;
        // U型
        end else if(i_auipc_signal == 1'b1) begin
            o_data = i_pc_data + i_imm;
        end else if(i_lui_signal == 1'b1) begin
            o_data = i_imm;
        // R型
        end else if(i_add_signal == 1'b1) begin
            o_data = i_src1 + i_src2;
        end else if(i_sub_signal == 1'b1) begin
            o_data = i_src1 - i_src2;
        end else if(i_and_signal == 1'b1) begin
            o_data = i_src1 & i_src2;
        end else if(i_or_signal == 1'b1) begin
            o_data = i_src1 | i_src2;
        end else if(i_xor_signal == 1'b1) begin
            o_data = i_src1 ^ i_src2;
        end else if(i_slt_signal == 1'b1) begin
            o_data = $signed(i_src1) < $signed(i_src2) ? 32'h1 : 32'h0;
        end else if(i_sltu_signal == 1'b1) begin
            o_data = i_src1 < i_src2 ? 32'h1 : 32'h0;
        end else if(i_sll_signal == 1'b1) begin
            o_data = i_src1 << i_src2[4:0];
        end else if(i_srl_signal == 1'b1) begin
            o_data = i_src1 >> i_src2[4:0];
        end else if(i_sra_signal == 1'b1) begin
            o_data = $signed(i_src1) >>> i_src2[4:0];
        // end else if(i_mul_signal == 1'b1) begin
        //     o_data = i_src1 * i_src2;
        // end else if(i_mulh_signal == 1'b1) begin
        //     o_data = $signed(i_src1) * $signed(i_src2) >> 32;
        // end else if(i_mulhu_signal == 1'b1) begin
        //     o_data = i_src1 * i_src2 >> 32;
        // end else if(i_mulhsu_signal == 1'b1) begin
        //     o_data = $signed(i_src1) * i_src2 >> 32;
        // end else if(i_div_signal == 1'b1) begin
        //     o_data = $signed(i_src1) / $signed(i_src2);
        // end else if(i_divu_signal == 1'b1) begin
        //     o_data = i_src1 / i_src2;
        // end else if(i_rem_signal == 1'b1) begin
        //     o_data = $signed(i_src1) % $signed(i_src2);
        // end else if(i_remu_signal == 1'b1) begin
        //     o_data = i_src1 % i_src2;
        // B型
        end else if(i_beq_signal == 1'b1) begin
            o_B_jump_signal = (i_src1 == i_src2) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_bne_signal == 1'b1) begin
            o_B_jump_signal = (i_src1!= i_src2) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_blt_signal == 1'b1) begin
            o_B_jump_signal = ($signed(i_src1) < $signed(i_src2)) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_bge_signal == 1'b1) begin
            o_B_jump_signal = ($signed(i_src1) >= $signed(i_src2)) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_bltu_signal == 1'b1) begin
            o_B_jump_signal = (i_src1 < i_src2) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end else if(i_bgeu_signal == 1'b1) begin
            o_B_jump_signal = (i_src1 >= i_src2) ? 1'b1 : 1'b0;
            o_data = i_pc_data + i_offset;
        end
        // J型
        else if(i_jal_signal == 1'b1) begin
            o_data = i_pc_data + i_offset;
        // S型
        end else if(i_sw_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_sh_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end else if(i_sb_signal == 1'b1) begin
            o_data = i_src1 + i_imm;
        end 
        else begin
            //o_halt_signal = 1'b1;
            o_data = 32'b0;         // 无操作
            o_B_jump_signal = 1'b0;
            o_halt_signal = 1'b0;   // 不停止
        end
    end
    
ArithmeticRightShift ArithmeticRightShift_u(
    .i_src1(i_src1),
    .i_shamt(i_shamt),
    .o_data(srai_result)
);

endmodule

module ArithmeticRightShift(
    input [31:0] i_src1,
    input [5:0] i_shamt,
    output reg [31:0] o_data
);

    always @(*) begin
        case (i_shamt)
            6'd0: o_data = i_src1;
            6'd1: o_data = {i_src1[31], i_src1[31:1]};
            6'd2: o_data = {{2{i_src1[31]}}, i_src1[31:2]};
            6'd3: o_data = {{3{i_src1[31]}}, i_src1[31:3]};
            6'd4: o_data = {{4{i_src1[31]}}, i_src1[31:4]};
            6'd5: o_data = {{5{i_src1[31]}}, i_src1[31:5]};
            6'd6: o_data = {{6{i_src1[31]}}, i_src1[31:6]};
            6'd7: o_data = {{7{i_src1[31]}}, i_src1[31:7]};
            6'd8: o_data = {{8{i_src1[31]}}, i_src1[31:8]};
            6'd9: o_data = {{9{i_src1[31]}}, i_src1[31:9]};
            6'd10: o_data = {{10{i_src1[31]}}, i_src1[31:10]};
            6'd11: o_data = {{11{i_src1[31]}}, i_src1[31:11]};
            6'd12: o_data = {{12{i_src1[31]}}, i_src1[31:12]};
            6'd13: o_data = {{13{i_src1[31]}}, i_src1[31:13]};
            6'd14: o_data = {{14{i_src1[31]}}, i_src1[31:14]};
            6'd15: o_data = {{15{i_src1[31]}}, i_src1[31:15]};
            6'd16: o_data = {{16{i_src1[31]}}, i_src1[31:16]};
            6'd17: o_data = {{17{i_src1[31]}}, i_src1[31:17]};
            6'd18: o_data = {{18{i_src1[31]}}, i_src1[31:18]};
            6'd19: o_data = {{19{i_src1[31]}}, i_src1[31:19]};
            6'd20: o_data = {{20{i_src1[31]}}, i_src1[31:20]};
            6'd21: o_data = {{21{i_src1[31]}}, i_src1[31:21]};
            6'd22: o_data = {{22{i_src1[31]}}, i_src1[31:22]};
            6'd23: o_data = {{23{i_src1[31]}}, i_src1[31:23]};
            6'd24: o_data = {{24{i_src1[31]}}, i_src1[31:24]};
            6'd25: o_data = {{25{i_src1[31]}}, i_src1[31:25]};
            6'd26: o_data = {{26{i_src1[31]}}, i_src1[31:26]};
            6'd27: o_data = {{27{i_src1[31]}}, i_src1[31:27]};
            6'd28: o_data = {{28{i_src1[31]}}, i_src1[31:28]};
            6'd29: o_data = {{29{i_src1[31]}}, i_src1[31:29]};
            6'd30: o_data = {{30{i_src1[31]}}, i_src1[31:30]};
            6'd31: o_data = {{31{i_src1[31]}}, i_src1[31]};
            default: o_data = {32{i_src1[31]}}; // 31位及以上
        endcase
    end

endmodule

module IDU (
    input i_sys_clk,
    input i_sys_rst_n, 
    input   [31:0]  i_inst,
    input   [31:0]  i_wdata,
    output reg [31:0]  o_src1,
    output reg [31:0]  o_src2,
    output reg [31:0]  o_imm,
    output reg [31:0]  o_offset,
    output reg [5:0]   o_shamt,
    output     [3:0]  o_wmask,
    output     [11:0]  o_csr_addr,
    output  o_addi_signal,
    output  o_andi_signal,
    output  o_xori_signal,
    output  o_ori_signal,
    output  o_ebreak_signal,
    output  o_jalr_signal,
    output  o_lbu_signal,
    output  o_lw_signal,
    output  o_auipc_signal,
    output  o_lui_signal,
    output  o_lb_signal,
    output  o_lh_signal,
    output  o_lhu_signal,
    output  o_srai_signal,
    output  o_slli_signal,
    output  o_sb_signal,
    output  o_slti_signal,
    output  o_sltiu_signal,
    output  o_srli_signal,
    output  o_sll_signal,
    output  o_jal_signal,
    output  o_sw_signal,
    output  o_add_signal,
    output  o_and_signal,
    output  o_or_signal,
    output  o_xor_signal,
    output  o_sub_signal,
    output  o_slt_signal,
    output  o_sltu_signal,
    // output  o_mul_signal,
    // output  o_mulh_signal,
    // output  o_mulhu_signal,
    // output  o_mulhsu_signal,
    // output  o_div_signal,
    // output  o_divu_signal,
    // output  o_rem_signal,
    // output  o_remu_signal,
    output  o_sra_signal,
    output  o_srl_signal,
    output  o_beq_signal,
    output  o_bne_signal,
    output  o_bge_signal,
    output  o_bgeu_signal,
    output  o_blt_signal,
    output  o_bltu_signal,
    output  o_sh_signal,
    output  o_csrrs_signal,
    output  o_csrrw_signal,
    output  o_ecall_signal,
    output  o_mret_signal,
    output  o_halt_signal//,
    //output  [31:0] o_reg_data [0:31]
    );

    wire [6:0]  opcode;
    wire [31:0] J_offset;
    wire [31:0] I_imm;
    wire [4:0]  I_rs1;
    wire [4:0]  I_rd;
    wire [5:0]  I_shamt;
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
    wire J_halt_signal;
    wire S_halt_signal;
    wire R_halt_signal;
    wire I_halt_signal;
    wire U_halt_signal;
    wire B_halt_signal;
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
    //reg [4:0] shamt;
    reg [31:0] wdata;

    assign opcode = i_inst[6:0];
    assign o_halt_signal = (invalid_opcode_signal | 
        (J_halt_signal & Jtype_signal)| (S_halt_signal & Stype_signal) | 
        (R_halt_signal & Rtype_signal)| (I_halt_signal & Itype_signal) | 
        (U_halt_signal & Utype_signal)| (B_halt_signal & Btype_signal));

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


    always @(*) begin
        o_imm = 32'b0;
        o_offset = 32'b0;
        rs1 = 5'b0;
        rs2 = 5'b0;
        rd  = 5'b0;
        o_shamt  = 6'b0;
        if(Itype_signal == 1'b1) begin
            rs1 = I_rs1;
            rs2 = 5'b0;
            rd  = I_rd;
            o_imm = I_imm;
            o_shamt = I_shamt;
            o_offset = 32'b0;
        end
        else if(Utype_signal == 1'b1) begin
            rs1 = 5'b0;
            rs2 = 5'b0;
            rd  = U_rd;
            o_imm = U_imm;
            o_offset = 32'b0;
            o_shamt  = 6'b0;
        end
        else if(Btype_signal == 1'b1) begin
            o_offset = B_offset;
            rs1 = B_rs1;
            rs2 = B_rs2;
            rd  = 5'b0;
            o_shamt  = 6'b0;
            o_imm = 32'b0;
        end
        else if(Jtype_signal == 1'b1) begin
            o_offset  = J_offset;
            rs1 = 5'b0;
            rs2 = 5'b0;
            rd  = J_rd;
            o_shamt  = 6'b0;
            o_imm = 32'b0;
        end
        else if(Stype_signal == 1'b1) begin
            o_imm  = S_imm;
            rs1  = S_rs1;
            rs2  = S_rs2;
            rd   = 5'b0;
            o_shamt  = 6'b0;
            o_offset = 32'b0;
        end
        else if(Rtype_signal == 1'b1) begin
            o_imm = 32'b0;
            rs1  = R_rs1;
            rs2  = R_rs2;
            rd   = R_rd;
            o_shamt  = 6'b0;
            o_offset = 32'b0;
        end
    end

    always @(*) begin
        wdata = i_wdata;
    end

    Itype Itype_u(
        .i_inst(i_inst),
        .o_imm(I_imm),
        .o_rs1(I_rs1),
        .o_shamt(I_shamt),
        .o_rd(I_rd),
        .o_csr_addr(o_csr_addr),
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
        .o_halt_signal(I_halt_signal)
    );
    Utype Utype_u(
        .i_inst(i_inst),
        .o_rd(U_rd),
        .o_imm(U_imm),
        .o_auipc_signal(o_auipc_signal),
        .o_lui_signal(o_lui_signal),
        .o_halt_signal(U_halt_signal)
    );
    Btype Btype_u(
        .i_inst(i_inst),
        .o_rs1(B_rs1),
        .o_rs2(B_rs2),
        .o_offset(B_offset),
        .o_beq_signal(o_beq_signal),
        .o_bne_signal(o_bne_signal),
        .o_bge_signal(o_bge_signal),
        .o_bgeu_signal(o_bgeu_signal),
        .o_blt_signal(o_blt_signal),
        .o_bltu_signal(o_bltu_signal),
        .o_halt_signal(B_halt_signal)
    );
    Jtype Jtype_u(
        .i_inst(i_inst),
        .o_offset(J_offset),
        .o_rd(J_rd),
        .o_jal_signal(o_jal_signal),
        .o_halt_signal(J_halt_signal)
    );
    Stype Stype_u(
    .i_inst(i_inst),
    .o_rs1(S_rs1),
    .o_rs2(S_rs2),
    .o_imm(S_imm),
    .o_sw_signal(o_sw_signal),
    .o_sb_signal(o_sb_signal),
    .o_sh_signal(o_sh_signal),
    .o_halt_signal(S_halt_signal),
    .o_wmask(o_wmask)
    );
    Rtype Rtype_u(
    .i_inst(i_inst),
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
    // .o_mul_signal(o_mul_signal),
    // .o_mulh_signal(o_mulh_signal),
    // .o_mulhu_signal(o_mulhu_signal),
    // .o_mulhsu_signal(o_mulhsu_signal),
    // .o_div_signal(o_div_signal),
    // .o_divu_signal(o_divu_signal), 
    // .o_rem_signal(o_rem_signal),
    // .o_remu_signal(o_remu_signal),
    .o_sll_signal(o_sll_signal),
    .o_sra_signal(o_sra_signal),
    .o_srl_signal(o_srl_signal),
    .o_halt_signal(R_halt_signal)
    );
    gpr gpr_u(
    .i_sys_clk(i_sys_clk),
    .i_sys_rst_n(i_sys_rst_n), 
    .i_rs1(rs1),
    .i_rs2(rs2),
    .i_rd(rd),
    .i_data(wdata),
    .o_src1(o_src1),
    .o_src2(o_src2)//,
    //.o_reg_data(o_reg_data)
    );

    endmodule

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
    output o_halt_signal
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
    assign o_halt_signal =  unknown_intstruction | shamt_halt;
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
            end else if(i_inst == 32'b00000000000000000000000001110011) begin
                o_ecall_signal = 1'b1;
            end else if(i_inst == 32'b00110000001000000000000001110011) begin
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

module Jtype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output reg [31:0] o_offset,
    output reg o_jal_signal,
    output o_halt_signal
);

    wire [6:0] opcode;
    wire [19:0] offset;
    reg sign_extended;
    reg zero_extended;
    reg unknown_intstruction;

    assign opcode   = i_inst[6:0];
    assign o_rd     = i_inst[11:7];
    assign offset = {i_inst[31], i_inst[19:12], i_inst[20], i_inst[30:21]};
    assign o_halt_signal = unknown_intstruction;

    always @ (*) begin
        // 初始化
        o_jal_signal    = 1'b0;
        sign_extended   = 1'b0;
        zero_extended   = 1'b0;
        unknown_intstruction   = 1'b0;

        // 指令识别
        case (opcode)
            7'b 1101111: begin
                o_jal_signal  = 1'b1;
                sign_extended = 1'b1;
            end
            default: begin
                unknown_intstruction   = 1'b1;
            end
        endcase

        // offset扩展
        if(sign_extended == 1'b1)begin
            if(offset[1] == 1'b1) begin
                o_offset =  {{ {12{offset[19]}}, offset}} << 1;
            end
            else begin
                o_offset =  {{{12{offset[19]}}, offset}} << 1;
            end
        end
        else if(zero_extended == 1'b1) begin
            o_offset =  { {12{1'b0}}, offset};
        end
        else begin
            o_offset = 32'b0;
        end
    end


endmodule

module Utype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output reg [31:0] o_imm,
    output reg o_auipc_signal,
    output reg o_lui_signal,
    output o_halt_signal
);

    wire [6:0] opcode;
    wire [19:0] imm;
    reg sign_extended;
    reg zero_extended;
    reg unknown_intstruction;

    assign opcode = i_inst[6:0];
    assign o_rd   = i_inst[11:7];
    assign imm    = i_inst[31:12];
    assign o_halt_signal = unknown_intstruction;

    always @ (*) begin
        // 初始化
        o_lui_signal    = 1'b0;
        o_auipc_signal  = 1'b0;
        sign_extended   = 1'b0;
        zero_extended   = 1'b0;
        unknown_intstruction   = 1'b0;

        // 指令识别
        case (opcode)
            7'b0110111: begin
                o_lui_signal  = 1'b1;
                sign_extended = 1'b1;
            end
            7'b0010111: begin
                o_auipc_signal  = 1'b1;
                sign_extended = 1'b1;
            end
            default: begin
                unknown_intstruction = 1'b1;
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

module Stype (
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

module Rtype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output [4:0] o_rs1,
    output [4:0] o_rs2,
    output reg o_add_signal,
    output reg o_and_signal,
    output reg o_or_signal,
    output reg o_xor_signal,
    output reg o_sub_signal,
    output reg o_slt_signal,
    output reg o_sltu_signal,
    // output reg o_mul_signal,
    // output reg o_mulh_signal,
    // output reg o_mulhu_signal,
    // output reg o_mulhsu_signal,
    // output reg o_div_signal,
    // output reg o_divu_signal,
    // output reg o_rem_signal,
    // output reg o_remu_signal,
    output reg o_sll_signal,
    output reg o_sra_signal,
    output reg o_srl_signal,
    output o_halt_signal
);

    wire [2:0] fun1;
    wire [6:0] fun2;
    wire [6:0] opcode;
    reg unknown_intstruction;

    assign opcode = i_inst[6:0];
    assign o_rd   = i_inst[11:7];
    assign fun1   = i_inst[14:12];
    assign o_rs1  = i_inst[19:15];
    assign o_rs2  = i_inst[24:20];
    assign fun2   = i_inst[31:25];
    assign o_halt_signal = unknown_intstruction;

    always @ (*) begin
        // 初始化
        o_add_signal    = 1'b0;
        o_and_signal    = 1'b0;
        o_or_signal     = 1'b0;
        o_xor_signal    = 1'b0;
        o_sub_signal    = 1'b0;
        o_slt_signal    = 1'b0;
        o_sltu_signal   = 1'b0;
        // o_mul_signal    = 1'b0;
        // o_mulh_signal   = 1'b0;
        // o_mulhu_signal  = 1'b0;
        // o_mulhsu_signal = 1'b0;
        // o_div_signal    = 1'b0;
        // o_divu_signal   = 1'b0;
        // o_rem_signal    = 1'b0;
        // o_remu_signal   = 1'b0;
        o_sll_signal    = 1'b0;
        o_sra_signal    = 1'b0;
        o_srl_signal    = 1'b0;
        unknown_intstruction = 1'b0;

        // 指令识别
        case (opcode)
            7'b0110011: begin
                if (fun2 == 7'b0000000) begin
                    o_add_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                    o_and_signal  = (fun1 == 3'b111) ? 1'b1 : 1'b0;
                    o_or_signal   = (fun1 == 3'b110) ? 1'b1 : 1'b0;
                    o_xor_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
                    o_slt_signal  = (fun1 == 3'b010) ? 1'b1 : 1'b0;
                    o_sltu_signal = (fun1 == 3'b011) ? 1'b1 : 1'b0;
                    o_sll_signal  = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                    o_srl_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                end
                else if (fun2 == 7'b0100000) begin
                    o_sub_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                    o_sra_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                end
                else if (fun2 == 7'b0000001) begin
                    // o_mul_signal   = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                    // o_mulh_signal  = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                    // o_mulhu_signal = (fun1 == 3'b010) ? 1'b1 : 1'b0;
                    // o_mulhsu_signal= (fun1 == 3'b011) ? 1'b1 : 1'b0;
                    // o_div_signal   = (fun1 == 3'b100) ? 1'b1 : 1'b0;
                    // o_divu_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                    // o_rem_signal   = (fun1 == 3'b110) ? 1'b1 : 1'b0;
                    // o_remu_signal  = (fun1 == 3'b111) ? 1'b1 : 1'b0;
                end
                else begin
                    unknown_intstruction = 1'b1;
                end
            end
            //待扩展
            default: begin
                unknown_intstruction = 1'b1;
            end
        endcase
    end


endmodule

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
                // end else if(fun1 == 3'b111) begin
                //     zero_extended = 1'b1;
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

module gpr  (
    input i_sys_clk,
    input i_sys_rst_n,   
    input  [4:0] i_rs1,
    input  [4:0] i_rs2,
    input  [4:0] i_rd,
    input  [31:0] i_data,
    output [31:0] o_src1,
    output [31:0] o_src2//,
    //output [31:0] o_reg_data [0:31]
    );
    
    /* verilator lint_off UNUSEDSIGNAL */
    wire [31:0] wen;
    /* verilator lint_on UNUSEDSIGNAL */
    wire [31:0] reg_file [0:31]; // 32 个寄存器

    //assign o_reg_data = reg_file;
    assign wen = (i_rd != 5'b0)? (32'b1 << i_rd) : 32'b0; // 写使能信号

    // 生成 32 个寄存器
    Reg #(32, 32'b0) zero (i_sys_clk, i_sys_rst_n, i_data, reg_file[0],  wen[0]);
    Reg #(32, 32'b0) ra   (i_sys_clk, i_sys_rst_n, i_data, reg_file[1],  wen[1]);
    Reg #(32, 32'b0) sp   (i_sys_clk, i_sys_rst_n, i_data, reg_file[2],  wen[2]);
    Reg #(32, 32'b0) gp   (i_sys_clk, i_sys_rst_n, i_data, reg_file[3],  wen[3]);
    Reg #(32, 32'b0) tp   (i_sys_clk, i_sys_rst_n, i_data, reg_file[4],  wen[4]);
    Reg #(32, 32'b0) t0   (i_sys_clk, i_sys_rst_n, i_data, reg_file[5],  wen[5]);
    Reg #(32, 32'b0) t1   (i_sys_clk, i_sys_rst_n, i_data, reg_file[6],  wen[6]);
    Reg #(32, 32'b0) t2   (i_sys_clk, i_sys_rst_n, i_data, reg_file[7],  wen[7]);
    Reg #(32, 32'b0) s0   (i_sys_clk, i_sys_rst_n, i_data, reg_file[8],  wen[8]);
    Reg #(32, 32'b0) s1   (i_sys_clk, i_sys_rst_n, i_data, reg_file[9],  wen[9]);
    Reg #(32, 32'b0) a0   (i_sys_clk, i_sys_rst_n, i_data, reg_file[10], wen[10]);
    Reg #(32, 32'b0) a1   (i_sys_clk, i_sys_rst_n, i_data, reg_file[11], wen[11]);
    Reg #(32, 32'b0) a2   (i_sys_clk, i_sys_rst_n, i_data, reg_file[12], wen[12]);
    Reg #(32, 32'b0) a3   (i_sys_clk, i_sys_rst_n, i_data, reg_file[13], wen[13]);
    Reg #(32, 32'b0) a4   (i_sys_clk, i_sys_rst_n, i_data, reg_file[14], wen[14]);
    Reg #(32, 32'b0) a5   (i_sys_clk, i_sys_rst_n, i_data, reg_file[15], wen[15]);
    Reg #(32, 32'b0) a6   (i_sys_clk, i_sys_rst_n, i_data, reg_file[16], wen[16]);
    Reg #(32, 32'b0) a7   (i_sys_clk, i_sys_rst_n, i_data, reg_file[17], wen[17]);
    Reg #(32, 32'b0) s2   (i_sys_clk, i_sys_rst_n, i_data, reg_file[18], wen[18]);
    Reg #(32, 32'b0) s3   (i_sys_clk, i_sys_rst_n, i_data, reg_file[19], wen[19]);
    Reg #(32, 32'b0) s4   (i_sys_clk, i_sys_rst_n, i_data, reg_file[20], wen[20]);
    Reg #(32, 32'b0) s5   (i_sys_clk, i_sys_rst_n, i_data, reg_file[21], wen[21]);
    Reg #(32, 32'b0) s6   (i_sys_clk, i_sys_rst_n, i_data, reg_file[22], wen[22]);
    Reg #(32, 32'b0) s7   (i_sys_clk, i_sys_rst_n, i_data, reg_file[23], wen[23]);
    Reg #(32, 32'b0) s8   (i_sys_clk, i_sys_rst_n, i_data, reg_file[24], wen[24]);
    Reg #(32, 32'b0) s9   (i_sys_clk, i_sys_rst_n, i_data, reg_file[25], wen[25]);
    Reg #(32, 32'b0) s10  (i_sys_clk, i_sys_rst_n, i_data, reg_file[26], wen[26]);
    Reg #(32, 32'b0) s11  (i_sys_clk, i_sys_rst_n, i_data, reg_file[27], wen[27]);
    Reg #(32, 32'b0) t4   (i_sys_clk, i_sys_rst_n, i_data, reg_file[29], wen[29]);
    Reg #(32, 32'b0) t5   (i_sys_clk, i_sys_rst_n, i_data, reg_file[30], wen[30]);
    Reg #(32, 32'b0) t6   (i_sys_clk, i_sys_rst_n, i_data, reg_file[31], wen[31]);

// 读取寄存器
    assign o_src1 = (i_rs1 == 5'b0)? 32'b0 : reg_file[i_rs1];
    assign o_src2 = (i_rs2 == 5'b0)? 32'b0 : reg_file[i_rs2];

endmodule

module IFU(
    input [31:0] i_pc,
    output [31:0] o_instruction
);
// import "DPI-C" function int pmem_read(input int raddr, input int len);

// assign o_instruction = $unsigned(pmem_read(i_pc, 4)); 

// 用来测试npc
rom rom_u(
    .addr(i_pc),
    .rdata(o_instruction)
);

endmodule

// Modified by Long for NPC project.
module PC #(parameter PC_LEN = 32)(
    input i_sys_clk,
    input i_sys_rst_n,
    input [PC_LEN-1:0] i_next_pc,
    output reg [PC_LEN-1:0] o_pc = 32'h80000000
    );
    
    always @(posedge i_sys_clk) begin
        if (!i_sys_rst_n)begin
            o_pc <= 32'h80000000;
        end 
        else begin
            o_pc <= i_next_pc;
        end
    end



endmodule


/* verilator lint_off DECLFILENAME */
module rom (
    /* verilator lint_off UNUSEDSIGNAL */
    input [31:0] addr,
    /* verilator lint_on UNUSEDSIGNAL */
    output reg [31:0] rdata
);
    wire [31:0] rom_out [255:0];
    wire [7:0] rom_offset;

    assign rom_offset = addr[7:0];

    genvar i;
    generate
        for (i = 0; i < 256; i = i + 1) begin : rom_mem
        Reg #(
        .WIDTH(32),        // 设置寄存器宽度为32位
        .RESET_VAL(0)      // 复位值为0（可自定义）
        ) u_reg (
        .clk(1),
        .sys_rst_n(1),
        .i_data(0),   // 所有寄存器共享数据输入
        .o_data(rom_out[i]),// 独立输出到总线数组
        .wen(1'b0)   // 独立的地址译码写使能
        );
    end
    endgenerate

    always @(*) begin
        rdata = rom_out[rom_offset];
    end

    





endmodule
 /* verilator lint_on DECLFILENAME */

/* 触发器模板 */
module Reg #(parameter WIDTH = 1, parameter RESET_VAL = 0) (
  input clk,
  input sys_rst_n,
  input [WIDTH-1:0] i_data,
  output reg [WIDTH-1:0] o_data,
  input wen
);
  always @(posedge clk) begin
    if (!sys_rst_n) o_data <= RESET_VAL;
    else if (wen) o_data <= i_data;
  end
endmodule


module LSU(
    input i_sys_clk,
    //input i_sys_rst_n,
    input i_lbu_signal,
    input i_lhu_signal,
    input i_lb_signal,
    input i_lh_signal,
    input i_lw_signal,
    input i_sb_signal,
    input i_sh_signal,
    input i_sw_signal,
    input [31:0] i_src2,
    input [31:0] i_data,
    /* verilator lint_off UNUSEDSIGNAL */
    input [3:0] i_wmask,//表示写哪些位
    /* verilator lint_on UNUSEDSIGNAL */
    output            o_load_signal,
    output reg [31:0] o_rdata
);

// import "DPI-C" function int pmem_read(input int addr, input int len);
// import "DPI-C" function void pmem_write(
//     input int addr, int len, input int data);

reg [31:0] rdata;
//wire valid = i_sys_clk;
wire wen = i_sb_signal | i_sh_signal | i_sw_signal;
wire ren = i_lbu_signal | i_lhu_signal | i_lb_signal | i_lh_signal | i_lw_signal;
assign o_load_signal = ren;

always @(negedge i_sys_clk) begin
        //适配对齐访存
        if(i_lw_signal == 1'b1) begin
            // rdata <= pmem_read(i_data, 4);
            rdata <= ram_rdata;
        end else if(i_lhu_signal == 1'b1) begin
            // rdata <= pmem_read(i_data, 2);
            rdata <= ram_rdata;
        end else if(i_lh_signal == 1'b1) begin
            // rdata <= pmem_read(i_data, 2);
            rdata <= ram_rdata;
        end else if(i_lbu_signal == 1'b1) begin
            // rdata <= pmem_read(i_data, 1);
            rdata <= ram_rdata;
        end else if(i_lb_signal == 1'b1) begin
            // rdata <= pmem_read(i_data, 1);
            rdata <= ram_rdata;
        end
        else if (wen) begin // 有写请求时
            // pmem_write(i_data, {28'b0, i_wmask} , i_src2);
            // pmem_write(i_data, {28'b0, i_wmask} , i_src2);
            rdata <= 0;
        end
        else begin
            rdata <= 0;
        end
end

always @(*) begin
    if(i_lw_signal == 1'b1) begin
        o_rdata = rdata[31:0];
    end else if(i_lhu_signal == 1'b1) begin
        o_rdata = {16'b0, rdata[15:0]};
    end else if(i_lh_signal == 1'b1) begin
        o_rdata = {{16{rdata[15]}}, rdata[15:0]};
    end else if(i_lbu_signal == 1'b1) begin
        o_rdata = {24'b0, rdata[7:0]};
    end else if(i_lb_signal == 1'b1) begin
        o_rdata = {{24{rdata[7]}}, rdata[7:0]};
    end else begin
        o_rdata = 0;
    end
end

// 实例化测试用
wire [31:0] ram_rdata;
ram ram_u (
    .addr(i_data),
    .wdata(i_src2),
    .rdata(ram_rdata)
);
endmodule

/* verilator lint_off DECLFILENAME */
module ram (
    /* verilator lint_off UNUSEDSIGNAL */
    input [31:0] addr,
    input [31:0] wdata,
    /* verilator lint_on UNUSEDSIGNAL */
    output reg [31:0] rdata
);
    wire [31:0] ram_out [255:0];
    wire [7:0] ram_offset;

    assign ram_offset = addr[7:0];

    genvar i;
    generate
        for (i = 0; i < 256; i = i + 1) begin : ram_mem
        Reg #(
        .WIDTH(32),        // 设置寄存器宽度为32位
        .RESET_VAL(0)      // 复位值为0（可自定义）
        ) u_reg (
        .clk(1),
        .sys_rst_n(1),
        .i_data(wdata),   // 所有寄存器共享数据输入
        .o_data(ram_out[i]),// 独立输出到总线数组
        .wen(1'b1)   // 独立的地址译码写使能
        );
    end
    endgenerate

    always @(*) begin
        rdata = ram_out[ram_offset];
    end

    





endmodule
 /* verilator lint_on DECLFILENAME */

module WBU(
    input i_sys_rst_n,
    input [31:0] i_exu_data,
    input [31:0] i_cur_pc,
    input i_B_jump_signal,
    input i_jal_signal,
    input i_jalr_signal,
    input i_load_signal,
    input i_csrrs_signal,
    input i_csrrw_signal,
    input i_mret_signal,
    input i_ecall_signal,
    input  [31:0] i_load_wdata,
    input  [31:0] i_csr_rdata,
    input  [31:0] i_mstatus_rdata,
    input  [31:0] i_mtvec_rdata,
    input  [31:0] i_mepc_rdata,
    input  [31:0] i_mcause_rdata,
    output [31:0] o_csr_wdata,
    output [31:0] o_reg_wdata,
    output reg [31:0] o_mstatus_wdata,
    output reg [31:0] o_mtvec_wdata,
    output reg [31:0] o_mepc_wdata,
    output reg [31:0] o_mcause_wdata,
    output reg [31:0] o_next_pc = 32'h8000_0004
);

    reg [31:0] reg_wdata;
    reg [31:0] csr_wdata;

    wire jump_signal = i_jalr_signal | i_B_jump_signal | i_jal_signal;
    // assign o_reg_wdata = i_load_signal == 1'b1 ? i_load_wdata : i_exu_data;
    assign o_reg_wdata = reg_wdata;
    assign o_csr_wdata = csr_wdata;
    always @(*) begin
        if (!i_sys_rst_n) begin
            o_next_pc = 32'h8000_0004;
        end else if (jump_signal == 1'b1)begin
            o_next_pc = i_exu_data;
        end else if (i_mret_signal == 1'b1)begin
            o_next_pc = i_mepc_rdata;
        end else if (i_ecall_signal == 1'b1)begin
            o_next_pc = i_mtvec_rdata;
        end else begin
            o_next_pc = i_cur_pc + 4;
        end
    end

    always @(*) begin
        if (i_load_signal == 1'b1) begin
            reg_wdata = i_load_wdata;
            csr_wdata = 32'h0;
            o_mepc_wdata = 32'h0;
            o_mcause_wdata = i_mcause_rdata;
            o_mstatus_wdata = 32'h0;
            o_mtvec_wdata = 32'h0;
        end else if (i_jal_signal == 1'b1 || i_jalr_signal == 1'b1)begin
            reg_wdata = i_cur_pc + 4;
            csr_wdata = 32'h0;
            o_mepc_wdata = 32'h0;
            o_mcause_wdata = i_mcause_rdata;
            o_mstatus_wdata = 32'h0;
            o_mtvec_wdata = 32'h0;
        end else if (i_csrrs_signal == 1'b1 || i_csrrw_signal == 1'b1) begin
            csr_wdata = i_exu_data;
            reg_wdata = i_csr_rdata;
            o_mepc_wdata = 32'h0;
            o_mcause_wdata = i_mcause_rdata;
            o_mstatus_wdata = 32'h0;
            o_mtvec_wdata = 32'h0;
        end else if (i_ecall_signal == 1'b1) begin
            reg_wdata = 32'h0;
            csr_wdata = 32'h0;
            o_mepc_wdata = i_cur_pc + 4;// 是否需要+4待验证
            o_mcause_wdata = 32'd11; // 没有实现特权级转换
            o_mstatus_wdata = i_mstatus_rdata;
            o_mtvec_wdata = i_mtvec_rdata;
        end
        else begin
            reg_wdata = i_exu_data;
            csr_wdata = 32'h0;
            o_mepc_wdata = 32'h0;
            o_mcause_wdata = i_mcause_rdata;
            o_mstatus_wdata = 32'h0;
            o_mtvec_wdata = 32'h0;
        end
    end



endmodule



