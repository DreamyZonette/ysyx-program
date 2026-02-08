
   module ysyx_25020042 (
        input             clock            ,
        input             reset            ,
        input             io_interrupt     ,
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
            if (ebreak_signal == 1'b1) begin
                dpi_ebreak();
            end
    end
`endif
//------------------------------------------
// 模块间握手信号
//------------------------------------------
    wire wbu_valid;
    wire pc_valid;
    wire lsu_ready;
    wire wbu_ready;
    wire ifu_valid;
    wire lsu_valid;
//------------------------------------------
// 指令信号
//------------------------------------------
    wire addi_signal;
    wire andi_signal;
    wire slti_signal;
    wire xori_signal;
    wire ori_signal;
    wire ebreak_signal;
    wire jalr_signal;
    wire lbu_signal;
    wire lw_signal;
    wire auipc_signal;
    wire lui_signal;
    wire lb_signal;
    wire lh_signal;
    wire lhu_signal;
    wire srai_signal;
    wire slli_signal;
    wire sb_signal;
    wire sltiu_signal;
    wire srli_signal;
    wire sll_signal;
    wire jal_signal;
    wire sw_signal;
    wire add_signal;
    wire and_signal;
    wire or_signal;
    wire xor_signal;
    wire sub_signal;
    wire slt_signal;
    wire sltu_signal;
    wire sra_signal;
    wire srl_signal;
    wire beq_signal;
    wire bne_signal;
    wire bge_signal;
    wire bgeu_signal;
    wire blt_signal;
    wire bltu_signal;
    wire sh_signal;
    wire csrrs_signal;
    wire csrrw_signal;
    wire ecall_signal;
    wire mret_signal;
    /* verilator lint_off UNUSEDSIGNAL */
    wire unknown_signal;
    /* verilator lint_on UNUSEDSIGNAL */
//------------------------------------------
// 数据通路信号
//------------------------------------------
    wire [31:0] wdata;
    wire [31:0] imm;
    wire [31:0] src1;
    wire [31:0] src2;
    wire [31:0] offset;
    wire [5:0] shamt;
    wire [31:0] next_pc;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [3:0] wmask;
    wire [31:0] exu_data;
    wire [31:0] rdata;
    wire o_B_jump_signal;
    wire lsu_busy;
    wire [11:0] csr_addr;
    wire [31:0] csr_data;
    wire [31:0] mstatus;
    wire [31:0] mtvec;
    wire [31:0] mepc;
    wire [31:0] mcause;
    wire [31:0] mcause_wdata;
    wire [31:0] mstatus_wdata;
    wire [31:0] mtvec_wdata;
    wire [31:0] mepc_wdata;
    wire [31:0] csr_wdata;
    wire [4:0]  rs1;
    wire [4:0]  rs2;
    wire [4:0]  rd;
    wire        fault;
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
//------------------------------------------
// 性能计数器
//------------------------------------------    
        `ifdef VERILATOR
    wire [63:0] ifu_performance_counter;
    wire [63:0] exu_performance_counter;
    wire [63:0] lsu_performance_counter;
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
    .pc(pc),
    .nepc(next_pc),
    .ebreak(ebreak_signal),
    .ifu_performance_counter(ifu_performance_counter),
    .lsu_performance_counter(lsu_performance_counter),
    .exu_performance_counter(exu_performance_counter)
);
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
    .i_next_pc(next_pc),
    .wbu_valid(wbu_valid),
    .fault(fault),
    .pc_valid(pc_valid),
    .o_pc(pc)
);
//------------------------------------------
// IFU实例化
//------------------------------------------


ysyx_25020042_IFU IFU_u (
    .clock(clock),
    .reset(reset),
    .i_pc(pc),
    .pc_valid(pc_valid),
    .lsu_ready(lsu_ready),
    .wbu_ready(wbu_ready),
    .ifu_valid(ifu_valid),
    .o_instruction(instruction),
    `ifdef VERILATOR
    .o_performance_counter(ifu_performance_counter),
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
    .i_inst(instruction),
    .o_imm(imm),
    .o_offset(offset),
    .o_shamt(shamt),
    .o_wmask(wmask),
    .o_csr_addr(csr_addr),
    .o_addi_signal(addi_signal),
    .o_andi_signal(andi_signal),
    .o_slti_signal(slti_signal),
    .o_xori_signal(xori_signal),
    .o_ori_signal(ori_signal),
    .o_ebreak_signal(ebreak_signal),
    .o_jalr_signal(jalr_signal),
    .o_lbu_signal(lbu_signal),
    .o_lw_signal(lw_signal),
    .o_auipc_signal(auipc_signal),
    .o_lui_signal(lui_signal),
    .o_lb_signal(lb_signal),
    .o_lh_signal(lh_signal),
    .o_lhu_signal(lhu_signal),
    .o_srai_signal(srai_signal),
    .o_slli_signal(slli_signal),
    .o_sb_signal(sb_signal),
    .o_sltiu_signal(sltiu_signal),
    .o_srli_signal(srli_signal),
    .o_sll_signal(sll_signal),
    .o_jal_signal(jal_signal),
    .o_sw_signal(sw_signal),
    .o_add_signal(add_signal),
    .o_and_signal(and_signal),
    .o_or_signal(or_signal),
    .o_xor_signal(xor_signal),
    .o_sub_signal(sub_signal),
    .o_slt_signal(slt_signal),
    .o_sltu_signal(sltu_signal),
    .o_sra_signal(sra_signal),
    .o_srl_signal(srl_signal),
    .o_beq_signal(beq_signal),
    .o_bne_signal(bne_signal),
    .o_bge_signal(bge_signal),
    .o_bgeu_signal(bgeu_signal),
    .o_blt_signal(blt_signal),
    .o_bltu_signal(bltu_signal),
    .o_sh_signal(sh_signal),
    .o_csrrs_signal(csrrs_signal),
    .o_csrrw_signal(csrrw_signal),
    .o_ecall_signal(ecall_signal),
    .o_mret_signal(mret_signal),
    .o_unknown_signal(unknown_signal),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd)
    );
//------------------------------------------
// EXU实例化
//------------------------------------------
ysyx_25020042_EXU EXU_u (
    .clock(clock),
    .reset(reset),
    `ifdef VERILATOR
    .ifu_valid(ifu_valid),
    .slave_ready(wbu_ready | lsu_ready),
    .performance_counter(exu_performance_counter),
    `endif
    .i_src1(src1),
    .i_src2(src2),
    .i_imm(imm),
    .i_offset(offset),
    .i_pc_data(pc),
    .i_shamt(shamt),
    .i_csr_data(csr_data),
    .i_addi_signal(addi_signal),
    .i_jalr_signal(jalr_signal),
    .i_lb_signal(lb_signal),
    .i_lh_signal(lh_signal),
    .i_lw_signal(lw_signal),
    .i_lbu_signal(lbu_signal),
    .i_lhu_signal(lhu_signal),
    .i_xori_signal(xori_signal),
    .i_ori_signal(ori_signal),
    .i_andi_signal(andi_signal),
    .i_slli_signal(slli_signal),
    .i_srli_signal(srli_signal),
    .i_srai_signal(srai_signal),
    .i_slti_signal(slti_signal),
    .i_sltiu_signal(sltiu_signal),
    .i_beq_signal(beq_signal),
    .i_bne_signal(bne_signal),
    .i_blt_signal(blt_signal),
    .i_bge_signal(bge_signal),
    .i_bltu_signal(bltu_signal),
    .i_bgeu_signal(bgeu_signal),
    .i_jal_signal(jal_signal),
    .i_sw_signal(sw_signal),
    .i_sh_signal(sh_signal),
    .i_sb_signal(sb_signal),
    .i_and_signal(and_signal),
    .i_or_signal(or_signal),
    .i_xor_signal(xor_signal),
    .i_srl_signal(srl_signal),
    .i_sra_signal(sra_signal),
    .i_auipc_signal(auipc_signal),
    .i_lui_signal(lui_signal),
    .i_add_signal(add_signal),
    .i_sub_signal(sub_signal),
    .i_sll_signal(sll_signal),
    .i_slt_signal(slt_signal),
    .i_sltu_signal(sltu_signal),
    .i_ebreak_signal(ebreak_signal),
    .i_csrrs_signal(csrrs_signal),
    .i_csrrw_signal(csrrw_signal),
    .i_ecall_signal(ecall_signal),
    .i_mret_signal(mret_signal),
    .o_B_jump_signal(o_B_jump_signal),
    .o_data(exu_data)
    );
//------------------------------------------
// WBU实例化
//------------------------------------------
ysyx_25020042_WBU WBU_u (
    .clock(clock),
    .reset(reset),
    .i_exu_data(exu_data),
    .i_cur_pc(pc),
    .i_B_jump_signal(o_B_jump_signal),
    .i_jal_signal(jal_signal),
    .i_jalr_signal(jalr_signal),
    .i_lsu_busy(lsu_busy),
    .i_csrrw_signal(csrrw_signal),
    .i_csrrs_signal(csrrs_signal),
    .i_mret_signal(mret_signal),
    .i_ecall_signal(ecall_signal),
    .i_load_wdata(rdata),
    .i_csr_rdata(csr_data),
    .i_mstatus_rdata(mstatus),
    .i_mtvec_rdata(mtvec),
    .i_mepc_rdata(mepc),
    .i_mcause_rdata(mcause),
    .ifu_valid(ifu_valid),
    .lsu_valid(lsu_valid),
    .wbu_ready(wbu_ready),
    .wbu_valid(wbu_valid),
    .csr_wdata(csr_wdata),
    .reg_wdata(wdata),
    .o_mstatus_wdata(mstatus_wdata),
    .o_mtvec_wdata(mtvec_wdata),
    .o_mepc_wdata(mepc_wdata),
    .o_mcause_wdata(mcause_wdata),
    .next_pc(next_pc)
    );
//------------------------------------------
// LSU实例化
//------------------------------------------
ysyx_25020042_LSU LSU_u (
    .clock(clock),
    .reset(reset),
    .i_lbu_signal(lbu_signal),
    .i_lhu_signal(lhu_signal),
    .i_lb_signal(lb_signal),
    .i_lh_signal(lh_signal),
    .i_lw_signal(lw_signal),
    .i_sb_signal(sb_signal),
    .i_sh_signal(sh_signal),
    .i_sw_signal(sw_signal),
    .i_src2(src2),
    .i_data(exu_data),
    .i_wmask(wmask),
    .ifu_valid(ifu_valid),
    .wbu_ready(wbu_ready),
    .lsu_valid(lsu_valid),
    .lsu_ready(lsu_ready),
    .o_lsu_busy(lsu_busy),
    .o_rdata(rdata),
        `ifdef VERILATOR
    .performance_counter(lsu_performance_counter),
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
// CSR实例化
//------------------------------------------
ysyx_25020042_csr csr_u (
    .clock(clock),
    .reset(reset),
    .i_ecall_signal(ecall_signal),
    .i_csr_wdata(csr_wdata),
    .i_csr_addr(csr_addr),
    .i_mcause_wdata(mcause_wdata),
    .i_mstatus_wdata(mstatus_wdata),
    .i_mtvec_wdata(mtvec_wdata),
    .i_mepc_wdata(mepc_wdata),
    .wbu_valid(wbu_valid),
    .o_mstatus(mstatus),
    .o_mtvec(mtvec),
    .o_mepc(mepc),
    .o_mcause(mcause),
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
    .i_rd(rd),
    .i_data(wdata),
    .wbu_valid(wbu_valid),
    .o_src1(src1),
    .o_src2(src2)
);

    endmodule
