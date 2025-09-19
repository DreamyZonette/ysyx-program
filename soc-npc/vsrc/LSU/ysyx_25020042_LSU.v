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
    output reg [1:0] lsu_size
);

localparam IDLE = 1'b0;
localparam WAIT = 1'b1;

reg state;
reg [31:0] lsu_rdata_reg;
// reg [31:0] rdata;
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
        lsu_rdata_reg <= 32'b0;
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
                    // $strobe("lsu:lsu_addr=%08x, lsu_wdata=%08x, lsu_wmask=%08x, lsu_wen=%0d, lsu_reqValid=%0d, lsu_size=%0d",
                    //         lsu_addr, lsu_wdata, lsu_wmask, lsu_wen, lsu_reqValid, lsu_size);
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
            WAIT: begin
                if(lsu_ready) begin
                    lsu_ready <= 1'b0;
                end
                if(lsu_wen) begin
                    lsu_wen <= 1'b0;
                end
                if(lsu_reqValid) begin
                    lsu_reqValid <= 1'b0;
                end

                if (lsu_respValid) begin
                    lsu_valid <= 1'b1;
                    lsu_rdata_reg <= lsu_rdata;
                    state <= IDLE;
                end
                
            end
        endcase

    end
    
end

always @(*) begin
    if(i_lw_signal == 1'b1) begin
        o_rdata = lsu_rdata_reg[31:0];
    end else if(i_lhu_signal == 1'b1) begin
        o_rdata = {16'b0, lsu_rdata_reg[15:0]};
    end else if(i_lh_signal == 1'b1) begin
        o_rdata = {{16{lsu_rdata_reg[15]}}, lsu_rdata_reg[15:0]};
    end else if(i_lbu_signal == 1'b1) begin
        o_rdata = {24'b0, lsu_rdata_reg[7:0]};
    end else if(i_lb_signal == 1'b1) begin
        o_rdata = {{24{lsu_rdata_reg[7]}}, lsu_rdata_reg[7:0]};
    end else begin
        o_rdata = 0;
    end
end

endmodule
