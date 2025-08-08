
module sram # (parameter DELAY = 1)(
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    // AR
    input wire [31:0] i_araddr,
    input wire i_arvalid, // 看做读使能
    output wire o_arready,
    // R
    output wire [31:0] o_rdata,
    output wire [1:0] o_rresp,
    output wire o_rvalid,
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
    output wire [1:0] o_bresp,
    output wire o_bvalid,
    input wire i_bready
);

import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, input int len, input int data);


localparam [1:0] 
  IDLE   = 2'b00,
  READ   = 2'b01,
  WRITE  = 2'b10,
  RESP   = 2'b11;


reg [1:0] state;

reg [31:0] araddr;
reg [11:0] count;
reg [31:0] sram_data;
reg [1:0] bresp;
reg [31:0] awaddr;
reg [31:0] wdata;
reg [3:0] wstrb;
reg bvalid;
// reg arready;
reg rvalid;
reg [1:0] rresp;

assign o_rdata = sram_data;
assign o_bresp = bresp;
assign o_bvalid = bvalid;
assign o_rresp = rresp;
assign o_rvalid = rvalid;
assign o_arready = (state == IDLE) && !i_awvalid;
assign o_wready = o_awready; // 写通道和地址通道同步
assign o_awready = (state == IDLE) && !i_arvalid;

always @(posedge i_sys_clk) begin
  if(!i_sys_rst_n) begin
    state <= IDLE;
    sram_data <= 0;
    awaddr <= 0;
    wdata <= 0;
    araddr <= 0;
    wstrb <= 0;
    bresp <= 0;
    count <= 0;
    rresp <= 0;
    rvalid <= 0;
    bvalid <= 0;
  end else begin
    case(state)
        IDLE: begin
            if(i_arvalid) begin
                araddr <= i_araddr;
                state <= READ;
                count <= count + 1;
                // if(count == DELAY-1) begin
                if(count == delay_count-1) begin
                    sram_data <= pmem_read(i_araddr, 4);
                    rvalid <= 1;
                    rresp <= 2'b00; // 认为每一次都会成功
                end
            end 
            else if(i_awvalid && i_wvalid) begin // 关键修改：同步检测双通道
                awaddr <= i_awaddr;
                wdata <= i_wdata;
                wstrb <= i_wstrb;
                state <= WRITE;
                count <= count + 1;
                // if(count == DELAY-1) begin
                if(count == delay_count-1) begin
                /* verilator lint_off WIDTHEXPAND */
                    pmem_write(i_awaddr, i_wstrb, i_wdata);
                /* verilator lint_on WIDTHEXPAND */
                    bvalid <= 1; // 触发B响应
                    bresp <= 2'b00; // 认为每一次都会成功
                    state <= RESP;
                end
            end
        end

        READ: begin
            // if(count == DELAY-1) begin
            if(count == delay_count-1) begin
                sram_data <= pmem_read(araddr, 4);
                rvalid <= 1;
                rresp <= 2'b00; // 认为每一次都会成功
            end
            // if(count >= DELAY && i_rready) begin // 握手完成
            if(count >= delay_count && i_rready) begin // 握手完成
                state <= IDLE;
                rvalid <= 0;
                count <= 0;
                // rresp <= 2'b00; // 认为每一次都会成功
            end else count <= count + 1;
            end

            WRITE: begin
            // if(count == DELAY-1) begin
            if(count == delay_count-1) begin
                /* verilator lint_off WIDTHEXPAND */
                pmem_write(awaddr, wstrb, wdata);
                /* verilator lint_on WIDTHEXPAND */
                bvalid <= 1; // 触发B响应
                bresp <= 2'b00; // 认为每一次都会成功
                state <= RESP;
            end
            // if(count >= DELAY) state <= RESP;
            if(count >= delay_count) state <= RESP;
            else count <= count + 1;
            end
            // if(count < DELAY) count <= count + 1;
            // end

        RESP: begin
            if(i_bready) begin // 等待响应握手
                bvalid <= 0;
                state <= IDLE;
                count <= 0;
            end
        end
    endcase
  end
end

reg [3:0] lsfr_data;
reg [11:0] delay_count;
always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        lsfr_data <= 4'b1111;
        delay_count <= 1;
    end
    else if (state == IDLE)begin
        lsfr_data <= {lsfr_data[2:0], lsfr_data[3] ^ lsfr_data[1]};
        if (i_arvalid || i_awvalid && i_wvalid) begin
            /* verilator lint_off WIDTHEXPAND */
            delay_count <= lsfr_data + DELAY;
            $strobe("delay_count = %d", delay_count);
            /* verilator lint_on WIDTHEXPAND */
        end
    end
    else begin
        lsfr_data <= {lsfr_data[2:0], lsfr_data[3] ^ lsfr_data[1]};
    end
end

endmodule
