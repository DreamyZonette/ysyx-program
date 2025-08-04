module WBU(
    input wire i_sys_rst_n,
    input wire i_sys_clk,
    input wire [31:0] i_exu_data,
    input wire [31:0] i_cur_pc,
    input wire i_B_jump_signal,
    input wire i_jal_signal,
    input wire i_jalr_signal,
    input wire i_load_signal,
    input wire i_csrrs_signal,
    input wire i_csrrw_signal,
    input wire i_mret_signal,
    input wire i_ecall_signal,
    input wire i_exu_valid, // NEW
    input wire i_lsu_valid, // NEW
    input wire i_csr_valid, // NEW
    input wire i_pc_ready, // NEW
    input wire i_idu_valid, // NEW
    input wire [31:0] i_load_wdata,
    input wire [31:0] i_csr_rdata,
    /* verilator lint_off UNUSEDSIGNAL */
    input wire [31:0] i_mstatus_rdata,
    input wire [31:0] i_mcause_rdata,
    /* verilator lint_on UNUSEDSIGNAL */
    input wire [31:0] i_mtvec_rdata,
    input wire [31:0] i_mepc_rdata,
    output wire [31:0] o_csr_wdata,
    output wire [31:0] o_reg_wdata,
    output wire [31:0] o_mstatus_wdata,
    output wire [31:0] o_mtvec_wdata,
    output wire [31:0] o_mepc_wdata,
    output wire [31:0] o_mcause_wdata,
    output wire [31:0] o_next_pc,
    output wire o_wbu_ready, // NEW
    output wire o_wbu_valid // NEW
);

    localparam IDLE        = 3'b000;
    localparam LOAD_WAIT   = 3'b001;
    localparam CSR_WAIT    = 3'b010;
    localparam MRET_WAIT   = 3'b011;
    localparam ECALL_WAIT  = 3'b100;
    localparam JUMP_WAIT   = 3'b110;
    localparam WBU_DONE    = 3'b101;

    reg [2:0] state;
    reg [2:0] next_state;
    reg [31:0] reg_wdata;
    reg [31:0] csr_wdata;
    reg [31:0] next_pc;
    reg [31:0] mstatus_wdata;
    reg [31:0] mtvec_wdata;
    reg [31:0] mepc_wdata;
    reg [31:0] mcause_wdata;
    reg jump_signal_reg;

    // 控制信号

    assign o_reg_wdata = reg_wdata;
    assign o_csr_wdata = csr_wdata;
    assign o_next_pc = next_pc;
    assign o_wbu_ready = (state == IDLE);
    assign o_wbu_valid = (state == WBU_DONE) || 
                     (state == MRET_WAIT && i_pc_ready) ||
                     (state == ECALL_WAIT && i_pc_ready) ||
                     (state == JUMP_WAIT && i_pc_ready);
    assign o_mstatus_wdata = mstatus_wdata;
    assign o_mtvec_wdata = mtvec_wdata;
    assign o_mepc_wdata = mepc_wdata;
    assign o_mcause_wdata = mcause_wdata;

    // 信号锁存
    always @(posedge i_sys_clk) begin
        if (!i_sys_rst_n) begin
            jump_signal_reg <= 1'b0;
        end
        else if (i_idu_valid) begin
            jump_signal_reg <= i_jalr_signal | i_B_jump_signal | i_jal_signal;
        end
    end

    // 状态更新逻辑
    always @(*) begin
        if(!i_sys_rst_n) begin
            next_state = IDLE;
        end else begin
            case(state)
                IDLE: begin
                    if (i_exu_valid) begin
                        if (i_load_signal == 1'b1) begin
                            next_state = LOAD_WAIT;
                        end else if (i_csrrs_signal == 1'b1 || i_csrrw_signal == 1'b1) begin
                            next_state = CSR_WAIT;
                        end else if (jump_signal_reg == 1'b1) begin
                            next_state = JUMP_WAIT;
                        end else if (i_mret_signal == 1'b1) begin
                            next_state = MRET_WAIT;
                        end else if (i_ecall_signal == 1'b1) begin
                            next_state = ECALL_WAIT;
                        end else begin
                            next_state = WBU_DONE;
                        end
                    end
                    else begin
                        next_state = IDLE;
                    end
                end
                LOAD_WAIT: begin
                    if (i_lsu_valid) begin
                        next_state = WBU_DONE;
                    end else begin
                        next_state = LOAD_WAIT;
                    end
                end
                CSR_WAIT: begin
                    if (i_csr_valid) begin
                        next_state = WBU_DONE;
                    end else begin
                        next_state = CSR_WAIT;
                    end
                end
                MRET_WAIT: begin
                    if (i_pc_ready) begin
                        next_state = IDLE;
                    end else begin
                        next_state = MRET_WAIT;
                    end
                end
                ECALL_WAIT: begin
                    if (i_pc_ready) begin
                        next_state = IDLE;
                    end else begin
                        next_state = ECALL_WAIT;
                    end
                end
                JUMP_WAIT: begin
                    if (i_pc_ready) begin
                        next_state = IDLE;
                        end else begin
                        next_state = JUMP_WAIT;
                    end
                end
                WBU_DONE: begin
                    if (i_pc_ready) begin
                        next_state = IDLE;
                    end else begin
                        next_state = WBU_DONE;
                    end
                end
                default: begin
                    next_state = IDLE;
                end
            endcase
        end
    end

    // 状态输出逻辑
    always @(posedge i_sys_clk) begin
        if(!i_sys_rst_n) begin
            reg_wdata <= 32'b0;
            csr_wdata <= 32'b0;
            next_pc <= 32'h8000_0000;
            mstatus_wdata <= 32'h1800;
            mtvec_wdata <= 32'b0;
            mepc_wdata <= 32'b0;
            mcause_wdata <= 32'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (i_exu_valid) begin
                        next_pc <= i_cur_pc + 4;
                        if (jump_signal_reg == 1'b1) begin
                            next_pc <= i_exu_data;
                            if (i_jal_signal || i_jalr_signal) begin
                                reg_wdata <= i_cur_pc + 4; // 保存返回地址
                            end
                        end
                        else if (i_ecall_signal == 1'b1) begin
                            next_pc <= i_mtvec_rdata;
                            mepc_wdata <= i_cur_pc + 4;
                            mcause_wdata <= 32'd11; // 没有实现特权级转换
                        end
                        else if (i_mret_signal) begin
                            next_pc <= i_mepc_rdata; // 返回用户程序
                        end
                        else if (i_csrrs_signal || i_csrrw_signal) begin
                            csr_wdata <= i_exu_data;
                        end
                        else if (!i_load_signal) begin
                            reg_wdata <= i_exu_data;
                        end
                    end
                end
                LOAD_WAIT: begin
                    if (i_lsu_valid) begin
                        reg_wdata <= i_load_wdata;
                    end
                end
                CSR_WAIT: begin
                    if (i_csr_valid) begin
                        reg_wdata <= i_csr_rdata;
                    end
                end
                MRET_WAIT: begin /*无需操作*/ end
                ECALL_WAIT: begin /*无需操作*/ end
                JUMP_WAIT: begin /*无需操作*/ end
                WBU_DONE: begin /*无需操作*/ end
                default: begin end
            endcase
        end
    end

    // 状态转移
    always @(posedge i_sys_clk) begin
        if(i_sys_rst_n == 1'b0) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

endmodule
