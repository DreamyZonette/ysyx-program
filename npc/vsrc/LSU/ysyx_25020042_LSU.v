module ysyx_25020042_LSU(
    input clock,
    input reset,
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
    input lsu_respValid,
    output reg [1:0] lsu_size,
    input lsu_reqReady,
    output reg lsu_respReady
);

localparam IDLE = 2'b00;
localparam WAIT = 2'b01;
localparam WAIT_READY = 2'b10;

reg [1:0] state;
// reg [31:0] rdata;
// 记得修改回来
wire [31:0] shifted_rdata = (i_data >= 32'h8000_0000 && i_data <= 32'h8FFF_FFFF) ? lsu_rdata : lsu_rdata >> (lsu_addr[1:0] * 8);
wire wen = i_sb_signal | i_sh_signal | i_sw_signal;
wire ren = i_lbu_signal | i_lhu_signal | i_lb_signal | i_lh_signal | i_lw_signal;
assign o_lsu_busy = ren | wen;

always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        // rdata <=32'b0;
        lsu_ready <= 1'b0;
        lsu_valid <= 1'b0;
        lsu_reqValid <= 1'b0;
        lsu_size <= 2'b0;
        o_rdata <= 32'b0;
        lsu_wen <= 1'b0;
        lsu_respReady <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (lsu_respReady) begin
                    lsu_respReady <= 1'b0;
                end
                if(ifu_valid && (wen || ren)) begin
                    state <= WAIT_READY;
                    lsu_ready <= 1'b1;
                    lsu_wen <= wen;
                    // 当前仿真环境不需要移位
                    if (i_data >= 32'h8000_0000 && i_data <= 32'h8FFF_FFFF) begin
                        lsu_wdata <= i_src2;
                        lsu_wmask <= i_wmask;
                    end
                    else begin
                        lsu_wdata <= i_src2 << (i_data[1:0] * 8);
                        lsu_wmask <= i_wmask << i_data[1:0];
                    end
                    // lsu_wdata <= i_src2 << (i_data[1:0] * 8);
                    // lsu_wmask <= i_wmask << i_data[1:0];
                    lsu_addr <= i_data;
                    lsu_reqValid <= 1'b1;
                    if (i_sb_signal || i_lb_signal ||i_lbu_signal) begin
                        lsu_size <= 2'b00;
                    end else if (i_sh_signal || i_lh_signal || i_lhu_signal) begin
                        lsu_size <= 2'b01;
                    end else if (i_sw_signal || i_lw_signal) begin
                        lsu_size <= 2'b10;
                    end else begin
                        lsu_size <= 2'b00;
                    end
                end
                else begin
                    state <= IDLE;
                    if (lsu_valid && wbu_ready) begin
                        lsu_valid <= 1'b0;
                    end
                end
            end
            WAIT_READY: begin
                if(lsu_reqReady) begin
                    lsu_reqValid <= 1'b0;
                    state <= WAIT;
                end
                else begin 
                    state <= WAIT_READY;
                end
            end
            WAIT: begin
                
                if(lsu_ready) begin
                    lsu_ready <= 1'b0;
                end
                
                if(lsu_reqReady) begin
                    lsu_reqValid <= 1'b0;
                end

                if (lsu_respValid) begin
                    lsu_respReady <= 1'b1;
                    lsu_valid <= 1'b1;
                    state <= IDLE;
                    if(lsu_wen) begin
                        lsu_wen <= 1'b0;
                    end
                    if(i_lw_signal == 1'b1) begin
                        o_rdata <= shifted_rdata[31:0];
                    end else if(i_lhu_signal == 1'b1) begin
                        o_rdata <= {16'b0, shifted_rdata[15:0]};
                    end else if(i_lh_signal == 1'b1) begin
                        o_rdata <= {{16{shifted_rdata[15]}}, shifted_rdata[15:0]};
                    end else if(i_lbu_signal == 1'b1) begin
                        o_rdata <= {24'b0, shifted_rdata[7:0]};
                    end else if(i_lb_signal == 1'b1) begin
                        o_rdata <= {{24{shifted_rdata[7]}}, shifted_rdata[7:0]};
                    end else begin
                        o_rdata <= 0;
                    end
                end
                
            end
        endcase

    end
    
end

endmodule
