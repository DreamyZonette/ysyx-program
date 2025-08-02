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
        wen = 4'b0011;
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
Reg #(32, 32'hb)    mcause  (i_sys_clk, i_sys_rst_n, mcause_wdata , o_mcause  ,  wen[3]);

endmodule
