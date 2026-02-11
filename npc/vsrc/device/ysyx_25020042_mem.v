module ysyx_25020042_mem(
    input clock,
    // axi 握手信号
    input [31:0]      slave_araddr    ,
    input             slave_arvalid   ,
    output reg        slave_arready   ,
    input [3:0]       slave_arid      ,
    input [7:0]       slave_arlen     ,
    input [2:0]       slave_arsize    ,
    input [1:0]       slave_arburst   ,

    output reg [31:0] slave_rdata     ,
    output reg        slave_rvalid    ,
    output reg [1:0]  slave_rresp     ,
    input             slave_rready    ,
    output reg        slave_rlast     ,
    output reg  [3:0] slave_rid       ,

    input [31:0]      slave_awaddr    ,
    input             slave_awvalid   ,
    output reg        slave_awready   ,
    input  [3:0]      slave_awid      ,
    input  [7:0]      slave_awlen     ,
    input  [2:0]      slave_awsize    ,
    input  [1:0]      slave_awburst   ,

    input [31:0]      slave_wdata     ,
    input [3:0]       slave_wstrb     ,
    input             slave_wvalid    ,
    output reg        slave_wready    ,
    input             slave_wlast     ,

    output reg        slave_bvalid    ,
    input             slave_bready    ,
    output reg [1:0]  slave_bresp     ,
    output reg [3:0]  slave_bid    
);
`ifdef VERILATOR
import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, int len, input int data);
`endif

reg [2:0] state;
reg [7:0] burst_count;
wire [31:0] read_addr = slave_araddr + 4 * burst_count;

localparam IDLE = 3'd0;
localparam READ = 3'd1;
localparam READ_WAIT = 3'd2;
localparam WRITE = 3'd3;
localparam WRITE_WAIT = 3'd4;

always @(posedge clock) begin
   if (slave_rlast)
        burst_count <= 0;
    else if (slave_rvalid && state == READ)
        burst_count <= burst_count + 1;
end

always @(posedge clock) begin
    case (state)
        IDLE: begin
                slave_arready <= 1'b1;
                slave_awready <= 1'b1;
                slave_wready <= 1'b1;

            if (slave_arvalid) begin
                state <= READ;
                slave_arready <= 1'b0;
                slave_awready <= 1'b0;
                slave_wready <= 1'b0;
                slave_rid <= slave_arid;
            end
            else if (slave_awvalid && slave_wvalid) begin
                state <= WRITE;
                slave_arready <= 1'b0;
                slave_awready <= 1'b0;
                slave_wready <= 1'b0;
                slave_bid <= slave_awid;
            end
        end
        READ: begin
            if (slave_rready) begin
                if (slave_rvalid == 0) begin
                    slave_rvalid <= 1'b1;
                    `ifdef VERILATOR
                    slave_rdata <= pmem_read(read_addr, 4);
                    `endif
                end
                slave_rvalid <= 1'b0;
                if (slave_arlen == burst_count && slave_rvalid == 0) begin
                    slave_rlast <= 1'b1;
                    slave_rresp <= 2'b00;
                    state <= READ_WAIT;
                end
            end
        end
        READ_WAIT: begin
            if (slave_rready) begin
                slave_rvalid <= 1'b0;
                slave_rresp <= 2'b00;
                slave_rdata <= 32'b0;
                state <= IDLE;
            end
        end
        WRITE: begin
            // if (slave_awready || slave_wready) begin
            //     slave_awready <= 1'b0;
            //     slave_wready <= 1'b0;
            // end
            `ifdef VERILATOR
            /* verilator lint_off WIDTHEXPAND */
            pmem_write(slave_awaddr, slave_wstrb, slave_wdata);
            /* verilator lint_on WIDTHEXPAND */
            `endif
            state <= WRITE_WAIT;
            slave_bresp <= 2'b00;
            slave_bvalid <= 1'b1;
        end
        WRITE_WAIT: begin
            if (slave_bready) begin
                slave_bvalid <= 1'b0;
                slave_bresp <= 2'b00;
                state <= IDLE;
            end
        end
        default: begin
            state <= IDLE;
        end
    endcase 
end

endmodule
