module LSU(
    input clock,
    input reset_n,
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
    /* verilator lint_off UNUSEDSIGNAL */
    input [3:0] i_wmask,//表示写哪些位
    /* verilator lint_on UNUSEDSIGNAL */
    input ifu_valid,
    input wbu_ready,
    output reg lsu_valid,
    output reg lsu_ready,
    output            o_lsu_busy,
    output reg [31:0] o_rdata,
    output reg [31:0] lsu_addr,
    output reg lsu_wen,
    // output reg lsu_ren,
    output reg [31:0] lsu_wdata,
    output reg [3:0] lsu_wmask,
    input [31:0] lsu_rdata,
    output reg lsu_reqValid,
    input lsu_respValid
);

import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, int len, input int data);

localparam IDLE = 1'b0;
localparam WAIT = 1'b1;

reg state;
// reg [31:0] rdata;
wire wen = i_sb_signal | i_sh_signal | i_sw_signal;
wire ren = i_lbu_signal | i_lhu_signal | i_lb_signal | i_lh_signal | i_lw_signal;
assign o_lsu_busy = ren | wen;

always @(posedge clock) begin
    if(!reset_n) begin
        state <= IDLE;
        // rdata <=32'b0;
        lsu_ready <= 1'b0;
        lsu_valid <= 1'b0;
        lsu_reqValid <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if(ifu_valid && (wen || ren)) begin
                    state <= WAIT;
                    lsu_ready <= 1'b1;
                    lsu_wen <= wen;
                    lsu_addr <= i_data;
                    lsu_wdata <= i_src2;
                    lsu_wmask <= i_wmask;
                    lsu_reqValid <= 1'b1;
                end
                else begin
                    state <= IDLE;
                    if (lsu_valid && wbu_ready) begin
                        lsu_valid <= 1'b0;
                    end
                end
            end
            WAIT: begin
                if(lsu_ready) begin
                    lsu_ready <= 1'b0;
                end
                // if(lsu_ren) begin
                //     lsu_ren <= 1'b0;
                // end
                if(lsu_wen) begin
                    lsu_wen <= 1'b0;
                end
                if(lsu_reqReady) begin
                    lsu_reqValid <= 1'b0;
                end

                // if(i_lw_signal | i_lhu_signal | i_lh_signal | i_lbu_signal | i_lb_signal) begin
                //     rdata <= pmem_read(i_data, 4);
                // end
                // else if (wen) begin // 有写请求时
                //     /* verilator lint_off WIDTHEXPAND */
                //     pmem_write(i_data, i_wmask, i_src2);
                //     /* verilator lint_off WIDTHEXPAND */
                //     rdata <= 0;
                // end
                // else begin
                //     rdata <= 0;
                // end
                if (lsu_respValid) begin
                    lsu_valid <= 1'b1;
                    state <= IDLE;
                end
                
            end
        endcase

    end
    
end

always @(*) begin
    if(i_lw_signal == 1'b1) begin
        o_rdata = lsu_rdata[31:0];
    end else if(i_lhu_signal == 1'b1) begin
        o_rdata = {16'b0, lsu_rdata[15:0]};
    end else if(i_lh_signal == 1'b1) begin
        o_rdata = {{16{lsu_rdata[15]}}, lsu_rdata[15:0]};
    end else if(i_lbu_signal == 1'b1) begin
        o_rdata = {24'b0, lsu_rdata[7:0]};
    end else if(i_lb_signal == 1'b1) begin
        o_rdata = {{24{lsu_rdata[7]}}, lsu_rdata[7:0]};
    end else begin
        o_rdata = 0;
    end
end

endmodule
