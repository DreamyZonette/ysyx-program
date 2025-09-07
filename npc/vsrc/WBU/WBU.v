module WBU(
    input clock,
    input reset_n,
    input [31:0] i_exu_data,
    input [31:0] i_cur_pc,
    input i_B_jump_signal,
    input i_jal_signal,
    input i_jalr_signal,
    input i_lsu_busy,
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
    input  ifu_valid,
    input  lsu_valid,
    output reg wbu_ready,
    output reg wbu_valid,
    output reg [31:0] csr_wdata,
    output reg [31:0] reg_wdata,
    output reg [31:0] o_mstatus_wdata,
    output reg [31:0] o_mtvec_wdata,
    output reg [31:0] o_mepc_wdata,
    output reg [31:0] o_mcause_wdata,
    output reg [31:0] next_pc
);

    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam LSU_WAIT = 2'b10;
    reg [1:0] state;

    assign o_reg_wdata = reg_wdata;
    assign o_csr_wdata = csr_wdata;

always @(posedge clock) begin
    if(!reset_n) begin
        state <= IDLE;
        next_pc <= 32'h8000_0004;
        reg_wdata <= 32'b0;
        csr_wdata <= 32'b0;
        wbu_ready <= 1'b0;
        wbu_valid <= 1'b0;
    end
    else begin
        case(state)
            IDLE: begin
                if (ifu_valid) begin
                    if (i_lsu_busy) begin
                        state <= LSU_WAIT;
                    end else begin
                        state <= WAIT;
                        wbu_ready <= 1'b1;
                    end
                end
                else begin
                    state <= IDLE;
                    if (wbu_ready) begin
                        wbu_ready <= 1'b0;
                    end
                    if (wbu_valid) begin
                        wbu_valid <= 1'b0;
                    end
                end
            end

            WAIT: begin
                if (wbu_ready) begin
                    wbu_ready <= 1'b0;
                end
                if (i_jal_signal == 1'b1 || i_jalr_signal == 1'b1)begin
                    next_pc <= i_exu_data;
                    reg_wdata <= i_cur_pc + 4;
                end else if (i_B_jump_signal == 1'b1) begin
                    next_pc <= i_exu_data;
                end else if (i_mret_signal == 1'b1)begin
                    next_pc <= i_mepc_rdata;
                end else if (i_ecall_signal == 1'b1)begin
                    next_pc <= i_mtvec_rdata;
                    o_mepc_wdata = i_cur_pc;
                    o_mcause_wdata = 32'd11; // 没有实现特权级转换
                
                end else if (i_csrrs_signal == 1'b1 || i_csrrw_signal == 1'b1) begin
                    csr_wdata <= i_exu_data;
                    reg_wdata <= i_csr_rdata;
                    next_pc <= i_cur_pc + 4;
                end
                else begin
                    next_pc <= i_cur_pc + 4;
                    reg_wdata = i_exu_data;
                end

                state <= IDLE;
                wbu_valid <= 1'b1;
            end

            LSU_WAIT: begin
                if (lsu_valid) begin
                    wbu_ready <= 1'b1;
                    reg_wdata <= i_load_wdata;
                    state <= IDLE;
                    next_pc <= i_cur_pc + 4;
                    wbu_valid <= 1'b1;
                end
            end
        endcase
    end
end



endmodule
