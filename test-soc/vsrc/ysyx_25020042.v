`include "include/defs.vh"

module ysyx_25020042 (
    input         clock,
    input         reset,
    // output [31:0] instr,       // 指令
    // output [31:0] imem_pc,     // 指令内存地址
    // output wire wen,                      // 内存使能
    // output [31:0] mem_addr,     // 数据内存地址
    // output        inst_done
    output        io_ifu_reqValid,
    output    [31:0] io_ifu_addr,
    input        io_ifu_respValid,
    input     [31:0] io_ifu_rdata,
    output        io_lsu_reqValid,
    output    [31:0] io_lsu_addr,
    output        io_lsu_wen,
    output    [31:0] io_lsu_wdata,
    output    [3:0] io_lsu_wmask,
    input        io_lsu_respValid,
    input     [31:0] io_lsu_rdata,
    output    [1:0]  io_lsu_size
);
    //===== IFU =====//
    wire [31:0]  pc;
    wire [31:0]  inst;
    wire         if_ready;
    wire         wb_valid;
    wire         if_valid;
    wire         id_ready;
    wire         ifu_reqValid;
    wire         ifu_reqReady;
    wire [31:0]  ifu_addr;
    wire         ifu_respValid;
    wire         ifu_respReady;
    wire [31:0]  ifu_rdata;
    
    //===== ID =====//
    wire [6:0]   opcode;
    wire [4:0]   rs1, rs2, rd;
    wire [31:0]  imm;
    wire [2:0]   func3;
    wire [6:0]   func7;
    wire         RegWrite;
    wire         MemWrite;
    wire         MemRead;
    wire [3:0]   alu_op;
    wire [2:0]   MemLen;
    wire         id_valid;
    wire         ex_ready;

    //===== EXU =====//
    wire [31:0]  rs1_val, rs2_val;
    wire [31:0]  alu_result;
    wire         ex_valid;
    wire         mem_ready;

    //===== MEM =====//
    wire [31:0]  data_out;
    wire         mem_valid;
    wire         wb_ready;
    wire         lsu_reqValid;
    wire         lsu_reqReady;
    wire [31:0]  lsu_addr;
    wire         lsu_wen;
    wire [31:0]  lsu_rdata;
    wire [31:0]  lsu_wdata;
    wire [3:0]   lsu_wmask;
    wire         lsu_respValid;
    wire         lsu_respReady;
    
    //===== WB =====//
    wire [31:0]  wb_data;
    wire [31:0]  jalr_target;
    wire         is_jalr; 
    wire [4:0]   rd_wb;
    wire         RegWrite_wb;
    wire         wb_MemRead, wb_MemWrite;
    wire [2:0]   wb_MemLen;
    wire [31:0]  wb_addr, wb_data_in;

    //====SRAM读写接口====//
    // SRAM sram(
    //    .clk(clk),
    //    .reset(rst),
    //    .ifu_reqValid(ifu_reqValid),
    // //    .ifu_reqReady(ifu_reqReady),
    //    .ifu_addr(ifu_addr),
    //    .ifu_respValid(ifu_respValid),
    // //    .ifu_respReady(ifu_respReady),
    //    .ifu_rdata(ifu_rdata),
    //    .lsu_reqValid(lsu_reqValid),
    // //    .lsu_reqReady(lsu_reqReady),
    //    .lsu_addr(lsu_addr),
    //    .lsu_wen(lsu_wen),
    //    .lsu_wdata(lsu_wdata),
    //    .lsu_wmask(lsu_wmask),
    //    .lsu_rdata(lsu_rdata),
    // // .lsu_respReady(lsu_respReady),
    //     .lsu_respValid(lsu_respValid)
    // );

    // 取指模块
    ysyx_25020039_IFU ifu (
        .clk(clock),
        .reset(reset),
        .branch_target(jalr_target),
        .pc_src(is_jalr),
        .pc(pc),
        .instr(inst),
        .if_ready(if_ready),
        .wb_valid(wb_valid),
        .if_valid(if_valid),
        .id_ready(id_ready),
        .ifu_reqValid(io_ifu_reqValid),
        //.ifu_reqReady(ifu_reqReady),
        .ifu_addr(io_ifu_addr),
        .ifu_respValid(io_ifu_respValid),
        //.ifu_respReady(ifu_respReady),
        .ifu_rdata(io_ifu_rdata)
    );

    // 译码模块
    ysyx_25020039_IDU idu (
        .clk(clock),
        .reset(reset),
        .instr(inst),
        .if_valid(if_valid),
        .id_ready(id_ready),
        .id_valid(id_valid),
        .ex_ready(ex_ready),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .imm(imm),
        .func3(func3),
        .func7(func7),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .alu_op(alu_op),
        .MemLen(MemLen)
    );
    
    ysyx_25020039_EXU exu(
        .clk(clock), 
        .reset(reset),
        .id_valid(id_valid),
        .ex_ready(ex_ready),
        .opcode(opcode), 
        .rs1_val(rs1_val),
        .rs2_val(rs2_val),
        .imm(imm),
        .alu_op(alu_op),
        .mem_ready(mem_ready),
        .ex_valid(ex_valid),
        .alu_result(alu_result) 
    );

    // 内存模块
    ysyx_25020039_MEM mem(
        .clk(clock),
        .reset(reset),
        .ex_valid(ex_valid),
        .mem_ready(mem_ready),
        .wb_ready(wb_ready),
        .mem_valid(mem_valid),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemLen(MemLen),
        .addr(rs1_val + imm),
        .data_in(rs2_val),
        .data_out(data_out),
        .lsu_reqValid(io_lsu_reqValid),
        // .lsu_reqReady(lsu_reqReady),
        .lsu_addr(io_lsu_addr),
        .lsu_wen(io_lsu_wen),
        .lsu_wdata(io_lsu_wdata),
        .lsu_wmask(io_lsu_wmask),
        .lsu_rdata(io_lsu_rdata),
        // .lsu_respReady(lsu_respReady),
        .lsu_respValid(io_lsu_respValid),
        .lsu_size(io_lsu_size)
    );

    // 写回模块
    ysyx_25020039_WBU wbu (
        .clk(clock), 
        .reset(reset),
        .mem_valid(mem_valid),
        .wb_ready(wb_ready),
        .if_ready(if_ready),
        .wb_valid(wb_valid),
        .opcode(opcode),
        .func3(func3),
        .id_rd(rd),
        .id_RegWrite(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rs1_val(rs1_val),
        .rs2_val(rs2_val),
        .pc(pc),
        .imm(imm),
        .alu_result(alu_result),
        .data_out(data_out),
        .is_jalr(is_jalr),
        .jalr_target(jalr_target),
        .wb_data(wb_data)
    );

    wire [31:0] instr = inst;
    wire [31:0] imem_pc = pc;
    wire wen = MemRead | MemWrite;
    wire [31:0] mem_addr = lsu_addr;
    wire inst_done = wb_valid;

endmodule