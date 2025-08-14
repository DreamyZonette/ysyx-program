module Xbar (
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    // LSU
    input wire [31:0] i_axi_lsu_araddr,
    input wire i_axi_lsu_arvalid,
    output reg o_axi_lsu_arready,
    output reg [31:0] o_axi_lsu_rdata,
    output reg [1:0] o_axi_lsu_rresp,
    output reg o_axi_lsu_rvalid,
    input wire i_axi_lsu_rready,

    input wire [31:0] i_axi_lsu_awaddr,
    input wire i_axi_lsu_awvalid,
    output reg o_axi_lsu_awready,
    input wire [31:0] i_axi_lsu_wdata,
    input wire [3:0] i_axi_lsu_wstrb,
    input wire i_axi_lsu_wvalid,
    output reg o_axi_lsu_wready,
    output reg [1:0] o_axi_lsu_bresp,
    output reg o_axi_lsu_bvalid,
    input wire i_axi_lsu_bready,
    //IFU
    input wire [31:0] i_axi_ifu_araddr,
    input wire i_axi_ifu_arvalid,
    output reg o_axi_ifu_arready,
    output reg [31:0] o_axi_ifu_rdata,
    output reg [1:0] o_axi_ifu_rresp,
    output reg o_axi_ifu_rvalid,
    input wire i_axi_ifu_rready,
    //SRAM
    output reg [31:0] o_axi_sram_araddr,
    output reg o_axi_sram_arvalid,
    input wire i_axi_sram_arready,
    input wire [31:0] i_axi_sram_rdata,
    input wire [1:0] i_axi_sram_rresp,
    input wire i_axi_sram_rvalid,
    output reg o_axi_sram_rready,

    output reg [31:0] o_axi_sram_awaddr,
    output reg o_axi_sram_awvalid,
    input wire i_axi_sram_awready,
    output reg [31:0] o_axi_sram_wdata,
    output reg [3:0] o_axi_sram_wstrb,
    output reg o_axi_sram_wvalid,
    input wire i_axi_sram_wready,
    input wire [1:0] i_axi_sram_bresp,
    input wire i_axi_sram_bvalid,
    output reg o_axi_sram_bready,
    //UART
    output reg [31:0] o_axi_uart_awaddr,
    output reg o_axi_uart_awvalid,
    input wire i_axi_uart_awready,
    output reg [31:0] o_axi_uart_wdata,
    output reg [3:0] o_axi_uart_wstrb,
    output reg o_axi_uart_wvalid,
    input wire i_axi_uart_wready,
    input wire [1:0] i_axi_uart_bresp,
    input wire i_axi_uart_bvalid,
    output reg o_axi_uart_bready

);
//----------------------------------
// 设备地址映射
//----------------------------------

localparam SRAM_LEFT    = 32'h8000_0000;
localparam SRAM_RIGHT   = 32'h87FF_FFFF;
localparam UART_LEFT    = 32'ha000_03F8;
localparam UART_RIGHT   = 32'ha000_03FF;

localparam  RD_IDLE = 3'b000;
localparam  RD_LSU_WAIT = 3'b001;
localparam  RD_IFU_WAIT = 3'b010;
localparam  RD_LSU_RESP = 3'b011;
localparam  RD_IFU_RESP = 3'b100;
localparam  WR_IDLE = 2'b00;
localparam  WR_WAIT = 2'b01;
localparam  WR_RESP = 2'b10;
//----------------------------------
// 状态寄存器
//----------------------------------
reg [2:0] rd_state;
reg [1:0] wr_state;
reg wr_device; // 0:SRAM 1:UART
// reg rd_device;
reg aw_signal;
reg w_signal;

//----------------------------------
// 读通道 FSM
//----------------------------------

always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        o_axi_lsu_arready <= 0;
        o_axi_lsu_rdata <= 0;
        o_axi_lsu_rresp <= 0;
        o_axi_lsu_rvalid <= 0;
        o_axi_sram_araddr <= 0;
        o_axi_sram_arvalid <= 0;
        o_axi_sram_rready <= 0;  
        o_axi_ifu_arready <= 0;
        o_axi_ifu_rdata <= 0;
        o_axi_ifu_rresp <= 0;
        o_axi_ifu_rvalid <= 0; 
        rd_state <= RD_IDLE;
    end
    else begin
        // 默认值
        o_axi_lsu_arready <= 0;
        o_axi_ifu_arready <= 0;
        o_axi_lsu_rvalid <= 0;
        o_axi_ifu_rvalid <= 0;
        o_axi_sram_arvalid <= 0;
        o_axi_sram_rready <= 0;

        case (rd_state)
        RD_IDLE: begin
            // 清除有效信号
            o_axi_lsu_arready <= 0;
            o_axi_ifu_arready <= 0;

            if (i_axi_ifu_arvalid) begin
                if (i_axi_ifu_araddr >= SRAM_LEFT && 
                    i_axi_ifu_araddr <= SRAM_RIGHT) begin // 取指优先级高于访存s

                    o_axi_sram_araddr <= i_axi_ifu_araddr;
                    o_axi_sram_arvalid <= i_axi_ifu_arvalid;
                    // o_axi_sram_rready <= i_axi_ifu_rready;
                    rd_state <= RD_IFU_WAIT;
                end
                else begin
                    o_axi_ifu_arready <= 1'b1;
                    o_axi_ifu_rresp <= 2'b10; // DECERR
                    o_axi_ifu_rvalid <= 1'b1;
                    rd_state <= RD_IFU_RESP;
                end      
            end
            else if (i_axi_lsu_arvalid && !i_axi_ifu_arvalid) begin
                if (i_axi_lsu_araddr >= SRAM_LEFT && 
                    i_axi_lsu_araddr <= SRAM_RIGHT) begin

                    o_axi_sram_araddr <= i_axi_lsu_araddr;
                    o_axi_sram_arvalid <= i_axi_lsu_arvalid;
                    // o_axi_sram_rready <= i_axi_lsu_rready;  
                    rd_state <= RD_LSU_WAIT;
                end
                else begin
                    o_axi_lsu_arready <= 1'b1;
                    o_axi_lsu_rresp <= 2'b10;// 错误响应
                    o_axi_lsu_rvalid <= 1'b1;
                    rd_state <= RD_LSU_RESP;
                end
            end
        end
        RD_IFU_WAIT: begin
            if (i_axi_sram_arready) begin
                o_axi_sram_arvalid <= 1'b0;
                o_axi_ifu_arready <= 1'b1;
            end

            if (i_axi_sram_rvalid) begin
                // o_axi_ifu_arready <= i_axi_sram_arready;
                o_axi_ifu_rdata <= i_axi_sram_rdata;
                o_axi_ifu_rresp <= i_axi_sram_rresp;
                o_axi_ifu_rvalid <= 1'b1;
                o_axi_sram_rready <= i_axi_ifu_rready;
                rd_state <= RD_IFU_RESP;
            end
        end
        RD_LSU_WAIT: begin
            if (i_axi_sram_arready) begin
                o_axi_sram_arvalid <= 1'b0;
                o_axi_lsu_arready <= 1'b1;
            end

            if (i_axi_sram_rvalid) begin
                // o_axi_ifu_arready <= i_axi_sram_arready;
                o_axi_lsu_rdata <= i_axi_sram_rdata;
                o_axi_lsu_rresp <= i_axi_sram_rresp;
                o_axi_lsu_rvalid <= i_axi_sram_rvalid;
                o_axi_sram_rready <= i_axi_lsu_rready;
                rd_state <= RD_LSU_RESP;
            end
        end
        RD_IFU_RESP: begin
            if (i_axi_ifu_rready) begin
                rd_state <= RD_IDLE;
            end
            else begin
                o_axi_sram_rready <= i_axi_ifu_rready;
                o_axi_ifu_rvalid <= 1'b1; // 保持响应
            end
        end
        RD_LSU_RESP: begin
            if (i_axi_lsu_rready) begin
                rd_state <= RD_IDLE;
            end
            else begin
                o_axi_sram_rready <= i_axi_lsu_rready;
                o_axi_lsu_rvalid <= 1'b1; // 保持响应
            end
        end
        default:begin end
        endcase
    end
end

//----------------------------------
// 写通道 FSM
//----------------------------------

always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        o_axi_lsu_awready <= 0;
        o_axi_lsu_wready <= 0;
        o_axi_lsu_bresp <= 0;
        o_axi_lsu_bvalid <= 0;
        o_axi_sram_awaddr <= 0;
        o_axi_sram_awvalid <= 0;
        o_axi_sram_wdata <= 0;
        o_axi_sram_wstrb <= 0;
        o_axi_sram_wvalid <= 0;
        o_axi_sram_bready <= 0;  
        o_axi_uart_awaddr <= 0;
        o_axi_uart_awvalid <= 0;
        o_axi_uart_wdata <= 0;
        o_axi_uart_wstrb <= 0;
        o_axi_uart_wvalid <= 0;
        o_axi_uart_bready <= 0; 
        wr_state <= WR_IDLE;
        aw_signal <= 0;
        w_signal <= 0;
    end
    else begin
        o_axi_sram_wvalid <= 0;
        o_axi_sram_bready <= 0;  
        o_axi_lsu_bvalid <= 0;
        o_axi_lsu_awready <= 0;
        o_axi_lsu_wready <= 0;
        o_axi_sram_awvalid <= 0;
        o_axi_uart_awvalid <= 0;
        o_axi_uart_wvalid <= 0;
        o_axi_uart_bready <= 0; 

        case (wr_state) 

        WR_IDLE: begin
            o_axi_lsu_bvalid <= 0;
            o_axi_lsu_awready <= 0;
            o_axi_lsu_wready <= 0;

            if(i_axi_lsu_awvalid) begin
                aw_signal <= 1'b1;
                if (i_axi_lsu_awaddr >= SRAM_LEFT && 
                    i_axi_lsu_awaddr <= SRAM_RIGHT) begin

                        o_axi_sram_awaddr <= i_axi_lsu_awaddr;
                        o_axi_sram_awvalid <= 1'b1;
                        wr_device <= 0; // SRAM
                end
                else if (i_axi_lsu_awaddr >= UART_LEFT &&
                    i_axi_lsu_awaddr <= UART_RIGHT) begin

                        o_axi_uart_awaddr <= i_axi_lsu_awaddr;
                        o_axi_uart_awvalid <= 1'b1;
                        wr_device <= 1; // UART
                end
                else begin
                    o_axi_lsu_awready <= 1'b1;
                    o_axi_lsu_bresp <= 2'b10; // DECERR
                    o_axi_lsu_bvalid <= 1'b1;
                    wr_device <= 0; // SRAM
                    wr_state <= WR_RESP;
                end
            end

            if (i_axi_lsu_wvalid) begin
                w_signal <= 1'b1;
                if (i_axi_lsu_awaddr >= SRAM_LEFT && 
                    i_axi_lsu_awaddr <= SRAM_RIGHT) begin
                        o_axi_sram_wdata <= i_axi_lsu_wdata;
                        o_axi_sram_wstrb <= i_axi_lsu_wstrb;
                        o_axi_sram_wvalid <= 1'b1;
                end
                else if (i_axi_lsu_awaddr >= UART_LEFT &&
                    i_axi_lsu_awaddr <= UART_RIGHT) begin
                        o_axi_uart_wdata <= i_axi_lsu_wdata;
                        o_axi_uart_wstrb <= i_axi_lsu_wstrb;
                        o_axi_uart_wvalid <= 1'b1;
                end
                else begin
                    o_axi_lsu_awready <= 1'b1;
                    o_axi_lsu_bresp <= 2'b10; // DECERR
                    o_axi_lsu_bvalid <= 1'b1;
                    wr_state <= WR_RESP;
                end
                end

            if (w_signal && aw_signal) begin
                wr_state <= WR_WAIT;
            end
        end

        WR_WAIT: begin
            // SRAM
            if (wr_device == 0) begin
                if (i_axi_sram_awready && i_axi_sram_wready) begin
                    o_axi_sram_awvalid <= 1'b0;
                    o_axi_lsu_awready <= 1'b1;
                    o_axi_lsu_wready <= 1'b1;
                end
                if (i_axi_sram_bvalid) begin
                    o_axi_lsu_bresp <= i_axi_sram_bresp;
                    o_axi_lsu_bvalid <= 1'b1;
                    o_axi_sram_bready <= i_axi_lsu_bready;
                    wr_state <= WR_RESP;
                end
            end
            else if (wr_device == 1) begin
                if (i_axi_uart_awready && i_axi_uart_wready) begin
                    o_axi_uart_awvalid <= 1'b0;
                    o_axi_lsu_awready <= 1'b1;
                    o_axi_lsu_wready <= 1'b1;
                end

                if (i_axi_uart_bvalid) begin
                    o_axi_lsu_bresp <= i_axi_uart_bresp;
                    o_axi_lsu_bvalid <= 1'b1;
                    o_axi_uart_bready <= i_axi_lsu_bready;
                    wr_state <= WR_RESP;
                end
            end
        end
        WR_RESP : begin
            if (i_axi_lsu_bready) begin
                wr_state <= WR_IDLE;
                wr_device <= 0; // SRAM
                w_signal <= 0;
                aw_signal <= 0;
            end
            else begin
                o_axi_lsu_bvalid <= 1'b1; // 保持响应
            end
        end
    default: begin end
    endcase
    end
    
end

endmodule
