module mem(
    input clock,
    input [31:0] addr,
    input wen,
    input ren,
    input [31:0] wdata,
    input [3:0] wmask,
    output reg [31:0] rdata
);

import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, int len, input int data);

always @(posedge clock) begin
    if (ren) begin
    rdata <= pmem_read(addr, 4);
    end
    else if (wen) begin
        /* verilator lint_off WIDTHEXPAND */
        pmem_write(addr, wmask, wdata);
        /* verilator lint_on WIDTHEXPAND */
    end
end

endmodule
