module LSU(
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    input wire i_lbu_signal,
    input wire i_lhu_signal,
    input wire i_lb_signal,
    input wire i_lh_signal,
    input wire i_lw_signal,
    input wire i_sb_signal,
    input wire i_sh_signal,
    input wire i_sw_signal,
    input wire i_exu_valid,
    input wire i_wbu_ready,
    input wire i_idu_valid,
    input wire [31:0] i_src2,
    input wire [31:0] i_data,
    output wire o_load_signal,
    output reg [31:0] o_rdata,
    output wire o_lsu_valid,
    output wire o_lsu_ready
);

localparam IDLE = 2'b00;
localparam LOAD = 2'b01;
localparam LOAD_DONE = 2'b10;
localparam STORE = 2'b11;

reg [1:0] state;
reg [1:0] next_state;
reg [7:0] mem_op_type; // 锁存内存操作类型
reg [31:0] axi_araddr; // 锁存地址
reg [31:0] axi_awaddr; // 锁存地址
reg [31:0] axi_wdata; // 锁存数据
reg [3:0] axi_wstrb;
/* verilator lint_off UNUSEDSIGNAL */
reg write_wrong;
reg read_wrong;
/* verilator lint_on UNUSEDSIGNAL */

wire axi_arvalid;
// wire wen;
wire [31:0] axi_rdata;
wire load_signal;
wire store_signal;
// wire ram_valid;
wire axi_arready;
wire axi_awready;
wire axi_rvalid;
wire axi_rready;
wire axi_wvalid;
wire axi_wready;
wire axi_bvalid;
wire axi_bready;
wire axi_awvalid;
wire [1:0] axi_bresp;
wire [1:0] axi_rresp;

// assign o_rdata = rdata;
assign load_signal = i_lbu_signal | i_lhu_signal | i_lb_signal | i_lh_signal | i_lw_signal;
assign store_signal = i_sb_signal | i_sh_signal | i_sw_signal;
assign o_load_signal = load_signal;
assign o_lsu_ready = (state == IDLE);
assign o_lsu_valid = (state == LOAD_DONE) || (state == LOAD && axi_rvalid && i_wbu_ready);

assign axi_arvalid = (state == LOAD);
assign axi_awvalid = (state == STORE);
assign axi_wvalid = (state == STORE);
assign axi_rready = (state == LOAD) || (state == LOAD_DONE);
assign axi_bready = (state == STORE);

// 状态转移逻辑
always @(*) begin
    if (!i_sys_rst_n) begin
        next_state = IDLE;
    end
    else begin
        case (state)
            IDLE: begin
                if(i_exu_valid  && load_signal && axi_arready) begin
                    next_state = LOAD;
                end
                else if(i_exu_valid  && store_signal && axi_awready && axi_wready) begin
                    next_state = STORE;
                end
                else begin
                    next_state = IDLE;
                end
            end
            LOAD: begin
                if (axi_rvalid) begin
                    if (i_wbu_ready) begin
                        next_state = IDLE;
                    end
                   next_state = LOAD_DONE; 
                end
                else begin
                    next_state = LOAD;
                end
            end
            LOAD_DONE: begin
                if(i_wbu_ready) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = LOAD_DONE;
                end
            end
            STORE: begin
                if(axi_bvalid) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = STORE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
end

// 锁存指令信息和数据
always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        mem_op_type <= 8'b0;
        axi_araddr <= 32'b0;
        axi_awaddr <= 32'b0;
        axi_wdata <= 32'b0;
    end
    else if (state == IDLE && i_exu_valid ) begin
        
        axi_araddr <= i_data;
        axi_awaddr <= i_data;
        axi_wdata <= i_src2;
    end
    else if(state == IDLE && i_idu_valid) begin
        mem_op_type <= {
            i_lbu_signal, i_lhu_signal, i_lb_signal, i_lh_signal, i_lw_signal,
            i_sb_signal, i_sh_signal, i_sw_signal
        };
    end
end

// 输出逻辑
always @(*) begin
    if (!i_sys_rst_n) begin
        o_rdata = 32'b0;
    end
    else begin
        case (1'b1) 
            mem_op_type[7]: o_rdata = {24'b0, axi_rdata[7:0]};  // lbu
            mem_op_type[6]: o_rdata = {16'b0, axi_rdata[15:0]}; // lhu
            mem_op_type[5]: o_rdata = {{24{axi_rdata[7]}}, axi_rdata[7:0]}; // lb
            mem_op_type[4]: o_rdata = {{16{axi_rdata[15]}}, axi_rdata[15:0]}; // lh
            mem_op_type[3]: o_rdata = axi_rdata; // lw
            default: o_rdata = 32'b0;
        endcase
    end
end

always @(*) begin
    if (!i_sys_rst_n) begin
        axi_wstrb = 4'b0;
    end
    else begin
        case (1'b1) 
            mem_op_type[2]: axi_wstrb = 4'd1; // sb
            mem_op_type[1]: axi_wstrb = 4'd2; // sh
            mem_op_type[0]: axi_wstrb = 4'd4; // sw
            default: axi_wstrb = 4'b0;
        endcase
    end
end

// 状态更新逻辑
always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        write_wrong <= 0;
        read_wrong <= 0;
    end
    else begin
        write_wrong <= 0;
        read_wrong <= 0;
        if(axi_rvalid) begin
            read_wrong <= axi_rresp != 2'b00;
        end
        else if (axi_bvalid)begin
            write_wrong <= axi_bresp != 2'b00;
        end
    end
end


sram # (1)ram_u
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
    .i_awaddr(axi_awaddr), 
    .i_awvalid(axi_awvalid), // 看做写使能
    .o_awready(axi_awready),
    // W
    .i_wvalid(axi_wvalid), 
    .i_wstrb(axi_wstrb), 
    .i_wdata(axi_wdata), 
    .o_wready(axi_wready),
    // B
    .o_bresp(axi_bresp),
    .o_bvalid(axi_bvalid),
    .i_bready(axi_bready)
);

endmodule
