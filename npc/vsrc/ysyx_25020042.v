
   module ysyx_25020042 (
        input             clock            ,
        input             reset            ,
        input             io_interrupt     ,
        `ifndef PLATFORM_NPC
        input             io_master_awready,
        output            io_master_awvalid,
        output  [31:0]    io_master_awaddr,
        output  [3:0]     io_master_awid   ,
        output  [7:0]     io_master_awlen  ,
        output  [2:0]     io_master_awsize ,
        output  [1:0]     io_master_awburst,
        input             io_master_wready ,
        output            io_master_wvalid ,
        output  [31:0]    io_master_wdata  ,
        output  [3:0]     io_master_wstrb  ,
        output            io_master_wlast  ,
        output            io_master_bready ,
        input             io_master_bvalid ,
        input   [1:0]     io_master_bresp  ,
        input   [3:0]     io_master_bid    ,
        input             io_master_arready,
        output            io_master_arvalid,
        output  [31:0]    io_master_araddr ,
        output  [3:0]     io_master_arid   ,
        output  [7:0]     io_master_arlen  ,
        output  [2:0]     io_master_arsize ,
        output  [1:0]     io_master_arburst,
        output            io_master_rready ,
        input             io_master_rvalid ,
        input   [1:0]     io_master_rresp  ,
        input   [31:0]    io_master_rdata  ,
        input             io_master_rlast  ,
        input   [3:0]     io_master_rid    ,
        `endif
        /* verilator lint_off UNDRIVEN */
        /* verilator lint_off UNUSEDSIGNAL */
        output            io_slave_awready ,
        input             io_slave_awvalid ,
        input   [31:0]    io_slave_awaddr  ,
        input   [3:0]     io_slave_awid    ,
        input   [7:0]     io_slave_awlen   ,
        input   [2:0]     io_slave_awsize  ,
        input   [1:0]     io_slave_awburst ,
        output            io_slave_wready  ,
        input             io_slave_wvalid  ,
        input   [31:0]    io_slave_wdata   ,
        input   [3:0]     io_slave_wstrb   ,
        input             io_slave_wlast   ,
        input             io_slave_bready  ,
        output            io_slave_bvalid  ,
        output  [1:0]     io_slave_bresp   ,
        output  [3:0]     io_slave_bid     ,
        output            io_slave_arready ,
        input             io_slave_arvalid ,
        input   [31:0]    io_slave_araddr  ,
        input   [3:0]     io_slave_arid    ,
        input   [7:0]     io_slave_arlen   ,
        input   [2:0]     io_slave_arsize  ,
        input   [1:0]     io_slave_arburst ,
        input             io_slave_rready  ,
        output            io_slave_rvalid  ,
        output  [1:0]     io_slave_rresp   ,
        output  [31:0]    io_slave_rdata   ,
        output            io_slave_rlast   ,
        output  [3:0]     io_slave_rid     
    /* verilator lint_on UNDRIVEN */
    /* verilator lint_on UNUSEDSIGNAL */
    );
`ifdef VERILATOR
    import "DPI-C" function void dpi_ebreak();

    always @(posedge clock) begin
            if (ebreak_signal) begin
                dpi_ebreak();
            end
    end
`endif
//------------------------------------------
// 模块间握手信号
//------------------------------------------
    wire pc_valid;
    wire ifu_valid;
    wire ifu_ready;
    wire idu_valid;
    wire idu_ready;
    wire exu_valid;
    wire exu_ready;
    wire lsu_valid;
    wire lsu_ready;
    wire wbu_valid;
    wire wbu_ready;
//------------------------------------------
// 指令信号
//------------------------------------------
    wire [7:0] idu_inst;
    wire fencei_signal = idu_inst == 8'b10100001;
    wire ecall_signal  = idu_inst == 8'b10000011;
    wire ebreak_signal = idu_inst == 8'b10000101;
//------------------------------------------
// 数据通路信号
//------------------------------------------
    wire [31:0] wdata;
    wire [31:0] imm;
    wire [31:0] src1;
    wire [31:0] src2;
    wire [31:0] offset;
    wire [5:0] shamt;
    wire [31:0] jump_pc;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [3:0] wmask;
    wire [31:0] exu_data;
    wire [31:0] lsu_data;
    wire o_B_jump_signal;
    wire lsu_busy;
    wire [11:0] csr_addr;
    wire [31:0] csr_data;
    wire [31:0] mstatus;
    wire [31:0] mtvec;
    wire [31:0] mepc;
    wire [31:0] mcause;
    wire [31:0] mcause_wdata;
    wire [31:0] mstatus_wdata = 32'h0;
    wire [31:0] mtvec_wdata = 32'h0;
    wire [31:0] mepc_wdata;
    wire [31:0] csr_wdata;
    wire [4:0]  rs1;
    wire [4:0]  rs2;
    wire [4:0]  rd;
    wire        fault;
    wire        jump_valid;
    wire [31:0] ifu_to_idu_pc_data;
    wire [31:0] idu_to_exu_pc_data;
    wire [31:0] exu_to_lsu_pc_data;
    wire [31:0] lsu_to_wbu_pc_data;
    wire [4:0]  exu_to_lsu_rd;
    wire [4:0]  lsu_to_wbu_rd;
    wire [4:0]  wbu_rd;
    wire [31:0] exu_to_lsu_data;
    wire [31:0] lsu_to_exu_data;
    wire [31:0] exu_to_lsu_csr_data;
    wire [31:0] lsu_to_wbu_csr_data;
    wire [7:0] exu_to_lsu_inst;
    wire [7:0] lsu_to_wbu_inst;
    wire [31:0] exu_to_lsu_src2;
    wire [31:0] wbu_to_exu_data;
    wire [31:0] exu_to_wbu_data;
    wire [11:0] exu_to_lsu_csr_addr;
    wire [11:0] lsu_to_wbu_csr_addr;
    wire [11:0] wbu_csr_addr;
    wire    pc_update;
    wire    icache_busy;
     `ifdef VERILATOR
    wire [31:0] idu_to_exu_instrction_data;
    wire [31:0] exu_to_lsu_instrction_data;
    wire [31:0] lsu_to_wbu_instrction_data;
    `endif
//------------------------------------------
// AXI 总线
//------------------------------------------
    
    wire [31:0] io_ifu_araddr;
    wire        io_ifu_arvalid;
    wire        io_ifu_arready;
    wire [7:0]  io_ifu_arlen;
    wire [3:0]  io_ifu_arid;
    wire [1:0]  io_ifu_arburst;
    wire [2:0]  io_ifu_arsize;
    wire        io_ifu_rready;
    wire        io_ifu_rvalid;
    wire [31:0] io_ifu_rdata;
    wire [1:0]  io_ifu_rresp;
    wire        io_ifu_rlast;
    wire [3:0]  io_ifu_rid;

    // axi 握手信号
    wire [31:0] io_lsu_araddr;
    wire        io_lsu_arvalid;
    wire        io_lsu_arready;
    wire [7:0]  io_lsu_arlen;
    wire [3:0]  io_lsu_arid;
    wire [1:0]  io_lsu_arburst;
    wire [2:0]  io_lsu_arsize;

    wire [31:0] io_lsu_rdata;
    wire        io_lsu_rvalid;
    wire [1:0]  io_lsu_rresp;
    wire        io_lsu_rready;
    wire        io_lsu_rlast;
    wire [3:0]  io_lsu_rid;

    wire [31:0] io_lsu_awaddr;
    wire        io_lsu_awvalid;
    wire        io_lsu_awready;
    wire [3:0]  io_lsu_awid;
    wire [7:0]  io_lsu_awlen;
    wire [2:0]  io_lsu_awsize;
    wire [1:0]  io_lsu_awburst;

    wire [31:0] io_lsu_wdata;
    wire [3:0]  io_lsu_wstrb;
    wire        io_lsu_wvalid;
    wire        io_lsu_wready;
    wire        io_lsu_wlast;

    wire        io_lsu_bvalid;
    wire        io_lsu_bready;
    wire [1:0]  io_lsu_bresp;
    wire [3:0]  io_lsu_bid;

    wire            io_clint_awready;
    wire            io_clint_awvalid;
    wire  [31:0]    io_clint_awaddr ;
    wire  [3:0]     io_clint_awid   ;
    wire  [7:0]     io_clint_awlen  ;
    wire  [2:0]     io_clint_awsize ;
    wire  [1:0]     io_clint_awburst;
    wire            io_clint_wready ;
    wire            io_clint_wvalid ;
    wire  [31:0]    io_clint_wdata  ;
    wire  [3:0]     io_clint_wstrb  ;
    wire            io_clint_wlast  ;
    wire            io_clint_bready ;
    wire            io_clint_bvalid ;
    wire  [1:0]     io_clint_bresp  ;
    wire  [3:0]     io_clint_bid    ;
    wire            io_clint_arready;
    wire            io_clint_arvalid;
    wire  [31:0]    io_clint_araddr ;
    wire  [3:0]     io_clint_arid   ;
    wire  [7:0]     io_clint_arlen  ;
    wire  [2:0]     io_clint_arsize ;
    wire  [1:0]     io_clint_arburst;
    wire            io_clint_rready ;
    wire            io_clint_rvalid ;
    wire  [1:0]     io_clint_rresp  ;
    wire  [31:0]    io_clint_rdata  ;
    wire            io_clint_rlast  ;
    wire  [3:0]     io_clint_rid    ;
    `ifdef VERILATOR
    `ifdef PLATFORM_NPC
    wire            io_master_awready;
    wire            io_master_awvalid;
    wire  [31:0]    io_master_awaddr ;
    wire  [3:0]     io_master_awid   ;
    wire  [7:0]     io_master_awlen  ;
    wire  [2:0]     io_master_awsize ;
    wire  [1:0]     io_master_awburst;
    wire            io_master_wready ;
    wire            io_master_wvalid ;
    wire  [31:0]    io_master_wdata  ;
    wire  [3:0]     io_master_wstrb  ;
    wire            io_master_wlast  ;
    wire            io_master_bready ;
    wire            io_master_bvalid ;
    wire  [1:0]     io_master_bresp  ;
    wire  [3:0]     io_master_bid    ;
    wire            io_master_arready;
    wire            io_master_arvalid;
    wire  [31:0]    io_master_araddr ;
    wire  [3:0]     io_master_arid   ;
    wire  [7:0]     io_master_arlen  ;
    wire  [2:0]     io_master_arsize ;
    wire  [1:0]     io_master_arburst;
    wire            io_master_rready ;
    wire            io_master_rvalid ;
    wire  [1:0]     io_master_rresp  ;
    wire  [31:0]    io_master_rdata  ;
    wire            io_master_rlast  ;
    wire  [3:0]     io_master_rid    ;
    `endif
    `endif
//------------------------------------------
// 性能计数器
//------------------------------------------    
    `ifdef VERILATOR
    wire [63:0] ifu_performance_counter;
    wire [63:0] exu_performance_counter;
    wire [63:0] lsu_performance_counter;
    wire [63:0] csr_performance_counter;
        `ifdef ICACHE_ON
    wire [63:0]      icache_hit_count;
    `endif
    `endif

//------------------------------------------
// 异常信号
//------------------------------------------
assign fault = (io_master_rresp == 2'b00) ? 1'b0 : 1'b1;

//------------------------------------------
// axi  仲裁器模块实例化
//------------------------------------------
axi_arbiter axi_arbiter_u (
    .clock(clock),
    .reset(reset),

    .io_lsu_araddr(io_lsu_araddr),
    .io_lsu_arvalid(io_lsu_arvalid),
    .io_lsu_arready(io_lsu_arready),
    .io_lsu_arid(io_lsu_arid),
    .io_lsu_arlen(io_lsu_arlen),
    .io_lsu_arsize(io_lsu_arsize),
    .io_lsu_arburst(io_lsu_arburst),

    .io_lsu_rdata(io_lsu_rdata),
    .io_lsu_rvalid(io_lsu_rvalid),
    .io_lsu_rresp(io_lsu_rresp),
    .io_lsu_rready(io_lsu_rready),
    .io_lsu_rid(io_lsu_rid),
    .io_lsu_rlast(io_lsu_rlast),
    .io_lsu_awaddr(io_lsu_awaddr),
    .io_lsu_awvalid(io_lsu_awvalid),
    .io_lsu_awready(io_lsu_awready),
    .io_lsu_awid(io_lsu_awid),
    .io_lsu_awlen(io_lsu_awlen),
    .io_lsu_awsize(io_lsu_awsize),
    .io_lsu_awburst(io_lsu_awburst),   

    .io_lsu_wdata(io_lsu_wdata),
    .io_lsu_wstrb(io_lsu_wstrb),
    .io_lsu_wvalid(io_lsu_wvalid),
    .io_lsu_wready(io_lsu_wready),
    .io_lsu_wlast(io_lsu_wlast),

    .io_lsu_bvalid(io_lsu_bvalid),
    .io_lsu_bready(io_lsu_bready),
    .io_lsu_bresp(io_lsu_bresp),
    .io_lsu_bid(io_lsu_bid),

    .io_ifu_araddr(io_ifu_araddr),
    .io_ifu_arvalid(io_ifu_arvalid),
    .io_ifu_arready(io_ifu_arready),
    .io_ifu_arid(io_ifu_arid),
    .io_ifu_arlen(io_ifu_arlen),
    .io_ifu_arsize(io_ifu_arsize),
    .io_ifu_arburst(io_ifu_arburst),

    .io_ifu_rdata(io_ifu_rdata),
    .io_ifu_rvalid(io_ifu_rvalid),
    .io_ifu_rresp(io_ifu_rresp),
    .io_ifu_rready(io_ifu_rready),
    .io_ifu_rid(io_ifu_rid),
    .io_ifu_rlast(io_ifu_rlast),

    .io_araddr(io_master_araddr),
    .io_arvalid(io_master_arvalid),
    .io_arready(io_master_arready),
    .io_arid(io_master_arid),
    .io_arlen(io_master_arlen),
    .io_arsize(io_master_arsize),
    .io_arburst(io_master_arburst),
    

    .io_rdata(io_master_rdata),
    .io_rvalid(io_master_rvalid),
    .io_rresp(io_master_rresp),
    .io_rready(io_master_rready),
    .io_rid(io_master_rid),
    .io_rlast(io_master_rlast),

    .io_awaddr(io_master_awaddr),
    .io_awvalid(io_master_awvalid),
    .io_awready(io_master_awready),
    .io_awid(io_master_awid),
    .io_awlen(io_master_awlen),
    .io_awsize(io_master_awsize),
    .io_awburst(io_master_awburst), 
    

    .io_wdata(io_master_wdata),
    .io_wstrb(io_master_wstrb),
    .io_wvalid(io_master_wvalid),
    .io_wready(io_master_wready),
    .io_wlast(io_master_wlast),

    .io_bvalid(io_master_bvalid),
    .io_bready(io_master_bready),
    .io_bresp(io_master_bresp),
    .io_bid(io_master_bid),

    .io_clint_araddr(io_clint_araddr),
    .io_clint_arvalid(io_clint_arvalid),
    .io_clint_arready(io_clint_arready),
    .io_clint_arid(io_clint_arid),
    .io_clint_arlen(io_clint_arlen),
    .io_clint_arsize(io_clint_arsize),
    .io_clint_arburst(io_clint_arburst),
    

    .io_clint_rdata(io_clint_rdata),
    .io_clint_rvalid(io_clint_rvalid),
    .io_clint_rresp(io_clint_rresp),
    .io_clint_rready(io_clint_rready),
    .io_clint_rid(io_clint_rid),
    .io_clint_rlast(io_clint_rlast),

    .io_clint_awaddr(io_clint_awaddr),
    .io_clint_awvalid(io_clint_awvalid),
    .io_clint_awready(io_clint_awready),
    .io_clint_awid(io_clint_awid),
    .io_clint_awlen(io_clint_awlen),
    .io_clint_awsize(io_clint_awsize),
    .io_clint_awburst(io_clint_awburst), 


    .io_clint_wdata(io_clint_wdata),
    .io_clint_wstrb(io_clint_wstrb),
    .io_clint_wvalid(io_clint_wvalid),
    .io_clint_wready(io_clint_wready),
    .io_clint_wlast(io_clint_wlast),

    .io_clint_bvalid(io_clint_bvalid),
    .io_clint_bready(io_clint_bready),
    .io_clint_bresp(io_clint_bresp),
    .io_clint_bid(io_clint_bid)
);

//------------------------------------------
// ipc_counter实例化
//------------------------------------------
`ifdef VERILATOR
ipc_counter ipc_counter_u(
    .clk(clock),
    .rst(reset),
    // .pc(pc),
    .wbu_valid(wbu_valid),
    .ebreak(ebreak_signal),
    .ifu_performance_counter(ifu_performance_counter),
    .lsu_performance_counter(lsu_performance_counter),
    .exu_performance_counter(exu_performance_counter),
    .csr_performance_counter(csr_performance_counter),
    .icache_hit_counter(icache_hit_count)
);
`endif

//------------------------------------------
// clint实例化
//------------------------------------------
`ifdef VERILATOR
`ifdef PLATFORM_NPC
ysyx_25020042_mem ysyx_25020042_mem_u (
    .clock(clock),
    // axi 握手信号
    .slave_araddr(io_master_araddr),
    .slave_arvalid(io_master_arvalid),
    .slave_arready(io_master_arready),
    .slave_arid(io_master_arid),
    .slave_arlen(io_master_arlen),
    .slave_arsize(io_master_arsize),
    .slave_arburst(io_master_arburst),

    .slave_rdata(io_master_rdata),
    .slave_rvalid(io_master_rvalid),
    .slave_rresp(io_master_rresp),
    .slave_rready(io_master_rready),
    .slave_rlast(io_master_rlast),
    .slave_rid(io_master_rid),

    .slave_awaddr(io_master_awaddr),
    .slave_awvalid(io_master_awvalid),
    .slave_awready(io_master_awready),
    .slave_awid(io_master_awid),
    .slave_awlen(io_master_awlen),
    .slave_awsize(io_master_awsize),
    .slave_awburst(io_master_awburst),

    .slave_wdata(io_master_wdata),
    .slave_wstrb(io_master_wstrb),
    .slave_wvalid(io_master_wvalid),
    .slave_wready(io_master_wready),
    .slave_wlast(io_master_wlast),

    .slave_bvalid(io_master_bvalid),
    .slave_bready(io_master_bready),
    .slave_bresp(io_master_bresp),
    .slave_bid(io_master_bid)
);
`endif
`endif

//------------------------------------------
// clint实例化
//------------------------------------------
clint clint_u (
    .clock(clock),
    .reset(reset),
    // axi 握手信号
    .slave_araddr(io_clint_araddr),
    .slave_arvalid(io_clint_arvalid),
    .slave_arready(io_clint_arready),
    .slave_arid(io_clint_arid),
    .slave_arlen(io_clint_arlen),
    .slave_arsize(io_clint_arsize),
    .slave_arburst(io_clint_arburst),

    .slave_rdata(io_clint_rdata),
    .slave_rvalid(io_clint_rvalid),
    .slave_rresp(io_clint_rresp),
    .slave_rready(io_clint_rready),
    .slave_rlast(io_clint_rlast),
    .slave_rid(io_clint_rid),

    .slave_awaddr(io_clint_awaddr),
    .slave_awvalid(io_clint_awvalid),
    .slave_awready(io_clint_awready),
    .slave_awid(io_clint_awid),
    .slave_awlen(io_clint_awlen),
    .slave_awsize(io_clint_awsize),
    .slave_awburst(io_clint_awburst),

    .slave_wdata(io_clint_wdata),
    .slave_wstrb(io_clint_wstrb),
    .slave_wvalid(io_clint_wvalid),
    .slave_wready(io_clint_wready),
    .slave_wlast(io_clint_wlast),

    .slave_bvalid(io_clint_bvalid),
    .slave_bready(io_clint_bready),
    .slave_bresp(io_clint_bresp),
    .slave_bid(io_clint_bid)
);
//------------------------------------------
// PC实例化
//------------------------------------------
ysyx_25020042_PC PC_u(
    .clock(clock),
    .reset(reset),
    .ifu_ready(ifu_ready),
    // .pc_update(pc_update),
    .ifu_handsake(ifu_valid & idu_ready),
    .icache_busy(icache_busy),
    .fault(fault),
    .pc_valid(pc_valid),
    .i_jump_pc(jump_pc),
    .i_jump_valid(jump_valid),
    .o_pc(pc)
);
//------------------------------------------
// IFU实例化
//------------------------------------------


ysyx_25020042_IFU IFU_u (
    .clock(clock),
    .reset(reset),
    .pc_valid(pc_valid),
    .idu_ready(idu_ready),
    .ifu_valid(ifu_valid),
    .ifu_ready(ifu_ready),
    // .pc_update(pc_update),
    .icache_busy(icache_busy),

    .i_jump_valid(jump_valid),
    .i_pc(pc),
    .fencei_signal(fencei_signal),
    .o_instruction(instruction),
    .o_pc_data(ifu_to_idu_pc_data),

    `ifdef VERILATOR
    .o_performance_counter(ifu_performance_counter),
    `ifdef ICACHE_ON
    .o_icache_hit_count(icache_hit_count),
    `endif
    `endif

    .ifu_araddr(io_ifu_araddr),
    .ifu_arvalid(io_ifu_arvalid),
    .ifu_arready(io_ifu_arready),
    .ifu_arlen(io_ifu_arlen),
    .ifu_arid(io_ifu_arid),
    .ifu_arburst(io_ifu_arburst),
    .ifu_arsize(io_ifu_arsize),
    .ifu_rdata(io_ifu_rdata),
    .ifu_rvalid(io_ifu_rvalid),
    .ifu_rready(io_ifu_rready),
    .ifu_rresp(io_ifu_rresp),
    .ifu_rlast(io_ifu_rlast),
    .ifu_rid(io_ifu_rid)

);

//------------------------------------------
// IDU实例化
//------------------------------------------
ysyx_25020042_IDU IDU_u (
    .clock(clock),
    .reset(reset),
    .ifu_valid(ifu_valid),
    .exu_ready(exu_ready),
    .idu_ready(idu_ready),
    .idu_valid(idu_valid),
    `ifdef VERILATOR
    .csr_perfomance_counter(csr_performance_counter),
    .o_instruction_data(idu_to_exu_instrction_data),
    `endif

    .i_jump_valid(jump_valid),
    .i_inst(instruction),
    .i_pc_data(ifu_to_idu_pc_data),
    .i_prev_rd_0(exu_to_lsu_rd),
    .i_prev_rd_1(lsu_to_wbu_rd),
    .i_prev_rd_2(wbu_rd),
    .o_instruction_out(idu_inst),
    .o_imm(imm),
    .o_pc_data(idu_to_exu_pc_data),
    .o_csr_addr(csr_addr),
    .o_shamt(shamt),
    .o_rd(rd),
    .o_rs1(rs1),
    .o_rs2(rs2)
    );
//------------------------------------------
// EXU实例化
//------------------------------------------
ysyx_25020042_EXU EXU_u (
    .clock(clock),
    .reset(reset),
    .idu_valid(idu_valid),
    .lsu_ready(lsu_ready),
    .exu_valid(exu_valid),
    .exu_ready(exu_ready),

    `ifdef VERILATOR
    .performance_counter(exu_performance_counter),
    .i_instruction_data(idu_to_exu_instrction_data),
    .o_instruction_data(exu_to_lsu_instrction_data),
    `endif

    .i_inst(idu_inst),
    .i_src1(src1),
    .i_src2(src2),
    .i_imm(imm),
    .i_pc_data(idu_to_exu_pc_data),
    .i_shamt(shamt),
    .i_csr_data(csr_data),
    .i_csr_addr(csr_addr),
    .i_mepc_rdata(mepc),
    .i_mtvec_rdata(mtvec),
    .i_rd(rd),
    .o_csr_data(exu_to_lsu_csr_data),
    .o_csr_addr(exu_to_lsu_csr_addr),
    .o_idu_inst(exu_to_lsu_inst),
    .o_pc_data(exu_to_lsu_pc_data),
    .o_src2(exu_to_lsu_src2),
    .o_rd(exu_to_lsu_rd),
    .jump_pc(jump_pc),
    .jump_valid(jump_valid),
    .o_data(exu_data)
    );

//------------------------------------------
// LSU实例化
//------------------------------------------
ysyx_25020042_LSU LSU_u (
    .clock(clock),
    .reset(reset),
    .exu_valid(exu_valid),
    .wbu_ready(wbu_ready),
    .lsu_valid(lsu_valid),
    .lsu_ready(lsu_ready),

    .i_inst(exu_to_lsu_inst),
    .i_src2(exu_to_lsu_src2),
    .i_data(exu_data),
    .i_pc_data(exu_to_lsu_pc_data),
    .i_csr_data(exu_to_lsu_csr_data),
    .i_csr_addr(exu_to_lsu_csr_addr),
    .i_rd(exu_to_lsu_rd),

    .o_inst(lsu_to_wbu_inst),
    .o_data(lsu_data),
    .o_pc_data(lsu_to_wbu_pc_data),
    .o_csr_data(lsu_to_wbu_csr_data),
    .o_csr_addr(lsu_to_wbu_csr_addr),
    .o_rd(lsu_to_wbu_rd),

    `ifdef VERILATOR
    .performance_counter(lsu_performance_counter),
    .i_instruction_data(exu_to_lsu_instrction_data),
    .o_instruction_data(lsu_to_wbu_instrction_data),
    `endif

    // axi 握手信号
    .lsu_araddr(io_lsu_araddr),
    .lsu_arvalid(io_lsu_arvalid),
    .lsu_arready(io_lsu_arready),
    .lsu_arlen(io_lsu_arlen),
    .lsu_arid(io_lsu_arid),
    .lsu_arburst(io_lsu_arburst),
    .lsu_arsize(io_lsu_arsize),

    .lsu_rdata(io_lsu_rdata),
    .lsu_rvalid(io_lsu_rvalid),
    .lsu_rresp(io_lsu_rresp),
    .lsu_rready(io_lsu_rready),
    .lsu_rlast(io_lsu_rlast),
    .lsu_rid(io_lsu_rid),

    .lsu_awaddr(io_lsu_awaddr),
    .lsu_awvalid(io_lsu_awvalid),
    .lsu_awready(io_lsu_awready),
    .lsu_awlen(io_lsu_awlen),
    .lsu_awid(io_lsu_awid),
    .lsu_awburst(io_lsu_awburst),
    .lsu_awsize(io_lsu_awsize),

    .lsu_wdata(io_lsu_wdata),
    .lsu_wstrb(io_lsu_wstrb),
    .lsu_wvalid(io_lsu_wvalid),
    .lsu_wready(io_lsu_wready),
    .lsu_wlast(io_lsu_wlast),

    .lsu_bvalid(io_lsu_bvalid),
    .lsu_bready(io_lsu_bready),
    .lsu_bresp(io_lsu_bresp),
    .lsu_bid(io_lsu_bid)
);

//------------------------------------------
// WBU实例化
//------------------------------------------
ysyx_25020042_WBU WBU_u (
    .clock(clock),
    .reset(reset),
    .lsu_valid(lsu_valid),
    .wbu_ready(wbu_ready),
    .wbu_valid(wbu_valid),

    `ifdef VERILATOR
    .i_instruction_data(lsu_to_wbu_instrction_data),
    `endif

    .i_data(lsu_data),
    .i_pc_data(lsu_to_wbu_pc_data),
    .i_inst(lsu_to_wbu_inst),
    .i_rd(lsu_to_wbu_rd),
    .i_csr_rdata(lsu_to_wbu_csr_data),
    .i_csr_addr(lsu_to_wbu_csr_addr),
    .o_rd(wbu_rd),
    .csr_wdata(csr_wdata),
    .csr_addr(wbu_csr_addr),
    .reg_wdata(wdata),
    .o_mepc_wdata(mepc_wdata),
    .o_mcause_wdata(mcause_wdata)
    );

`ifdef VERILATOR
    reg [31:0] wbu_next_pc;
    always @(posedge clock) begin
        if (reset) begin
            wbu_next_pc <= 32'h80000000;
        end 
        else if (wbu_valid) begin
            if (lsu_to_wbu_pc_data != exu_to_lsu_pc_data) begin
                wbu_next_pc <= exu_to_lsu_pc_data;
            end
            else if (exu_to_lsu_pc_data != idu_to_exu_pc_data) begin
                wbu_next_pc <= idu_to_exu_pc_data;
            end
            else if (idu_to_exu_pc_data != ifu_to_idu_pc_data) begin
                wbu_next_pc <= ifu_to_idu_pc_data;
            end
        end
    end
    `endif


//------------------------------------------
// CSR实例化
//------------------------------------------
ysyx_25020042_csr csr_u (
    .clock(clock),
    .reset(reset),
    .i_ecall_signal(ecall_signal),
    .i_csr_wdata(csr_wdata),
    .i_csr_addr(csr_addr),
    .i_wbu_csr_addr(wbu_csr_addr),
    .i_mstatus_wdata(mstatus_wdata),
    .i_mcause_wdata(mcause_wdata),
    .i_mtvec_wdata(mtvec_wdata),
    .i_mepc_wdata(mepc_wdata),
    .wbu_valid(wbu_valid),
    .o_mtvec(mtvec),
    .o_mepc(mepc),
    .o_mstatus(),
    .o_mcause(),
    .o_csr_rdata(csr_data)
);
//------------------------------------------
// GPR实例化
//------------------------------------------
ysyx_25020042_gpr gpr_u(
    .clock(clock),
    .reset(reset), 
    .i_rs1(rs1),
    .i_rs2(rs2),
    .i_rd(wbu_rd),
    .i_data(wdata),
    .wbu_valid(wbu_valid),
    .o_src1(src1),
    .o_src2(src2)
);

    endmodule
