`define LSU_MTRACE

module ysyx_25020042_LSU(
    input                           clock,
    input                           reset,
    input                           i_lbu_signal,
    input                           i_lhu_signal,
    input                           i_lb_signal,
    input                           i_lh_signal,
    input                           i_lw_signal,
    input                           i_sb_signal,
    input                           i_sh_signal,
    input                           i_sw_signal,
    input [31:0]                    i_src2,
    input [31:0]                    i_data,
    /* verilator lint_off UNUSEDSIGNAL */
    input [3:0]                     i_wmask,//表示写哪些位
    /* verilator lint_on UNUSEDSIGNAL */
    input                           ifu_valid,
    input                           wbu_ready,
    output reg                      lsu_valid,
    output reg                      lsu_ready,
    output                          o_lsu_busy,
    output reg [31:0]               o_rdata,

    // axi 握手信号
    output reg [31:0]               lsu_araddr,
    output reg                      lsu_arvalid,
    output reg [3:0]                lsu_arid,
    output reg [7:0]                lsu_arlen,
    output reg [2:0]                lsu_arsize,
    output reg [1:0]                lsu_arburst,
    input                           lsu_arready,

    input [31:0]                    lsu_rdata,
    input                           lsu_rvalid,
    input [1:0]                     lsu_rresp,
    input [3:0]                     lsu_rid,
    input                           lsu_rlast,
    output reg                      lsu_rready,

    output reg [31:0]               lsu_awaddr,
    output reg                      lsu_awvalid,
    output reg [3:0]                lsu_awid,
    output reg [7:0]                lsu_awlen,
    output reg [2:0]                lsu_awsize,
    output reg [1:0]                lsu_awburst,
    input                           lsu_awready,

    output reg [31:0]               lsu_wdata,
    output reg [3:0]                lsu_wstrb,
    output reg                      lsu_wvalid,
    output reg                      lsu_wlast,
    input                           lsu_wready,

    input                           lsu_bvalid,
    output reg                      lsu_bready,
    input [1:0]                     lsu_bresp,
    input [3:0]                     lsu_bid
);

`ifdef VERILATOR
import "DPI-C" function void difftest_device_skip();
`endif

// 状态定义
localparam IDLE = 2'b00;
localparam WAIT = 2'b01;
localparam WAIT_READY = 2'b10;


reg [1:0] state;
/* verilator lint_off UNUSEDSIGNAL */
reg [1:0] rresp;
reg [1:0] bresp;
/* verilator lint_on UNUSEDSIGNAL */
wire [7:0] wstrb;
wire [63:0] wdata;
wire        twice_signal;

/* verilator lint_off WIDTHEXPAND */
assign wdata = i_src2 << (i_data[1:0] * 8);
assign wstrb = i_wmask << i_data[1:0];
/* verilator lint_on WIDTHEXPAND */

// 记得修改回来
wire [31:0] shifted_rdata = (lsu_araddr >= 32'h3000_0000 && lsu_araddr < 32'h4000_0000) ? lsu_rdata : lsu_rdata >> (lsu_araddr[1:0] * 8);
// wire [31:0] shifted_rdata = (lsu_araddr >= 32'h1000_0000 && lsu_araddr < 32'h1000_1000) ? lsu_rdata : lsu_rdata >> (lsu_araddr[1:0] * 8);
wire wen = i_sb_signal | i_sh_signal | i_sw_signal;
wire ren = i_lbu_signal | i_lhu_signal | i_lb_signal | i_lh_signal | i_lw_signal;
assign o_lsu_busy = ren | wen;

always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        lsu_ready <= 1'b0;
        lsu_valid <= 1'b0;
        lsu_arvalid <= 1'b0;
        lsu_awvalid <= 1'b0;
        o_rdata <= 32'b0;
        lsu_araddr <= 32'b0;
        lsu_awaddr <= 32'b0;
        lsu_rready <= 1'b0;
        lsu_wdata <= 32'b0;
        lsu_wstrb <= 4'b0;
        lsu_wvalid <= 1'b0;
        lsu_bready <= 1'b0;
        lsu_arid <= 4'b0;
        lsu_awid <= 4'b0;
        lsu_arlen <= 8'b0;
        lsu_awlen <= 8'b0;
        lsu_arsize <= 3'b0;
        lsu_awsize <= 3'b0;
        lsu_arburst <= 2'b00;
        lsu_awburst <= 2'b00;
        lsu_wlast <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (lsu_rready) begin
                    lsu_rready <= 1'b0;
                end
                if (lsu_bready) begin
                    lsu_bready <= 1'b0;
                end
                if((ifu_valid && (wen || ren))) begin
                    state <= WAIT;
                    lsu_ready <= 1'b1;
                        lsu_wdata <= wdata[31:0];
                        lsu_wstrb <= wstrb[3:0];
                        // lsu_araddr <= {i_data[31:2], 2'b00};
                        // lsu_awaddr <= {i_data[31:2], 2'b00};
                        lsu_araddr <= i_data;
                        lsu_awaddr <= i_data;                    // end
                    if (wen) begin
                        lsu_awvalid <= 1'b1;
                        lsu_wvalid <= 1'b1;
                        lsu_wlast <= 1'b1;
                        `ifdef LSU_MTRACE
                            $display("LSU: %08x write addr: %x data: %x", i_data, wdata[31:0]);
                        `endif
                    end
                    else begin
                        lsu_arvalid <= 1'b1;
                    end
                    case (1'b1)
                        i_lw_signal: begin
                            lsu_arsize <= 3'b010;
                            lsu_awsize <= 3'b010;
                            lsu_arlen <= 8'b0000_0000;
                            lsu_awlen <= 8'b0000_0000;
                        end
                        i_lhu_signal: begin
                            lsu_arsize <= 3'b001;
                            lsu_awsize <= 3'b001;
                            lsu_arlen <= 8'b0000_0000;
                            lsu_awlen <= 8'b0000_0000;
                        end
                        i_lh_signal: begin
                            lsu_arsize <= 3'b001;
                            lsu_awsize <= 3'b001;
                            lsu_arlen <= 8'b0000_0000;
                            lsu_awlen <= 8'b0000_0000;
                        end
                        i_lb_signal: begin
                            lsu_arsize <= 3'b000;
                            lsu_awsize <= 3'b000;
                            lsu_arlen <= 8'b0000_0000;
                            lsu_awlen <= 8'b0000_0000;
                        end
                        i_lbu_signal: begin
                            lsu_arsize <= 3'b000;
                            lsu_awsize <= 3'b000;
                            lsu_arlen <= 8'b0000_0000;
                            lsu_awlen <= 8'b0000_0000;
                        end
                        i_sb_signal: begin
                            lsu_arsize <= 3'b000;
                            lsu_awsize <= 3'b000;
                            lsu_arlen <= 8'b0000_0000;
                            lsu_awlen <= 8'b0000_0000;
                        end
                        i_sh_signal: begin
                            lsu_arsize <= 3'b001;
                            lsu_awsize <= 3'b001;
                            lsu_arlen <= 8'b0000_0000;
                            lsu_awlen <= 8'b0000_0000;
                        end
                        i_sw_signal: begin
                            lsu_arsize <= 3'b010;
                            lsu_awsize <= 3'b010;
                            lsu_arlen <= 8'b0000_0000;
                            lsu_awlen <= 8'b0000_0000;
                        end
                    endcase
                end
                else begin
                    state <= IDLE;
                    if (lsu_valid && wbu_ready) begin
                        lsu_valid <= 1'b0;
                    end
                end
            end
            WAIT: begin
                `ifdef VERILATOR
                    // if (lsu_araddr >= 32'h1000_0000 && lsu_araddr < 32'h1000_1000 && lsu_arvalid && lsu_arready || 
                    //     lsu_awaddr >= 32'h1000_0000 && lsu_awaddr < 32'h1000_1000 && lsu_awvalid && lsu_awready) begin
                    if (lsu_araddr >= 32'h1000_0000 && lsu_araddr < 32'h1000_1000 && lsu_arvalid && lsu_arready || 
                        lsu_araddr >= 32'h1000_1000 && lsu_araddr < 32'h1000_2000 && lsu_arvalid && lsu_arready) begin
                        difftest_device_skip();
                    end
                `endif
                if(lsu_arready) begin
                    lsu_arvalid <= 1'b0;
                end
                
                if(lsu_awready & lsu_wready) begin
                    lsu_awvalid <= 1'b0;
                    lsu_wvalid <= 1'b0;
                end

                if(lsu_ready ) begin
                    lsu_ready <= 1'b0;
                end
                if (lsu_rvalid & lsu_rlast & lsu_rid == lsu_arid) begin
                    lsu_rready <= 1'b1;
                    lsu_valid <= 1'b1;
                    rresp <= lsu_rresp;
                    state <= IDLE;
                    case (1'b1)
                        i_lw_signal: o_rdata <= shifted_rdata[31:0];
                        i_lhu_signal: o_rdata <= {16'b0, shifted_rdata[15:0]};
                        i_lh_signal: o_rdata <= {{16{shifted_rdata[15]}}, shifted_rdata[15:0]};
                        i_lbu_signal: o_rdata <= {24'b0, shifted_rdata[7:0]};
                        i_lb_signal: o_rdata <= {{24{shifted_rdata[7]}}, shifted_rdata[7:0]};
                        // i_lw_signal: o_rdata <= lsu_rdata;
                        // i_lhu_signal: o_rdata <= {16'b0, lsu_rdata[15:0]};
                        // i_lh_signal: o_rdata <= {{16{lsu_rdata[15]}}, lsu_rdata[15:0]};
                        // i_lbu_signal: o_rdata <= {24'b0, lsu_rdata[7:0]};
                        // i_lb_signal: o_rdata <= {{24{lsu_rdata[7]}}, lsu_rdata[7:0]};
                        default: o_rdata <= 0;
                    endcase
                end
                else if (lsu_bvalid & lsu_bid == lsu_awid) begin
                    lsu_bready <= 1'b1;
                    lsu_valid <= 1'b1;
                    bresp <= lsu_bresp;
                    state <= IDLE;
                end
                else begin 
                    state <= WAIT;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase

    end
    
end

endmodule
