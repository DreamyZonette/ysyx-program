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
