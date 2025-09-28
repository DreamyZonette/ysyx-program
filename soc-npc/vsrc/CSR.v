`include "include/defs.vh"

module CSR(
    input clk,
    input rst,
    input [11:0] csr_addr,
    output reg [31:0] csr_rdata
);
    parameter CSR_MCYCLE = 12'hB00;
    parameter CSR_MCYCLEH = 12'hB80;
    parameter CSR_MVENDORID = 12'hF11;
    parameter CSR_MARCHID = 12'hF12;

    reg [63:0] mcycle_reg;

    always @(posedge clk) begin
        if (rst) begin
            mcycle_reg <= 64'b0;
        end else begin
            mcycle_reg <= mcycle_reg + 64'd1;
        end
    end

    always @(*) begin
        case (csr_addr)
            CSR_MCYCLE: begin
                csr_rdata = mcycle_reg[31:0];
            end
            CSR_MCYCLEH: begin
                csr_rdata = mcycle_reg[63:32];
            end
            CSR_MVENDORID: begin
                csr_rdata = 32'h79737978; // "ysyx"
            end
            CSR_MARCHID: begin
                csr_rdata = 32'h0017DC687;
            end
            default: begin
                csr_rdata = 32'b0;
            end
        endcase
    end

endmodule