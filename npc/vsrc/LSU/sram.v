
module sram # (parameter DELAY = 1)(
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    // AR
    input wire [31:0] i_araddr,
    input wire i_arvalid, // 看做读使能
    output wire o_arready,
    // R
    output reg [31:0] o_rdata,
    output reg [1:0] o_rresp,
    output reg o_rvalid,
    input wire i_rready,
    // AW
    input wire [31:0] i_awaddr, 
    input wire i_awvalid, // 看做写使能
    output wire o_awready,
    // W
    input wire i_wvalid, 
    input wire [3:0]i_wstrb, 
    input wire [31:0]i_wdata, 
    output wire o_wready,
    // B
    output reg [1:0] o_bresp,
    output reg o_bvalid,
    input wire i_bready
);

import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, input int len, input int data);


//---------------------------
// 状态机定义
//---------------------------
localparam [1:0] RD_IDLE = 2'b00, RD_WAIT = 2'b01, RD_RESP = 2'b10;
localparam [1:0] WR_IDLE = 2'b00, WR_WAIT = 2'b01, WR_RESP = 2'b10;

reg [1:0] rd_state, wr_state;

// 读通道寄存器
reg [31:0] rd_addr;
reg [11:0] rd_count;
reg [11:0] rd_delay;

// 写通道寄存器
reg [31:0] wr_addr, wr_data;
reg [3:0]  wr_strb;
reg aw_latched, w_latched;
reg [11:0] wr_count;
reg [11:0] wr_delay;

// LFSR 随机延迟
reg [3:0] lsfr_data;
always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        lsfr_data <= 4'b1111;
    end else begin
        lsfr_data <= {lsfr_data[2:0], lsfr_data[3] ^ lsfr_data[1]};
        if (lsfr_data == 4'b0000)
            lsfr_data <= 4'b1111;
    end
end

assign o_arready = (state == RD_IDLE) && !i_awvalid;
assign o_wready =  (state == WR_IDLE) && !w_latched; 
assign o_awready = (state == WR_IDLE) && !aw_latched;

//----------------------------------
// 读通道 FSM
//----------------------------------

always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        rd_state <= RD_IDLE;
        //o_arready <= 1'b0;
        o_rvalid <= 1'b0;
        o_rdata <= 0;
        o_rresp <= 2'b00;
        rd_count <= 0;
    end else begin
        case (rd_state)
            RD_IDLE: begin
                //o_arready <= 1'b1;
                if (i_arvalid) begin
                    rd_addr <= i_araddr;
                    /* verilator lint_off WIDTHEXPAND */
                    rd_delay <= lsfr_data + DELAY;
                    /* verilator lint_on WIDTHEXPAND */
                    rd_count <= 0;
                    // o_arready <= 1'b0;
                    rd_state <= RD_WAIT;
                end
            end
            RD_WAIT: begin
                if (rd_count == rd_delay) begin
                    o_rdata <= pmem_read(rd_addr, 4);
                    o_rresp <= 2'b00;
                    o_rvalid <= 1'b1;
                    rd_state <= RD_RESP;
                end else begin
                    rd_count <= rd_count + 1;
                end
            end
            RD_RESP: begin
                if (i_rready) begin
                    o_rvalid <= 1'b0;
                    rd_state <= RD_IDLE;
                end
            end
            default : begin end
        endcase
    end
end

//----------------------------------
// 写通道 FSM
//----------------------------------
always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        wr_state <= WR_IDLE;
        o_awready <= 1'b0;
        // o_wready <= 1'b0;
        o_bvalid <= 1'b0;
        o_bresp <= 2'b00;
        aw_latched <= 1'b0;
        w_latched <= 1'b0;
        wr_count <= 0;
    end else begin
        case (wr_state)
            WR_IDLE: begin
                // 接收 AW
                o_awready <= !aw_latched;
                if (i_awvalid && o_awready) begin
                    wr_addr <= i_awaddr;
                    aw_latched <= 1'b1;
                    o_awready <= 1'b0;
                end
                // 接收 W
                //o_wready <= !w_latched;
                if (i_wvalid && o_wready) begin
                    wr_data <= i_wdata;
                    wr_strb <= i_wstrb;
                    w_latched <= 1'b1;
                    // o_wready <= 1'b0;
                end
                // 两者都到齐才进入写延迟
                if (aw_latched && w_latched) begin
                    /* verilator lint_off WIDTHEXPAND */
                    wr_delay <= lsfr_data + DELAY;
                    /* verilator lint_on WIDTHEXPAND */
                    wr_count <= 0;
                    wr_state <= WR_WAIT;
                end
            end
            WR_WAIT: begin
                if (wr_count == wr_delay) begin
                    /* verilator lint_off WIDTHEXPAND */
                    pmem_write(wr_addr, wr_strb, wr_data);
                    /* verilator lint_on WIDTHEXPAND */
                    o_bvalid <= 1'b1;
                    o_bresp <= 2'b00;
                    wr_state <= WR_RESP;
                end else begin
                    wr_count <= wr_count + 1;
                end
            end
            WR_RESP: begin
                if (i_bready) begin
                    o_bvalid <= 1'b0;
                    aw_latched <= 1'b0;
                    w_latched <= 1'b0;
                    wr_state <= WR_IDLE;
                end
            end
            default : begin end
        endcase
    end
end

endmodule

// module sram # (parameter DELAY = 1)(
//     input wire i_sys_clk,
//     input wire i_sys_rst_n,
//     // AR
//     input wire [31:0] i_araddr,
//     input wire i_arvalid, // 看做读使能
//     output wire o_arready,
//     // R
//     output wire [31:0] o_rdata,
//     output wire [1:0] o_rresp,
//     output wire o_rvalid,
//     input wire i_rready,
//     // AW
//     input wire [31:0] i_awaddr, 
//     input wire i_awvalid, // 看做写使能
//     output wire o_awready,
//     // W
//     input wire i_wvalid, 
//     input wire [3:0]i_wstrb, 
//     input wire [31:0]i_wdata, 
//     output wire o_wready,
//     // B
//     output wire [1:0] o_bresp,
//     output wire o_bvalid,
//     input wire i_bready
// );

// import "DPI-C" function int pmem_read(input int addr, input int len);
// import "DPI-C" function void pmem_write(
//     input int addr, input int len, input int data);


// localparam [1:0] 
//   IDLE   = 2'b00,
//   READ   = 2'b01,
//   WRITE  = 2'b10,
//   RESP   = 2'b11;


// reg [1:0] state;

// reg [31:0] araddr;
// reg [11:0] count;
// reg [31:0] sram_data;
// reg [1:0] bresp;
// reg [31:0] awaddr;
// reg [31:0] wdata;
// reg [3:0] wstrb;
// reg bvalid;
// // reg arready;
// reg rvalid;
// reg [1:0] rresp;

// assign o_rdata = sram_data;
// assign o_bresp = bresp;
// assign o_bvalid = bvalid;
// assign o_rresp = rresp;
// assign o_rvalid = rvalid;
// assign o_arready = (state == IDLE) && !i_awvalid;
// assign o_wready = o_awready; // 写通道和地址通道同步
// assign o_awready = (state == IDLE) && !i_arvalid;

// always @(posedge i_sys_clk) begin
//   if(!i_sys_rst_n) begin
//     state <= IDLE;
//     sram_data <= 0;
//     awaddr <= 0;
//     wdata <= 0;
//     araddr <= 0;
//     wstrb <= 0;
//     bresp <= 0;
//     count <= 0;
//     rresp <= 0;
//     rvalid <= 0;
//     bvalid <= 0;
//     delay_count <= DELAY;
//   end else begin
//     case(state)
//         IDLE: begin
//             /* verilator lint_off WIDTHEXPAND */
//             delay_count <= lsfr_data + DELAY;
//             /* verilator lint_on WIDTHEXPAND */

//             if(i_arvalid) begin
//                 delay_count <= delay_count;
//                 araddr <= i_araddr;
//                 state <= READ;
//                 count <= count + 1;
//                 // count <= 0;
//                 // if(count == DELAY-1) begin
//                 if(count == delay_count-1) begin
//                     sram_data <= pmem_read(i_araddr, 4);
//                     rvalid <= 1;
//                     rresp <= 2'b00; // 认为每一次都会成功
//                 end
//             end 
//             else if(i_awvalid && i_wvalid) begin // 关键修改：同步检测双通道
//                 delay_count <= delay_count;
//                 awaddr <= i_awaddr;
//                 wdata <= i_wdata;
//                 wstrb <= i_wstrb;
//                 state <= WRITE;
//                 count <= count + 1;
//                 // count <= 0;
//                 // if(count == DELAY-1) begin
//                 if(count == delay_count-1) begin
//                 /* verilator lint_off WIDTHEXPAND */
//                     pmem_write(i_awaddr, i_wstrb, i_wdata);
//                 /* verilator lint_on WIDTHEXPAND */
//                     bvalid <= 1; // 触发B响应
//                     bresp <= 2'b00; // 认为每一次都会成功
//                     state <= RESP;
//                 end
//             end
//         end

//         READ: begin
//             // if(count == DELAY-1) begin
//             if(count == delay_count-1) begin
//                 sram_data <= pmem_read(araddr, 4);
//                 rvalid <= 1;
//                 rresp <= 2'b00; // 认为每一次都会成功
//             end
//             // if(count >= DELAY && i_rready) begin // 握手完成
//             if(count >= delay_count && i_rready) begin // 握手完成
//                 state <= IDLE;
//                 rvalid <= 0;
//                 count <= 0;
//                 rresp <= 2'b00; // 认为每一次都会成功
//             end else count <= count + 1;
//             end

//             WRITE: begin
//             // if(count == DELAY-1) begin
//             if(count == delay_count-1) begin
//                 /* verilator lint_off WIDTHEXPAND */
//                 pmem_write(awaddr, wstrb, wdata);
//                 /* verilator lint_on WIDTHEXPAND */
//                 bvalid <= 1; // 触发B响应
//                 bresp <= 2'b00; // 认为每一次都会成功
//                 state <= RESP;
//             end
//             // if(count >= DELAY) state <= RESP;
//             if(count >= delay_count) state <= RESP;
//             else count <= count + 1;
//             end

//         RESP: begin
//             if(i_bready) begin // 等待响应握手
//                 bvalid <= 0;
//                 state <= IDLE;
//                 count <= 0;
//                 /* verilator lint_off WIDTHEXPAND */
//                 delay_count <= lsfr_data + DELAY;
//                 /* verilator lint_on WIDTHEXPAND */
//             end
//         end
//     endcase
//   end
// end

// reg [3:0] lsfr_data;
// reg [11:0] delay_count;
// always @(posedge i_sys_clk) begin
//     if (!i_sys_rst_n) begin
//         lsfr_data <= 4'b1111;
//     end
//     else if (state == IDLE)begin
//         lsfr_data <= {lsfr_data[2:0], lsfr_data[3] ^ lsfr_data[1]};
//         if(lsfr_data == 4'b0000) begin
//             lsfr_data <= 4'b1111; // 避免全0
//         end
//         /* verilator lint_off WIDTHEXPAND */
//         // delay_count <= lsfr_data + DELAY;
//         /* verilator lint_on WIDTHEXPAND */
//         if(i_arvalid || i_awvalid || i_wvalid) begin
//         end
//     end
//     else begin
//         lsfr_data <= {lsfr_data[2:0], lsfr_data[3] ^ lsfr_data[1]};
//     end
    
// end

// endmodule
