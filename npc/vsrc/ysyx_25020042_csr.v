module ysyx_25020042_csr (
    input clock,
    input reset,
    input i_ecall_signal,
    input [31:0] i_csr_wdata,
    input [11:0] i_csr_addr,
    input [31:0] i_mstatus_wdata,
    input [31:0] i_mtvec_wdata,
    input [31:0] i_mepc_wdata,
    input [31:0] i_mcause_wdata,
    input wbu_valid,
    output [31:0] o_mstatus,
    output [31:0] o_mtvec,
    output [31:0] o_mepc,
    output [31:0] o_mcause,
    output reg [31:0] o_csr_rdata
);

reg [5:0] wen;
wire [31:0] mstatus_wdata;
wire [31:0] mtvec_wdata;
wire [31:0] mepc_wdata;
wire [31:0] mcause_wdata;
wire [31:0] mcycle_val;
wire [31:0] mcycleh_val;
wire [31:0] mcycle_wdata;
wire [31:0] mcycleh_wdata;


assign mstatus_wdata = (i_ecall_signal == 1'b1) ? i_mstatus_wdata : i_csr_wdata;
assign mtvec_wdata   = (i_ecall_signal == 1'b1) ? i_mtvec_wdata   : i_csr_wdata;
assign mepc_wdata    = (i_ecall_signal == 1'b1) ? i_mepc_wdata    : i_csr_wdata;
assign mcause_wdata  = (i_ecall_signal == 1'b1) ? i_mcause_wdata  : i_csr_wdata;
assign mcycle_wdata  = (wen[4] == 1'b1) ? i_csr_wdata    : mcycle_val + 1;
assign mcycleh_wdata = (wen[5] == 1'b1) ? i_csr_wdata    : mcycle_val == 32'hffffffff ? mcycleh_val + 1 : mcycleh_val;


always @(*) begin
    wen = 6'b0;
    o_csr_rdata = 32'b0;
    if (wbu_valid) begin
        if(i_ecall_signal == 1'b1 ) begin
            wen = 6'b001100;
        end else if(i_csr_addr == 12'h300) begin
            wen[0] = 1'b1;
        end else if(i_csr_addr == 12'h305) begin
            wen[1] = 1'b1;
        end else if(i_csr_addr == 12'h341) begin
            wen[2] = 1'b1;
        end else if(i_csr_addr == 12'h342) begin
            wen[3] = 1'b1;
        end else if(i_csr_addr == 12'hB00) begin
            wen[4] = 1'b1;
        end else if(i_csr_addr == 12'hB80) begin
            wen[5] = 1'b1;
        end else begin
            wen = 6'b0;
        end
    end else begin  wen = 6'b0; end

    if(i_csr_addr == 12'h300) begin
        o_csr_rdata = o_mstatus;
    end else if(i_csr_addr == 12'h305) begin
        o_csr_rdata = o_mtvec;
    end else if(i_csr_addr == 12'h341) begin
        o_csr_rdata = o_mepc;
    end else if(i_csr_addr == 12'h342) begin
        o_csr_rdata = o_mcause;
    end else if(i_csr_addr == 12'hB00) begin
        o_csr_rdata = mcycle_val;
    end else if(i_csr_addr == 12'hB80) begin
        o_csr_rdata = mcycleh_val;
    end else begin
        o_csr_rdata = 32'b0;
    end
    
end

ysyx_25020042_Reg #(32, 32'h1800) mstatus (clock, reset, mstatus_wdata , o_mstatus     ,  wen[0]);
ysyx_25020042_Reg #(32, 32'b0)    mtvec   (clock, reset, mtvec_wdata   , o_mtvec       ,  wen[1]);
ysyx_25020042_Reg #(32, 32'b0)    mepc    (clock, reset, mepc_wdata    , o_mepc        ,  wen[2]);
ysyx_25020042_Reg #(32, 32'b0)    mcause  (clock, reset, mcause_wdata  , o_mcause      ,  wen[3]);
ysyx_25020042_Reg #(32, 32'b0)    mcycle  (clock, reset, mcycle_wdata  , mcycle_val    ,  1'b1  ); //0xB00
ysyx_25020042_Reg #(32, 32'b0)    mcycleh (clock, reset, mcycleh_wdata , mcycleh_val   ,  1'b1  ); //0xB80

endmodule
