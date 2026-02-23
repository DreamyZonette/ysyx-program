// `define LSU_MTRACE

module ysyx_25020042_LSU(
    input                           clock,
    input                           reset,
    input                           exu_valid,
    input                           wbu_ready,
    output reg                      lsu_valid,
    output reg                      lsu_ready,

    input [7:0]                     i_inst,
    input [31:0]                    i_src2,
    input [31:0]                    i_data, // exu data
    input [31:0]                    i_pc_data,
    input [31:0]                    i_csr_data,
    input [11:0]                    i_csr_addr,
    input [4:0]                     i_rd,

    output reg [7:0]                o_inst,
    output reg [31:0]               o_data,
    output reg [31:0]               o_pc_data,
    output reg [31:0]               o_csr_data,
    output reg [11:0]               o_csr_addr,
    output reg [4:0]                o_rd,

    /* verilator lint_off UNUSEDSIGNAL */
    `ifdef VERILATOR
    output reg [63:0]               performance_counter,
    `endif
    /* verilator lint_on UNUSEDSIGNAL */
    // output                          o_lsu_busy,

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
`ifndef PLATFORM_NPC
import "DPI-C" function void difftest_device_skip();
`endif
    // reg [63:0] performance_counter;
    reg lsu_valid_signal;
    always @(posedge clock) begin
        if(reset) begin
            lsu_valid_signal <= 1'b0;
        end
        else if (lsu_arvalid | lsu_awvalid) begin
            lsu_valid_signal <= 1;
        end
        else if (lsu_rvalid | lsu_bvalid) begin
            lsu_valid_signal <= 0;
        end
    end

    always @(posedge clock) begin
        if(reset) 
            performance_counter <= 0;
        else if ((lsu_bvalid | lsu_rvalid) & lsu_valid_signal)
            performance_counter <= performance_counter + 1;
    end
`endif

localparam  MEM_INST     = 3'b011;
// 状态定义
localparam IDLE = 2'b00;
localparam WAIT = 2'b01;
localparam WAIT_READY = 2'b10;


reg [1:0] state;
/* verilator lint_off UNUSEDSIGNAL */
reg [1:0] rresp;
reg [1:0] bresp;
/* verilator lint_on UNUSEDSIGNAL */
wire [3:0] wstrb;
wire [31:0] wdata;
wire        twice_signal;

// 记得修改回来
`ifdef PLATFORM_NPC
wire [31:0] shifted_rdata = lsu_rdata >> (lsu_araddr[1:0] * 8);

`else 
wire [31:0] shifted_rdata = (lsu_araddr >= 32'h3000_0000 && lsu_araddr < 32'h4000_0000) ? lsu_rdata : lsu_rdata >> (lsu_araddr[1:0] * 8);
`endif
reg wen;
reg ren;
reg [3:0] wmask;

always @(posedge clock) begin
    if(reset) begin
        o_inst <= 8'b0;
        o_pc_data <= 32'b0;
        o_rd <= 5'b0;
        o_csr_data <= 32'b0;
        o_csr_addr <= 12'b0;
    end
    else if(exu_valid & lsu_ready) begin
        o_inst <= i_inst;
        o_pc_data <= i_pc_data;
        o_rd <= i_rd;
        o_csr_data <= i_csr_data;
        o_csr_addr <= i_csr_addr;
    end
    else if (lsu_valid & wbu_ready ) 
        o_rd <= 5'b0;
end

/* verilator lint_off WIDTHEXPAND */
assign wdata = i_src2 << (i_data[1:0] * 8);
assign wstrb = wmask << i_data[1:0];
/* verilator lint_on WIDTHEXPAND */

always @(*) begin
    wen = 1'b0;
    ren = 1'b0;
    wmask = 4'b0000;
    if(i_inst[7:5] == MEM_INST) begin
        case (i_inst[4:0])
            5'b00110: begin // sw
                wen = 1'b1;
                wmask = 4'b1111;
            end
            5'b00111: begin // sh
                wen = 1'b1;
                wmask = 4'b0011;
            end
            5'b01000: begin // sb
                wen = 1'b1;
                wmask = 4'b0001;
            end
            default: begin
                ren = 1'b1;
            end
    endcase
    end
end

always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        o_data <= 32'b0;
        lsu_ready <= 1'b1;
        lsu_valid <= 1'b0;
        lsu_arvalid <= 1'b0;
        lsu_awvalid <= 1'b0;
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
                if(exu_valid & lsu_ready) begin
                    if (wen || ren) begin
                        state <= WAIT;
                        lsu_ready <= 1'b0;

                        lsu_wdata <= wdata;
                        lsu_wstrb <= wstrb;
                        lsu_araddr <= i_data;
                        lsu_awaddr <= i_data;  
                        case (i_inst[4:0])
                            5'b00110: begin // sw
                                lsu_arsize <= 3'b000;
                                lsu_awsize <= 3'b010;
                            end
                            5'b00111: begin // sh
                                lsu_arsize <= 3'b000;
                                lsu_awsize <= 3'b001;
                            end
                            5'b00001: begin // lw
                                lsu_arsize <= 3'b010;
                                lsu_awsize <= 3'b000;
                            end
                            5'b00010: begin // lh
                                lsu_arsize <= 3'b001;
                                lsu_awsize <= 3'b000;
                            end
                            5'b00011: begin // lhu
                                lsu_arsize <= 3'b001;
                                lsu_awsize <= 3'b000;
                            end
                            default: begin
                                lsu_arsize <= 3'b000;
                                lsu_awsize <= 3'b000;
                            end
                        endcase
                        if (wen) begin
                            lsu_awvalid <= 1'b1;
                            lsu_wvalid <= 1'b1;
                            lsu_wlast <= 1'b1;
                            `ifdef LSU_MTRACE
                                $display("LSU: write addr: %x data: %x", i_data, wdata);
                            `endif
                        end
                        else begin
                            lsu_rready <= 1'b1;
                            lsu_arvalid <= 1'b1;
                        end
                    end
                    else begin
                        o_data <= i_data;
                        lsu_ready <= 1'b0;
                        lsu_valid <= 1'b1;
                    end
                end
                else begin
                    state <= IDLE;

                    if (lsu_rready) begin
                        lsu_rready <= 1'b0;
                    end

                    if (lsu_bready) begin
                        lsu_bready <= 1'b0;
                    end

                    if(lsu_valid & wbu_ready ) begin
                        lsu_ready <= 1'b1;
                        lsu_valid <= 1'b0;
                    end
                end
            end
            WAIT: begin
                `ifndef PLATFORM_NPC
                `ifdef VERILATOR 
                    if (lsu_araddr >= 32'h1000_0000 && lsu_araddr < 32'h1000_1000 && lsu_arvalid && lsu_arready || 
                        lsu_araddr >= 32'h1000_1000 && lsu_araddr < 32'h1000_2000 && lsu_arvalid && lsu_arready) begin
                        difftest_device_skip();
                    end
                `endif
                `endif
                if(lsu_arready) begin
                    lsu_arvalid <= 1'b0;
                end
                
                if(lsu_awready & lsu_wready) begin
                    lsu_awvalid <= 1'b0;
                    lsu_wvalid <= 1'b0;
                end

                if (lsu_rvalid & lsu_rlast & lsu_rid == lsu_arid) begin
                    lsu_rready <= 1'b0;
                    lsu_valid <= 1'b1;
                    rresp <= lsu_rresp;
                    state <= IDLE;
                    case (i_inst[4:0])
                        5'b00001: o_data <= shifted_rdata[31:0];
                        5'b00011: o_data <= {16'b0, shifted_rdata[15:0]};
                        5'b00010: o_data <= {{16{shifted_rdata[15]}}, shifted_rdata[15:0]};
                        5'b00101: o_data <= {24'b0, shifted_rdata[7:0]};
                        5'b00100: o_data <= {{24{shifted_rdata[7]}}, shifted_rdata[7:0]};
                        default: o_data <= 0;
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
