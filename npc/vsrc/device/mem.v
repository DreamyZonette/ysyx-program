module mem(
    input clock,
    input [31:0] addr,
    input wen,
    // input ren,
    input [31:0] wdata,
    input reqValid,
    input [3:0] wmask,
    output reg [31:0] rdata,
    output reg respValid
);

import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, int len, input int data);

// always @(posedge clock) begin
//     if (reqValid && !wen) begin
//     rdata <= pmem_read(addr, 4);
//     respValid <= 1'b1;
//     end   
//     else if (reqValid && wen) begin
//         /* verilator lint_off WIDTHEXPAND */
//         pmem_write(addr, wmask, wdata);
//         /* verilator lint_on WIDTHEXPAND */
//         respValid <= 1'b1;
//     end
//     if (respValid) begin
//         respValid <= 1'b0;
//     end

// end

//************************延时版本***********************//
reg [31:0] delay_counter;
reg [31:0] delay_target;

always @(posedge clock) begin
    if (reqValid && !wen) begin
        if (delay_counter == delay_target) begin
            rdata <= pmem_read(addr, 4);
            respValid <= 1'b1;
            delay_counter <= 0;
        end
        else begin
            delay_counter <= delay_counter + 1;
        end
    end   
    else if (reqValid && wen) begin
        if (delay_counter == delay_target) begin
            /* verilator lint_off WIDTHEXPAND */
            pmem_write(addr, wmask, wdata);
            /* verilator lint_on WIDTHEXPAND */
            respValid <= 1'b1;
        end
        else begin
            delay_counter <= delay_counter + 1;
        end
    end
    if (respValid) begin
        respValid <= 1'b0;
    end

end

reg [31:0] lfsr;
always @(posedge clock) begin
    if (!resetn) begin
        lfsr <= 32'hABCDE123; // 任意非零种子值
    end else if (reqValid) begin
        // 在收到新请求时，用LFSR生成一个新的随机延迟目标
        lfsr <= {lfsr[30:0], lfsr[31] ^ lfsr[30] ^ lfsr[28] ^ lfsr[25]}; // 一个32位的多项式反馈
        delay_target <= lfsr % 100; // 取模以限制最大延迟范围，例如0-99个周期
    end
end


endmodule
