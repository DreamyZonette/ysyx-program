module IFU(
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    input wire [31:0] i_pc,
    input wire i_pc_valid,
    input wire i_idu_ready,
    output wire o_ifu_valid,
    output wire o_ifu_ready,
    output wire [31:0] o_instruction
);
// import "DPI-C" function int pmem_read(input int raddr, input int len);

localparam IDLE = 1'b0;
localparam WAIT_READY = 1'b1;

// reg [31:0] instruction;
reg state;
reg next_state;
wire axi_arvalid;
wire axi_arready;
wire [31:0] axi_rdata;
wire [31:0] axi_araddr;
wire axi_rready;
wire [1:0] axi_rresp;
wire axi_rvalid;

// 为实例化声明 未使用
wire axi_awready;
wire axi_bvalid;
wire [1:0] axi_bresp;
wire axi_wready;
wire read_wrong;

assign o_ifu_valid = (state == WAIT_READY) && axi_rvalid;
assign o_instruction = axi_rdata; 
assign o_ifu_ready = (state == IDLE) || 
                     (state == WAIT_READY && i_idu_ready && axi_rvalid); 
assign axi_arvalid = (state == IDLE) && i_pc_valid;
assign axi_rready = (state == WAIT_READY) && i_idu_ready;
assign axi_araddr = i_pc;
assign read_wrong = axi_rvalid ? axi_rresp != 2'b00 : 1'b0; // 读错误

// 状态机转移关系
always @(*) begin
    if(!i_sys_rst_n) begin
        next_state = IDLE;
    end else begin
        case (state)
            IDLE: begin
                // 只有没有待处理指令时才接受新请求
                if(i_pc_valid && axi_arready) begin
                // if(sram_valid) begin
                    next_state = WAIT_READY;
                end
                else begin
                    next_state = IDLE;
                end
            end
            WAIT_READY: begin
                if(i_idu_ready && axi_rvalid) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_READY;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
end



// 状态机状态更新
always @(posedge i_sys_clk) begin
    if(i_sys_rst_n == 1'b0) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// rom  #(1) // 延时周期
// rom_u (
//     .i_sys_clk(i_sys_clk),
//     .i_sys_rst_n(i_sys_rst_n),
//     .i_addr(i_pc), // address
//     .i_read_signal(read_signal), // read signal
//     .o_sram_data(sram_data),
//     .o_sram_valid(sram_valid)
// );

sram # (1)rom_u
(
    .i_sys_clk(i_sys_clk),
    .i_sys_rst_n(i_sys_rst_n),
    // AR
    .i_araddr(axi_araddr),
    .i_arvalid(axi_arvalid), // 看做读使能
    .o_arready(axi_arready),
    // R
    .o_rdata(axi_rdata),
    .o_rresp(axi_rresp),
    .o_rvalid(axi_rvalid),
    .i_rready(axi_rready),
    // AW
    .i_awaddr(32'b0), 
    .i_awvalid(1'b0), 
    .o_awready(axi_awready),
    // W
    .i_wvalid(1'b0), 
    .i_wstrb(4'b0), 
    .i_wdata(32'b0), 
    .o_wready(axi_wready),
    // B
    .o_bresp(axi_bresp),
    .o_bvalid(axi_bvalid),
    .i_bready(0)
);

// 最开始方案，直接从pmem中读出指令，然后赋值给instruction
// assign o_instruction = $unsigned(pmem_read(i_pc, 4)); 

endmodule
