module LSU(
    input i_sys_clk,
    input i_sys_rst_n,
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
    input [3:0] i_wmask,//表示写哪些位
    output reg [31:0] o_rdata
);

import "DPI-C" function int pmem_read(input int raddr);
import "DPI-C" function void pmem_write(
    input int i_waddr, input int i_waddr, input byte wmask);

reg [31:0] rdata;
wire valid = i_sys_clk & i_sys_rst_n;
wire wen = i_sb_signal | i_sh_signal | i_sw_signal;
wire ren = i_lbu_signal | i_lhu_signal | i_lb_signal | i_lh_signal | i_lw_signal;

always @(*) begin
    if (valid) begin // 有读写请求时
        if (ren) begin
            rdata = pmem_read(i_data);
        end
        else if (wen) begin // 有写请求时
            pmem_write(i_data, i_src2, i_wmask);
        end
        else begin
            rdata = 0;
        end
    end
end

always @(*) begin
    if(i_sw_signal == 1'b1) begin
        o_rdata = rdata[31:0];
    end else if(i_sh_signal) begin
        o_rdata = rdata[15:0];
    end else if(i_sb_signal) begin
        o_rdata = rdata[7:0];
    end else begin
        o_rdata = 0;
    end
end
endmodule
