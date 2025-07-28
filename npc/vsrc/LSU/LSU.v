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
    input [3:0] i_wmask,//表示写哪些位
    output            o_load_signal,
    output reg [31:0] o_rdata
);

import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, int len, input int data);

reg [31:0] rdata;
//wire valid = i_sys_clk;
wire wen = i_sb_signal | i_sh_signal | i_sw_signal;
wire ren = i_lbu_signal | i_lhu_signal | i_lb_signal | i_lh_signal | i_lw_signal;
assign o_load_signal = ren;

always @(negedge i_sys_clk) begin
    //if (valid) begin // 有读写请求时
        if (ren) begin
            // rdata <= pmem_read(i_data, 4);
            //适配对齐访存
            if(i_lw_signal == 1'b1) begin
                rdata <= pmem_read(i_data, 4);
            end else if(i_lhu_signal == 1'b1) begin
                rdata <= pmem_read(i_data, 2);
            end else if(i_lh_signal == 1'b1) begin
                rdata <= pmem_read(i_data, 2);
            end else if(i_lbu_signal == 1'b1) begin
                rdata <= pmem_read(i_data, 1);
            end else if(i_lb_signal == 1'b1) begin
                rdata <= pmem_read(i_data, 1);
            end else begin
                rdata <= 0;
            end
        end
        else if (wen) begin // 有写请求时
            pmem_write(i_data, {28'b0, i_wmask} , i_src2);
            rdata <= 0;
        end
        else begin
            rdata <= 0;
        end
    // end else begin
    //     rdata = 0;
    // end
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
endmodule
