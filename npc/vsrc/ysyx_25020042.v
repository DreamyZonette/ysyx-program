   module ysyx_25020042 (
        input         clock,
        input         reset,
        output        io_ifu_reqValid,
        output [31:0] io_ifu_addr,
        input         io_ifu_respValid,
        input [31:0]  io_ifu_rdata,
        output        io_lsu_reqValid,
        output [31:0] io_lsu_addr,
        output [1:0]  io_lsu_size,
        output        io_lsu_wen,
        output [31:0] io_lsu_wdata,
        output [3:0]  io_lsu_wmask,
        input         io_lsu_respValid,
        input [31:0]  io_lsu_rdata
    );
    `ifdef VERILATOR
    import "DPI-C" function void dpi_ebreak();

    always @(posedge clock) begin
            if (ebreak_signal == 1'b1) begin
                dpi_ebreak();
            end
    end
    `endif

    wire wbu_valid;
    wire pc_valid;
    wire lsu_ready;
    wire wbu_ready;
    wire ifu_valid;
    wire lsu_valid;

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



ysyx_25020042_PC PC_u(
    .clock(clock),
    .reset(reset),
    .i_next_pc(next_pc),
    .wbu_valid(wbu_valid),
    .pc_valid(pc_valid),
    .o_pc(pc)
);
    
ysyx_25020042_IFU IFU_u (
    .clock(clock),
    .reset(reset),
    .i_pc(pc),
    .pc_valid(pc_valid),
    .lsu_ready(lsu_ready),
    .wbu_ready(wbu_ready),
    .ifu_valid(ifu_valid),
    .o_instruction(instruction),
    .ifu_addr(io_ifu_addr),
    .ifu_rdata(io_ifu_rdata),
    .ifu_reqValid(io_ifu_reqValid),
    .ifu_respValid(io_ifu_respValid)
);



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

ysyx_25020042_EXU EXU_u (
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
    .lsu_addr(io_lsu_addr),
    .lsu_wen(io_lsu_wen),
    .lsu_wdata(io_lsu_wdata),
    .lsu_wmask(io_lsu_wmask),
    .lsu_rdata(io_lsu_rdata),
    .lsu_reqValid(io_lsu_reqValid),
    .lsu_respValid(io_lsu_respValid),
    .lsu_size(io_lsu_size)
);


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
/* verilator lint_off DECLFILENAME */
module ysyx_25020042_IFU(
    input clock,
    input reset,
    input [31:0] i_pc,
    input pc_valid,
    input lsu_ready,
    input wbu_ready,
    output reg ifu_valid,
    output reg [31:0] o_instruction,
    output reg [31:0] ifu_addr,
    // output reg ifu_wen,
    input [31:0] ifu_rdata,
    output reg ifu_reqValid,
    input ifu_respValid
);
`ifdef VERILATOR
export "DPI-C" function get_pc;
export "DPI-C" function get_instruction;

    function int unsigned get_pc();   
        return i_pc;
    endfunction
    function int unsigned get_instruction();   
        return o_instruction;
    endfunction
    `endif

localparam IDLE = 1'b0;
localparam WAIT = 1'b1;

reg state;

always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        ifu_valid <= 1'b0;
        // ifu_wen <= 1'b0;
        // ifu_addr <= 32'h30000000;
        ifu_addr <= 32'h0;
        ifu_reqValid <= 1'b0;
        o_instruction <= 32'h0;
    end
    else begin
        case(state)
            IDLE: begin
                if(pc_valid) begin
                    state <= WAIT;
                    ifu_addr <= i_pc;
                    ifu_reqValid <= 1'b1;
                end
                else begin
                    state <= IDLE;
                    if((wbu_ready || lsu_ready) && ifu_valid) begin
                        ifu_valid <= 1'b0;
                    end
                end   
            end
            WAIT: begin
                // if (ifu_ren) begin
                //     ifu_ren <= 1'b0;
                // end
                if (ifu_reqValid) begin
                    ifu_reqValid <= 1'b0;
                end
                // o_instruction <= pmem_read(i_pc, 4);
                if (ifu_respValid) begin
                    state <= IDLE;
                    ifu_valid <= 1'b1;
                    o_instruction <= ifu_rdata;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule

// Modified by Long for NPC project.
module ysyx_25020042_PC #(PC_LEN = 32)(
    input clock,
    input reset,
    input [PC_LEN-1:0] i_next_pc,
    input wbu_valid,
    output reg pc_valid,
    output reg [PC_LEN-1:0] o_pc
    );
    
    always @(posedge clock) begin
        if (reset)begin
            o_pc <= 32'h3000_0000;
            pc_valid <= 1'b1;
        end 
        else if (wbu_valid)begin
            o_pc <= i_next_pc;
            pc_valid <= 1'b1;
        end
        else if (pc_valid) begin
            pc_valid <= 1'b0;
        end

    end



endmodule

// 选择器模板内部实现
module ysyx_25020042_MuxKeyInternal #(NR_KEY = 2, KEY_LEN = 1, DATA_LEN = 1, HAS_DEFAULT = 0) (
  output reg [DATA_LEN-1:0] out,
  input [KEY_LEN-1:0] key,
  input [DATA_LEN-1:0] default_out,
  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
);

  localparam PAIR_LEN = KEY_LEN + DATA_LEN;
  wire [PAIR_LEN-1:0] pair_list [NR_KEY-1:0];
  wire [KEY_LEN-1:0] key_list [NR_KEY-1:0];
  wire [DATA_LEN-1:0] data_list [NR_KEY-1:0];

  genvar n;
  generate
    for (n = 0; n < NR_KEY; n = n + 1) begin
      assign pair_list[n] = lut[PAIR_LEN*(n+1)-1 : PAIR_LEN*n];
      assign data_list[n] = pair_list[n][DATA_LEN-1:0];
      assign key_list[n]  = pair_list[n][PAIR_LEN-1:DATA_LEN];
    end
  endgenerate

  reg [DATA_LEN-1 : 0] lut_out;
  reg hit;
  integer i;
  always @(*) begin
    lut_out = 0;
    hit = 0;
    for (i = 0; i < NR_KEY; i = i + 1) begin
      lut_out = lut_out | ({DATA_LEN{key == key_list[i]}} & data_list[i]);
      hit = hit | (key == key_list[i]);
    end
    if (!HAS_DEFAULT) out = lut_out;
    else out = (hit ? lut_out : default_out);
  end
endmodule

// 不带默认值的选择器模板
// module ysyx_25020042_MuxKey #(NR_KEY = 2, KEY_LEN = 1, DATA_LEN = 1) (
//   output [DATA_LEN-1:0] out,
//   input [KEY_LEN-1:0] key,
//   input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
// );
//   ysyx_25020042_MuxKeyInternal #(NR_KEY, KEY_LEN, DATA_LEN, 0) i0 (out, key, {DATA_LEN{1'b0}}, lut);
// endmodule

// // 带默认值的选择器模板
// module ysyx_25020042_MuxKeyWithDefault #(NR_KEY = 2, KEY_LEN = 1, DATA_LEN = 1) (
//   output [DATA_LEN-1:0] out,
//   input [KEY_LEN-1:0] key,
//   input [DATA_LEN-1:0] default_out,
//   input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
// );
//   ysyx_25020042_MuxKeyInternal #(NR_KEY, KEY_LEN, DATA_LEN, 1) i0 (out, key, default_out, lut);
// endmodule

// Modified by Long for NPC
module ysyx_25020042_alu (
    input [31:0] i_src1,
    input [31:0] i_src2,
    input [31:0] i_imm ,
    input [31:0] i_offset,
    input [31:0] i_pc_data,
    input [5:0]       i_shamt,
    input [31:0]      i_csr_data,
    input             i_addi_signal,
    input             i_jalr_signal,
    input             i_lb_signal,
    input             i_lh_signal,
    input             i_lw_signal,
    input             i_lbu_signal,
    input             i_lhu_signal,
    input             i_xori_signal,
    input             i_ori_signal,
    input             i_andi_signal,
    input             i_slli_signal,
    input             i_srli_signal,
    input             i_srai_signal,
    input             i_slti_signal,
    input             i_sltiu_signal,
    input             i_beq_signal,
    input             i_bne_signal,
    input             i_blt_signal,
    input             i_bge_signal,
    input             i_bltu_signal,
    input             i_bgeu_signal,
    input             i_jal_signal,
    input             i_sw_signal,
    input             i_sh_signal,
    input             i_sb_signal,
    input             i_and_signal,
    input             i_or_signal,
    input             i_xor_signal,
    input             i_srl_signal,
    input             i_sra_signal,
    input             i_auipc_signal,
    input             i_lui_signal,
    input             i_add_signal,
    input             i_sub_signal,
    input             i_sll_signal,
    input             i_slt_signal,
    input             i_sltu_signal,
    input             i_ebreak_signal,
    input             i_csrrs_signal,
    input             i_csrrw_signal,
    input             i_ecall_signal,
    input             i_mret_signal,
    output wire       o_B_jump_signal,
    output reg [31:0] o_data
    );

    wire [2:0] ALUctrl;
    wire [31:0] adder_out;
    wire [31:0] signed_shift_out;
    wire [31:0] unsigned_shift_out;
    wire [31:0] slt_out;
    wire [31:0] B_out;
    wire [31:0] XOR_out;
    wire [31:0] AND_out;
    wire [31:0] OR_out;
    wire [31:0] data1, data2;
    wire Add;
    wire Logic;
    wire Right;
    /* verilator lint_off UNUSEDSIGNAL */
    wire unsigned_less_than;
    wire signed_less_than;
    wire unsigned_greater_than;
    wire signed_greater_than;
    wire signed_equal;
    wire unsigned_equal;
    /* verilator lint_on UNUSEDSIGNAL */


    assign ALUctrl = (i_addi_signal | i_jalr_signal | i_lb_signal | i_lh_signal |
                    i_lw_signal | i_lbu_signal | i_lhu_signal | i_auipc_signal |
                    i_add_signal | i_sub_signal | i_jal_signal | i_sw_signal |
                    i_sh_signal | i_sb_signal) ? 3'b000 :
                    (i_srai_signal | i_sra_signal) ? 3'b001 :
                    (i_slli_signal | i_srli_signal | i_sll_signal | i_srl_signal ) ? 3'b010 :
                    (i_slti_signal | i_sltiu_signal | i_slt_signal | i_sltu_signal) ? 3'b011 :
                    (i_beq_signal | i_bne_signal | i_blt_signal | i_bge_signal |
                    i_bltu_signal | i_bgeu_signal) ? 3'b100 :
                    (i_xori_signal | i_xor_signal) ? 3'b101 :
                    (i_andi_signal | i_and_signal | i_lui_signal | i_csrrw_signal |
                    i_csrrs_signal | i_ecall_signal | i_mret_signal | i_ebreak_signal) ? 3'b110 :
                    (i_ori_signal | i_or_signal) ? 3'b111 : 
                         3'b000;

//     ysyx_25020042_MuxKeyWithDefault #(8, 3, 32) ALU_out (o_data, ALUctrl, 32'b0, {
//     3'b000, adder_out,
//     3'b001, signed_shift_out,
//     3'b010, unsigned_shift_out,
//     3'b011, slt_out,
//     3'b100, B_out,
//     3'b101, XOR_out,
//     3'b110, AND_out,
//     3'b111, OR_out
//   });
always @(*) begin
    case (ALUctrl)
        3'b000: begin
            o_data = adder_out;
        end
        3'b001: begin
            o_data = signed_shift_out;
        end
        3'b010: begin
            o_data = unsigned_shift_out;
        end
        3'b011: begin
            o_data = slt_out;
        end
        3'b100: begin
            o_data = B_out;
        end
        3'b101: begin
            o_data = XOR_out;
        end
        3'b110: begin
            o_data = AND_out;
        end
        3'b111: begin
            o_data = OR_out;
        end
    endcase
end

  // adder 控制信号
  assign Add = (i_slt_signal | i_sltu_signal | i_slti_signal | i_sltiu_signal |
              i_sub_signal) ? 1'b0 : 1'b1;

  assign data1 = (i_auipc_signal | i_jal_signal | i_beq_signal |i_bne_signal |
                 i_blt_signal | i_bge_signal | i_bltu_signal | i_bgeu_signal) ? i_pc_data : 
                 i_lui_signal ? i_imm : i_src1;
  assign data2 = (i_lui_signal | i_csrrw_signal) ? 32'hffffffff :
                 (i_ecall_signal | i_mret_signal | i_ebreak_signal) ? 32'h0 :
                 (i_csrrs_signal) ? i_csr_data : 
                 (i_beq_signal | i_bne_signal | i_blt_signal | i_bge_signal |
                 i_bltu_signal | i_bgeu_signal | i_jal_signal) ? i_offset :
                 (i_add_signal | i_sub_signal | i_and_signal | i_or_signal |
                 i_xor_signal | i_slt_signal | i_sltu_signal | i_sll_signal |
                 i_srl_signal | i_sra_signal) ? i_src2 : 
                 (i_slli_signal | i_srli_signal | i_srai_signal)? {26'b0 ,i_shamt}: i_imm;
  assign Logic = (i_sra_signal | i_srai_signal) ? 1'b0 : 1'b1;
  assign Right = (i_srl_signal | i_srli_signal | i_srai_signal | i_sra_signal) ? 1'b1 : 1'b0;

  assign XOR_out = data1 ^ data2;
  assign AND_out = data1 & data2;
  assign OR_out  = data1 | data2;
  assign adder_out = Add ? data1 + data2 : data1 - data2;
  assign slt_out[0] = (i_sltiu_signal & unsigned_less_than) | (i_slti_signal & signed_less_than) |
                      (i_sltu_signal & unsigned_less_than) | (i_slt_signal & signed_less_than);
  assign slt_out[31:1] = 31'b0;
  assign B_out = (i_beq_signal | i_bne_signal | i_blt_signal | i_bge_signal |
                 i_bltu_signal | i_bgeu_signal) ? adder_out : 32'b0;
  assign o_B_jump_signal = (i_beq_signal & B_unsigned_equal) |
                          (i_bne_signal & ~B_unsigned_equal) |
                          (i_blt_signal & B_signed_less_than) |
                          (i_bge_signal & (B_signed_greater_than | B_signed_equal)) |
                          (i_bltu_signal & B_unsigned_less_than) |
                          (i_bgeu_signal & (B_unsigned_greater_than | B_unsigned_equal));

//   wire overflow;    

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
  //adder adder_u (
  //  .Add(Add),
  //  .x(data1),
  //  .y(data2),
  //  .sum(adder_out),
  //  .cout_carry(overflow)
  //);

assign unsigned_shift_out = signed_shift_out;
assign signed_shift_out = Logic ? (Right ? data1 >> data2[4:0] : data1 << data2[4:0]) : (Right ? $signed(data1) >> data2[4:0] : $signed(data1) << data2[4:0]);
//  barrel_shifter_param barrel_shifter_param_u(
//     .Logic(Logic),
//     .Right(Right),
//     .data_i(data1),   
//     .shift_amt(data2[4:0]), 
//     .data_o(signed_shift_out)     
// );

assign unsigned_less_than = data1 < data2;
assign unsigned_equal = data1 == data2;
assign unsigned_greater_than = data1 > data2;
// assign unsigned_equal = ~(|adder_out[31:0]);
// assign unsigned_greater_than = overflow & (|adder_out);

// wire signs_different, sign_x_result_sign_diff;
// wire sign_x, sign_y, result_sign, signed_overflow;
// assign sign_x = data1[31];
// assign sign_y = data2[31];
// assign result_sign = adder_out[31];
// assign signs_different = sign_x ^ sign_y;
// assign sign_x_result_sign_diff = sign_x ^ result_sign;
// assign signed_overflow = signs_different & sign_x_result_sign_diff;

assign signed_equal = $signed(data1) == $signed(data2);
assign signed_less_than = $signed(data1) < $signed(data2);
assign signed_greater_than = $signed(data1) > $signed(data2);
// assign signed_equal = ~(|adder_out[31:0]);
// assign signed_less_than = result_sign ^ signed_overflow;
// assign signed_greater_than = ~signed_less_than & ~signed_equal;

// // 实例化第二个加法器，用于计算B指令
//     wire [31:0] cp_result;
//     wire B_overflow;
    wire B_unsigned_less_than;
    wire B_signed_less_than;
    wire B_unsigned_greater_than;
    wire B_signed_greater_than;
    wire B_signed_equal;
    wire B_unsigned_equal;
//   adder adder_u_2 (
//     .Add(1'b0),
//     .x(i_src1),
//     .y(i_src2),
//     .sum(cp_result),
//     .cout_carry(B_overflow)
//   );

assign B_unsigned_less_than = i_src1 < i_src2;
assign B_unsigned_equal = i_src1 == i_src2;
assign B_unsigned_greater_than = i_src1 > i_src2;

// wire   B_signs_different, B_sign_x_result_sign_diff;
// wire   B_sign_x, B_sign_y, B_result_sign, B_signed_overflow;
// assign B_sign_x = i_src1[31];
// assign B_sign_y = i_src2[31];
// assign B_result_sign = cp_result[31];
// assign B_signs_different = B_sign_x ^ B_sign_y;
// assign B_sign_x_result_sign_diff = B_sign_x ^ B_result_sign;
// assign B_signed_overflow = B_signs_different & B_sign_x_result_sign_diff;

// assign B_signed_equal = ~(|cp_result[31:0]);
// assign B_signed_less_than = B_result_sign ^ B_signed_overflow;
// assign B_signed_greater_than = ~B_signed_less_than & ~B_signed_equal;
assign B_signed_equal = $signed(i_src1) == $signed(i_src2);
assign B_signed_less_than = $signed(i_src1) < $signed(i_src2);
assign B_signed_greater_than = $signed(i_src1) > $signed(i_src2);



endmodule


// module full_1_adder (
//     input x,
//     input y,
//     input cin,
//     output sum,
//     output cout
// );

//     assign sum = x ^ y ^ cin;
//     assign cout = (x & y) | (cin & (x ^ y));

// endmodule

// module adder_32 (
//     input [31:0] x,
//     input [31:0] y,
//     input cin,
//     output [31:0] sum,
//     output cout_carry
// );
//     wire [31:0] cout;
//     assign cout_carry = cout[31];

//     genvar i;
//     generate
//         for (i = 0; i < 32; i = i + 1) begin : adder_32_gen
//             full_1_adder adder_i (
//                .x(x[i]),
//                .y(y[i]),
//                .cin(i == 0 ? cin : cout[i-1]),
//                .sum(sum[i]),
//                .cout(cout[i])
//             );
//         end
//     endgenerate

// endmodule

// module adder (
//     input Add,
//     input [31:0] x,
//     input [31:0] y,
//     output [31:0] sum,
//     output cout_carry
// );

// wire cin;
// wire [31:0] processed_y;
// assign cin = Add ? 1'b0 : 1'b1;
// assign processed_y = Add ? y : ~y;

// adder_32 adder_32_u (
//    .x(x),
//    .y(processed_y),
//    .cin(cin),
//    .sum(sum),
//    .cout_carry(cout_carry)
// );

// endmodule

// module barrel_shifter_param (
//     input  Logic,
//     input  Right,
//     input  [31:0] data_i,   
//     input  [4:0]  shift_amt, 
//     output [31:0] data_o     
// );

// wire sign = Logic ? 1'b0 : data_i[31];

// /* verilator lint_off UNUSEDSIGNAL */
// wire [31:0] stage0, stage1, stage2, stage3, stage4;
// wire [31:0] Lstage0, Lstage1, Lstage2, Lstage3, Lstage4;
// // 右
// assign stage0 = shift_amt[0] ? {sign, data_i[31:1]} : data_i;

// assign stage1 = shift_amt[1] ? {{2{sign}}, stage0[31:2]} : stage0;

// assign stage2 = shift_amt[2] ? {{4{sign}}, stage1[31:4]} : stage1;

// assign stage3 = shift_amt[3] ? {{8{sign}}, stage2[31:8]} : stage2;

// assign stage4 = shift_amt[4] ? {{16{sign}}, stage3[31:16]} : stage3;
// // 左
// assign Lstage0 = shift_amt[0] ? {data_i[30:0], 1'b0} : data_i;

// assign Lstage1 = shift_amt[1] ? {Lstage0[29:0], 2'b0} : Lstage0;

// assign Lstage2 = shift_amt[2] ? {Lstage1[27:0], 4'b0}: Lstage1;

// assign Lstage3 = shift_amt[3] ? {Lstage2[23:0], 8'b0}: Lstage2;

// assign Lstage4 = shift_amt[4] ? {Lstage3[15:0], 16'b0} : Lstage3;

// assign data_o = Right ? stage4 : Lstage4; 
/* verilator lint_on UNUSEDSIGNAL */
// endmodule

module ysyx_25020042_EXU(
    input wire [31:0] i_src1,
    input wire [31:0] i_src2,
    input wire [31:0] i_imm,
    input wire [31:0] i_offset,
    input wire [31:0] i_pc_data,
    input wire [5:0] i_shamt,
    input wire [31:0] i_csr_data,
    input wire i_addi_signal,
    input wire i_jalr_signal,
    input wire i_lb_signal,
    input wire i_lh_signal,
    input wire i_lw_signal,
    input wire i_lbu_signal,
    input wire i_lhu_signal,
    input wire i_xori_signal,
    input wire i_ori_signal,
    input wire i_andi_signal,
    input wire i_slli_signal,
    input wire i_srli_signal,
    input wire i_srai_signal,
    input wire i_slti_signal,
    input wire i_sltiu_signal,
    input wire i_beq_signal,
    input wire i_bne_signal,
    input wire i_blt_signal,
    input wire i_bge_signal,
    input wire i_bltu_signal,
    input wire i_bgeu_signal,
    input wire i_jal_signal,
    input wire i_sw_signal,
    input wire i_sh_signal,
    input wire i_sb_signal,
    input wire i_and_signal,
    input wire i_or_signal,
    input wire i_xor_signal,
    input wire i_srl_signal,
    input wire i_sra_signal,
    input wire i_auipc_signal,
    input wire i_lui_signal,
    input wire i_add_signal,
    input wire i_sub_signal,
    input wire i_sll_signal,
    input wire i_slt_signal,
    input wire i_sltu_signal,
    input wire i_ebreak_signal,
    input wire i_csrrs_signal,
    input wire i_csrrw_signal,
    input wire i_ecall_signal,
    input wire i_mret_signal,
    output wire o_B_jump_signal,
    output wire [31:0] o_data

);

ysyx_25020042_alu alu_u(
    .i_src1(i_src1),
    .i_src2(i_src2),
    .i_imm(i_imm),
    .i_offset(i_offset),
    .i_pc_data(i_pc_data),
    .i_shamt(i_shamt),
    .i_csr_data(i_csr_data),
    .i_addi_signal(i_addi_signal),
    .i_jalr_signal(i_jalr_signal),
    .i_lb_signal(i_lb_signal),
    .i_lh_signal(i_lh_signal),
    .i_lw_signal(i_lw_signal),
    .i_lbu_signal(i_lbu_signal),
    .i_lhu_signal(i_lhu_signal),
    .i_xori_signal(i_xori_signal),
    .i_ori_signal(i_ori_signal),
    .i_andi_signal(i_andi_signal),
    .i_slli_signal(i_slli_signal),
    .i_srli_signal(i_srli_signal),
    .i_srai_signal(i_srai_signal),
    .i_slti_signal(i_slti_signal),
    .i_sltiu_signal(i_sltiu_signal),
    .i_beq_signal(i_beq_signal),
    .i_bne_signal(i_bne_signal),
    .i_blt_signal(i_blt_signal),
    .i_bge_signal(i_bge_signal),
    .i_bltu_signal(i_bltu_signal),
    .i_bgeu_signal(i_bgeu_signal),
    .i_jal_signal(i_jal_signal),
    .i_sw_signal(i_sw_signal),
    .i_sh_signal(i_sh_signal),
    .i_sb_signal(i_sb_signal),
    .i_and_signal(i_and_signal),
    .i_or_signal(i_or_signal),
    .i_xor_signal(i_xor_signal),
    .i_srl_signal(i_srl_signal),
    .i_sra_signal(i_sra_signal),
    .i_auipc_signal(i_auipc_signal),
    .i_lui_signal(i_lui_signal),
    .i_add_signal(i_add_signal),
    .i_sub_signal(i_sub_signal),
    .i_sll_signal(i_sll_signal),
    .i_slt_signal(i_slt_signal),
    .i_sltu_signal(i_sltu_signal),
    .i_ebreak_signal(i_ebreak_signal),
    .i_csrrs_signal(i_csrrs_signal),
    .i_csrrw_signal(i_csrrw_signal),
    .i_ecall_signal(i_ecall_signal),
    .i_mret_signal(i_mret_signal),
    .o_B_jump_signal(o_B_jump_signal),
    .o_data(o_data)
);


endmodule

module ysyx_25020042_IDU (
    input   [31:0]  i_inst,
    output reg [31:0]  o_imm,
    output reg [31:0]  o_offset,
    output wire [5:0]   o_shamt,
    output     [3:0]  o_wmask,
    output     [11:0]  o_csr_addr,
    output  o_addi_signal,
    output  o_andi_signal,
    output  o_xori_signal,
    output  o_ori_signal,
    output  o_ebreak_signal,
    output  o_jalr_signal,
    output  o_lbu_signal,
    output  o_lw_signal,
    output  o_auipc_signal,
    output  o_lui_signal,
    output  o_lb_signal,
    output  o_lh_signal,
    output  o_lhu_signal,
    output  o_srai_signal,
    output  o_slli_signal,
    output  o_sb_signal,
    output  o_slti_signal,
    output  o_sltiu_signal,
    output  o_srli_signal,
    output  o_sll_signal,
    output  o_jal_signal,
    output  o_sw_signal,
    output  o_add_signal,
    output  o_and_signal,
    output  o_or_signal,
    output  o_xor_signal,
    output  o_sub_signal,
    output  o_slt_signal,
    output  o_sltu_signal,
    output  o_sra_signal,
    output  o_srl_signal,
    output  o_beq_signal,
    output  o_bne_signal,
    output  o_bge_signal,
    output  o_bgeu_signal,
    output  o_blt_signal,
    output  o_bltu_signal,
    output  o_sh_signal,
    output  o_csrrs_signal,
    output  o_csrrw_signal,
    output  o_ecall_signal,
    output  o_mret_signal,
    output  o_unknown_signal,
    output wire [4:0] rd,
    output wire [4:0] rs1,
    output wire [4:0] rs2
    );

    wire [6:0]  opcode;
    wire [31:0] J_offset;
    wire [31:0] I_imm;
    wire [4:0]  I_rs1;
    wire [4:0]  I_rd;
    wire [5:0]  I_shamt;
    wire [4:0]  U_rd;
    wire [31:0] U_imm;
    wire [4:0]  J_rd;
    wire [4:0]  S_rs1;
    wire [4:0]  S_rs2;
    wire [31:0] S_imm;
    wire [4:0]  R_rd;
    wire [4:0]  R_rs1;
    wire [4:0]  R_rs2;
    wire [4:0]  B_rs1;
    wire [4:0]  B_rs2;
    wire [31:0] B_offset;
    wire J_halt_signal;
    wire S_halt_signal;
    wire R_halt_signal;
    wire I_halt_signal;
    wire U_halt_signal;
    wire B_halt_signal;
    reg Btype_signal;
    reg Itype_signal;
    reg Jtype_signal;
    reg Rtype_signal;
    reg Stype_signal;
    reg Utype_signal;
    reg invalid_opcode_signal;

    assign opcode = i_inst[6:0];
    assign o_unknown_signal = (invalid_opcode_signal | 
        (J_halt_signal & Jtype_signal)| (S_halt_signal & Stype_signal) | 
        (R_halt_signal & Rtype_signal)| (I_halt_signal & Itype_signal) | 
        (U_halt_signal & Utype_signal)| (B_halt_signal & Btype_signal));

    //根据操作码判断类型
    always @ (*) begin
        Btype_signal = 1'b0;
        Itype_signal = 1'b0;
        Jtype_signal = 1'b0;
        Rtype_signal = 1'b0;
        Stype_signal = 1'b0;
        Utype_signal = 1'b0;
        invalid_opcode_signal = 1'b0;
        case(opcode)
        // I型
            7'b1100111:begin
                Itype_signal = 1'b1;
            end
            7'b0000011:begin
                Itype_signal = 1'b1;
            end
            7'b0010011:begin
                Itype_signal = 1'b1;
            end
            7'b0001111:begin
                Itype_signal = 1'b1;
            end
            7'b1110011:begin
                Itype_signal = 1'b1;
            end
        // J型
            7'b1101111:begin
                Jtype_signal = 1'b1;
            end
        // U型
            7'b0110111:begin
                Utype_signal = 1'b1;
            end
            7'b0010111:begin
                Utype_signal = 1'b1;
            end
        // B型
            7'b1100011:begin
                Btype_signal = 1'b1;
            end
        // R型
            7'b0110011:begin
                Rtype_signal = 1'b1;
            end
        // S型
            7'b0100011:begin
                Stype_signal = 1'b1;
            end
            default: begin
                invalid_opcode_signal = 1'b1;
            end
        endcase
    end
//     ysyx_25020042_MuxKeyWithDefault #(3, 3, 32) imm_out (o_imm, {Itype_signal, Utype_signal, Stype_signal}, 32'b0, {
//     3'b100, I_imm,
//     3'b010, U_imm,
//     3'b001, S_imm
//   });
always @ (*) begin
    if (Itype_signal) begin
        o_imm = I_imm;
    end else if (Utype_signal) begin
        o_imm = U_imm;
    end else if (Stype_signal) begin
        o_imm = S_imm;
    end else begin
        o_imm = 32'b0;
    end
end
//     ysyx_25020042_MuxKeyWithDefault #(4, 4, 5) rs1_out (rs1, {Itype_signal, Btype_signal, Stype_signal, Rtype_signal}, 5'b0, {
//     4'b1000, I_rs1,
//     4'b0100, B_rs1,
//     4'b0010, S_rs1,
//     4'b0001, R_rs1
//   });
always @ (*) begin
    if (Itype_signal) begin
        rs1 = I_rs1;
    end
    else if (Btype_signal) begin
        rs1 = B_rs1;
    end
    else if (Stype_signal) begin
        rs1 = S_rs1;
    end
    else if (Rtype_signal) begin
        rs1 = R_rs1;
    end
    else begin
        rs1 = 5'b0;
    end
end
//     ysyx_25020042_MuxKeyWithDefault #(3, 3, 5) rs2_out (rs2, {Btype_signal, Stype_signal, Rtype_signal}, 5'b0, {
//     3'b100, B_rs2,
//     3'b010, S_rs2,
//     3'b001, R_rs2
//   });
always @ (*) begin
    if (Btype_signal) begin
        rs2 = B_rs2;
    end
    else if (Stype_signal) begin
        rs2 = S_rs2;
    end
    else if (Rtype_signal) begin
        rs2 = R_rs2;
    end
    else begin
        rs2 = 5'b0;
    end
end

//     ysyx_25020042_MuxKeyWithDefault #(4, 4, 5) rd_out (rd, {Itype_signal, Utype_signal, Jtype_signal, Rtype_signal}, 5'b0, {
//     4'b1000, I_rd,
//     4'b0100, U_rd,
//     4'b0010, J_rd,
//     4'b0001, R_rd
//   });
always @ (*) begin
    if (Itype_signal) begin
        rd = I_rd;
    end
    else if (Utype_signal) begin
        rd = U_rd;
    end
    else if (Jtype_signal) begin
        rd = J_rd;
    end
    else if (Rtype_signal) begin
        rd = R_rd;
    end
    else begin
        rd = 5'b0;
    end
end

//     ysyx_25020042_MuxKeyWithDefault #(2, 2, 32) offset_out (o_offset, {Btype_signal, Jtype_signal}, 32'b0, {
//     2'b10, B_offset,
//     2'b01, J_offset
//   });
always @ (*) begin
    if (Btype_signal) begin
        o_offset = B_offset;
    end
    else if (Jtype_signal) begin
        o_offset = J_offset;
    end
    else begin
        o_offset = 32'b0;
    end
end

  assign o_shamt = Itype_signal ? I_shamt : 6'b0;

    ysyx_25020042_Itype Itype_u(
        .i_inst(i_inst),
        .o_imm(I_imm),
        .o_rs1(I_rs1),
        .o_shamt(I_shamt),
        .o_rd(I_rd),
        .o_csr_addr(o_csr_addr),
        .o_addi_signal(o_addi_signal),
        .o_ebreak_signal(o_ebreak_signal),
        .o_jalr_signal(o_jalr_signal),
        .o_lbu_signal(o_lbu_signal),
        .o_lw_signal(o_lw_signal),
        .o_slli_signal(o_slli_signal),
        .o_srai_signal(o_srai_signal),
        .o_srli_signal(o_srli_signal),
        .o_lb_signal(o_lb_signal),
        .o_lh_signal(o_lh_signal),
        .o_lhu_signal(o_lhu_signal),
        .o_andi_signal(o_andi_signal),
        .o_xori_signal(o_xori_signal),
        .o_ori_signal(o_ori_signal),
        .o_slti_signal(o_slti_signal),
        .o_sltiu_signal(o_sltiu_signal),
        .o_csrrs_signal(o_csrrs_signal),
        .o_csrrw_signal(o_csrrw_signal),
        .o_ecall_signal(o_ecall_signal),
        .o_mret_signal(o_mret_signal), // 原本是Rtype_u的输出
        .o_halt_signal(I_halt_signal)
    );
    ysyx_25020042_Utype Utype_u(
        .i_inst(i_inst),
        .o_rd(U_rd),
        .o_imm(U_imm),
        .o_auipc_signal(o_auipc_signal),
        .o_lui_signal(o_lui_signal),
        .o_halt_signal(U_halt_signal)
    );
    ysyx_25020042_Btype Btype_u(
        .i_inst(i_inst),
        .o_rs1(B_rs1),
        .o_rs2(B_rs2),
        .o_offset(B_offset),
        .o_beq_signal(o_beq_signal),
        .o_bne_signal(o_bne_signal),
        .o_bge_signal(o_bge_signal),
        .o_bgeu_signal(o_bgeu_signal),
        .o_blt_signal(o_blt_signal),
        .o_bltu_signal(o_bltu_signal),
        .o_halt_signal(B_halt_signal)
    );
    ysyx_25020042_Jtype Jtype_u(
        .i_inst(i_inst),
        .o_offset(J_offset),
        .o_rd(J_rd),
        .o_jal_signal(o_jal_signal),
        .o_halt_signal(J_halt_signal)
    );
    ysyx_25020042_Stype Stype_u(
    .i_inst(i_inst),
    .o_rs1(S_rs1),
    .o_rs2(S_rs2),
    .o_imm(S_imm),
    .o_sw_signal(o_sw_signal),
    .o_sb_signal(o_sb_signal),
    .o_sh_signal(o_sh_signal),
    .o_halt_signal(S_halt_signal),
    .o_wmask(o_wmask)
    );
    ysyx_25020042_Rtype Rtype_u(
    .i_inst(i_inst),
    .o_rd(R_rd),
    .o_rs1(R_rs1),
    .o_rs2(R_rs2),
    .o_add_signal(o_add_signal),
    .o_and_signal(o_and_signal),
    .o_or_signal(o_or_signal),
    .o_xor_signal(o_xor_signal),
    .o_sub_signal(o_sub_signal),
    .o_slt_signal(o_slt_signal),
    .o_sltu_signal(o_sltu_signal),
    .o_sll_signal(o_sll_signal),
    .o_sra_signal(o_sra_signal),
    .o_srl_signal(o_srl_signal),
    .o_halt_signal(R_halt_signal)
    );

    endmodule

module ysyx_25020042_Btype (
    input [31:0] i_inst,
    output [4:0] o_rs1,
    output [4:0] o_rs2,
    output wire [31:0] o_offset,
    output reg o_beq_signal,
    output reg o_bne_signal,
    output reg o_bge_signal,
    output reg o_bgeu_signal,
    output reg o_blt_signal,
    output reg o_bltu_signal,
    output o_halt_signal
);

    wire [11:0] offset;
    wire [6:0] opcode;
    wire [2:0] fun1;
    // reg sign_extended;
    // reg zero_extended;
    reg unknown_intstruction;

    assign opcode  = i_inst[6:0];
    assign fun1    = i_inst[14:12];
    assign o_rs1   = i_inst[19:15];
    assign o_rs2   = i_inst[24:20];
    assign offset  = {i_inst[31], i_inst[7], i_inst[30:25], i_inst[11:8]};
    assign o_offset = {{20{offset[11]}}, offset} << 1;
    assign o_halt_signal = unknown_intstruction;
    
    always @(*) begin
        o_beq_signal  = 1'b0;
        o_bne_signal  = 1'b0;
        o_bge_signal  = 1'b0;
        o_bgeu_signal = 1'b0;
        o_blt_signal  = 1'b0;
        o_bltu_signal = 1'b0;
        // sign_extended = 1'b0;
        // zero_extended = 1'b0;
        unknown_intstruction = 1'b0;

        case (opcode)
            7'b1100011: begin
                o_beq_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                o_bne_signal  = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                o_bge_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                o_bgeu_signal = (fun1 == 3'b111) ? 1'b1 : 1'b0;
                o_blt_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
                o_bltu_signal = (fun1 == 3'b110) ? 1'b1 : 1'b0;
            end
            default begin
                unknown_intstruction = 1'b1;
            end
        endcase
    end

endmodule

module ysyx_25020042_Itype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output [4:0] o_rs1,
    output [5:0] o_shamt,
    output wire [31:0] o_imm,
    output     [11:0] o_csr_addr,
    output reg o_jalr_signal,
    output reg o_addi_signal,
    output reg o_lw_signal,
    output reg o_lbu_signal,
    output reg o_ebreak_signal,
    output reg o_slli_signal,
    output reg o_srai_signal,
    output reg o_srli_signal,
    output reg o_lb_signal,
    output reg o_lh_signal,
    output reg o_lhu_signal,
    output reg o_andi_signal,
    output reg o_xori_signal,
    output reg o_slti_signal,
    output reg o_sltiu_signal,
    output reg o_ori_signal,
    output reg o_csrrs_signal,
    output reg o_csrrw_signal,
    output reg o_ecall_signal,
    output reg o_mret_signal,
    output o_halt_signal
);

    wire [11:0] imm;
    wire [2:0] fun1;
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [6:0] shamt_detect;
    wire [11:0] csr_addr;
    // reg sign_extended;
    // reg zero_extended;
    reg [4:0] jalr_rd;
    reg shamt_signal;
    reg unknown_intstruction;
    wire shamt_halt;

    assign opcode       = i_inst[6:0];
    assign rd           = i_inst[11:7];
    assign fun1         = i_inst[14:12];
    assign o_rs1        = i_inst[19:15];
    assign o_shamt      = i_inst[25:20];
    assign imm          = i_inst[31:20];
    assign shamt_detect = i_inst[31:25];
    assign o_rd         = (o_jalr_signal == 1'b1) ? jalr_rd : rd;
    assign o_halt_signal =  unknown_intstruction | shamt_halt;
    assign csr_addr     = i_inst[31:20];
    assign o_csr_addr   = (o_csrrs_signal == 1'b1 || o_csrrw_signal == 1'b1) ? csr_addr : 12'b0;
    assign o_imm = { {20{imm[11]}}, imm};
    assign shamt_halt = shamt_signal ? o_shamt[5] : 1'b0;

    always @ (*) begin
        // 初始化
        o_jalr_signal   = 1'b0;
        o_addi_signal   = 1'b0;
        o_ebreak_signal = 1'b0;
        o_lw_signal     = 1'b0;
        o_lbu_signal    = 1'b0;
        o_slli_signal   = 1'b0;
        o_srai_signal   = 1'b0;
        o_srli_signal   = 1'b0;
        o_lb_signal     = 1'b0;
        o_lh_signal     = 1'b0;
        o_lhu_signal    = 1'b0;
        o_andi_signal   = 1'b0;
        o_xori_signal   = 1'b0;
        o_ori_signal    = 1'b0;
        o_sltiu_signal  = 1'b0;
        o_slti_signal   = 1'b0;
        shamt_signal    = 1'b0;
        o_csrrs_signal  = 1'b0;
        o_csrrw_signal  = 1'b0;
        o_ecall_signal  = 1'b0;
        o_mret_signal   = 1'b0;
        unknown_intstruction = 1'b0;
        jalr_rd = 5'b0;
        
        // 指令识别
    case (opcode)
        7'b1100111: begin // jalr
            if (fun1 == 3'b000) begin
                o_jalr_signal   = 1'b1;
                    jalr_rd = rd;
            end
        end
        7'b0010011: begin // I-type ALU
            o_addi_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
            o_andi_signal  = (fun1 == 3'b111) ? 1'b1 : 1'b0;
            o_xori_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
            o_ori_signal   = (fun1 == 3'b110) ? 1'b1 : 1'b0;
            o_sltiu_signal = (fun1 == 3'b011) ? 1'b1 : 1'b0;
            o_slti_signal  = (fun1 == 3'b010) ? 1'b1 : 1'b0;
            // 涉及shamt
            if(shamt_detect == 7'b0000000) begin
                // 7'b0000000
                o_slli_signal = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                o_srli_signal = (fun1 == 3'b101) ? 1'b1 : 1'b0; 
            end else if(shamt_detect == 7'b0100000) begin
                // 7'b0100000
                o_srai_signal = (fun1 == 3'b101) ? 1'b1 : 1'b0; 
            end
            shamt_signal = o_slli_signal | o_srli_signal | o_srai_signal;
           
            // 根据指令类型选择扩展方式
            // sign_extended = (fun1 == 3'b000 || fun1 == 3'b111 || fun1 == 3'b100 || fun1 == 3'b010 || fun1 == 3'b110 || fun1 == 3'b011) ? 1'b1 : 1'b0; // addi/andi/xori/slti/ori
            
        end
        7'b1110011: begin  // ebreak
            if(i_inst == 32'b00000000000100000000000001110011) begin
                o_ebreak_signal = 1'b1;
            end else if(i_inst == 32'b00000000000000000000000001110011) begin
                o_ecall_signal = 1'b1;
            end else if(i_inst == 32'b00110000001000000000000001110011) begin
                o_mret_signal = 1'b1;
            end else begin
                o_csrrw_signal = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                o_csrrs_signal = (fun1 == 3'b010) ? 1'b1 : 1'b0;
            end
        end
        7'b0000011: begin  // load
            o_lw_signal   = (fun1 == 3'b010) ? 1'b1 : 1'b0;
            o_lb_signal   = (fun1 == 3'b000) ? 1'b1 : 1'b0;
            o_lh_signal   = (fun1 == 3'b001) ? 1'b1 : 1'b0;
            o_lbu_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
            o_lhu_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
        end
        default: begin
            unknown_intstruction = 1'b1;
        end
    endcase
    end


endmodule

module ysyx_25020042_Jtype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output wire [31:0] o_offset,
    output reg o_jal_signal,
    output o_halt_signal
);

    wire [6:0] opcode;
    wire [19:0] offset;
    reg unknown_intstruction;

    assign opcode   = i_inst[6:0];
    assign o_rd     = i_inst[11:7];
    assign offset = {i_inst[31], i_inst[19:12], i_inst[20], i_inst[30:21]};
    assign o_halt_signal = unknown_intstruction;
    assign o_offset  =  {{ {12{offset[19]}}, offset}} << 1;

    always @ (*) begin
        // 初始化
        o_jal_signal    = 1'b0;
        unknown_intstruction   = 1'b0;

        // 指令识别
        case (opcode)
            7'b 1101111: begin
                o_jal_signal  = 1'b1;
                // sign_extended = 1'b1;
            end
            default: begin
                unknown_intstruction   = 1'b1;
            end
        endcase
    end


endmodule

module ysyx_25020042_Rtype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output [4:0] o_rs1,
    output [4:0] o_rs2,
    output reg o_add_signal,
    output reg o_and_signal,
    output reg o_or_signal,
    output reg o_xor_signal,
    output reg o_sub_signal,
    output reg o_slt_signal,
    output reg o_sltu_signal,
    output reg o_sll_signal,
    output reg o_sra_signal,
    output reg o_srl_signal,
    output o_halt_signal
);

    wire [2:0] fun1;
    wire [6:0] fun2;
    wire [6:0] opcode;
    reg unknown_intstruction;

    assign opcode = i_inst[6:0];
    assign o_rd   = i_inst[11:7];
    assign fun1   = i_inst[14:12];
    assign o_rs1  = i_inst[19:15];
    assign o_rs2  = i_inst[24:20];
    assign fun2   = i_inst[31:25];
    assign o_halt_signal = unknown_intstruction;

    always @ (*) begin
        // 初始化
        o_add_signal    = 1'b0;
        o_and_signal    = 1'b0;
        o_or_signal     = 1'b0;
        o_xor_signal    = 1'b0;
        o_sub_signal    = 1'b0;
        o_slt_signal    = 1'b0;
        o_sltu_signal   = 1'b0;
        o_sll_signal    = 1'b0;
        o_sra_signal    = 1'b0;
        o_srl_signal    = 1'b0;
        unknown_intstruction = 1'b0;

        // 指令识别
        case (opcode)
            7'b0110011: begin
                if (fun2 == 7'b0000000) begin
                    o_add_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                    o_and_signal  = (fun1 == 3'b111) ? 1'b1 : 1'b0;
                    o_or_signal   = (fun1 == 3'b110) ? 1'b1 : 1'b0;
                    o_xor_signal  = (fun1 == 3'b100) ? 1'b1 : 1'b0;
                    o_slt_signal  = (fun1 == 3'b010) ? 1'b1 : 1'b0;
                    o_sltu_signal = (fun1 == 3'b011) ? 1'b1 : 1'b0;
                    o_sll_signal  = (fun1 == 3'b001) ? 1'b1 : 1'b0;
                    o_srl_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                end
                else if (fun2 == 7'b0100000) begin
                    o_sub_signal  = (fun1 == 3'b000) ? 1'b1 : 1'b0;
                    o_sra_signal  = (fun1 == 3'b101) ? 1'b1 : 1'b0;
                end
                else begin
                    unknown_intstruction = 1'b1;
                end
            end
            //待扩展
            default: begin
                unknown_intstruction = 1'b1;
            end
        endcase
    end


endmodule

module ysyx_25020042_Stype (
    input [31:0] i_inst,
    output [4:0] o_rs1,
    output [4:0] o_rs2,
    output wire [31:0] o_imm,
    output reg [3:0] o_wmask,
    output reg o_sw_signal,
    output reg o_sb_signal,
    output reg o_sh_signal,
    output o_halt_signal
);

    wire [11:0] imm;
    wire [2:0] fun;
    wire [6:0] opcode;
    // reg sign_extended;
    // reg zero_extended;
    reg unknown_intstruction;

    assign o_imm = { {20{imm[11]}}, imm};
    assign opcode = i_inst[6:0];
    assign fun    = i_inst[14:12];
    assign o_rs1  = i_inst[19:15];
    assign o_rs2  = i_inst[24:20];
    assign imm    = {i_inst[31:25], i_inst[11:7]};
    assign o_halt_signal = unknown_intstruction;

    always @ (*) begin
        // 初始化
        o_sw_signal     = 1'b0;
        o_sb_signal     = 1'b0;
        o_sh_signal     = 1'b0;
        unknown_intstruction = 1'b0;
        o_wmask = 4'b0;

        // 指令识别
    case (opcode)
        7'b0100011: begin // store
            o_sw_signal = (fun == 3'b010) ? 1'b1 : 1'b0;
            o_sb_signal = (fun == 3'b000) ? 1'b1 : 1'b0;
            o_sh_signal = (fun == 3'b001) ? 1'b1 : 1'b0;
        end
        default: begin
            unknown_intstruction = 1'b1;
        end
    endcase

        if (o_sw_signal == 1'b1) begin
            o_wmask = 4'b1111;
        end else if (o_sb_signal == 1'b1) begin
            o_wmask = 4'b0001;
        end else if (o_sh_signal == 1'b1) begin
            o_wmask = 4'b0011;
        end else begin
            o_wmask = 4'b1111;
        end
    end


endmodule

module ysyx_25020042_Utype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output wire [31:0] o_imm,
    output reg o_auipc_signal,
    output reg o_lui_signal,
    output o_halt_signal
);

    wire [6:0] opcode;
    wire [19:0] imm;
    reg unknown_intstruction;

    assign opcode = i_inst[6:0];
    assign o_rd   = i_inst[11:7];
    assign imm    = i_inst[31:12];
    assign o_halt_signal = unknown_intstruction;
    assign o_imm =  { {12{imm[19]}}, imm} << 12;

    always @ (*) begin
        // 初始化
        o_lui_signal    = 1'b0;
        o_auipc_signal  = 1'b0;
        unknown_intstruction   = 1'b0;

        // 指令识别
        case (opcode)
            7'b0110111: begin
                o_lui_signal  = 1'b1;
            end
            7'b0010111: begin
                o_auipc_signal  = 1'b1;
            end
            default: begin
                unknown_intstruction = 1'b1;
            end
        endcase
    end


endmodule

module ysyx_25020042_gpr  (
    input clock,
    input reset,   
    input  [4:0] i_rs1,
    input  [4:0] i_rs2,
    input  [4:0] i_rd,
    input  [31:0] i_data,
    input  wbu_valid,
    output [31:0] o_src1,
    output [31:0] o_src2
    );
    
    /* verilator lint_off UNUSEDSIGNAL */
    wire [15:0] wen;
    /* verilator lint_on UNUSEDSIGNAL */
    wire [31:0] reg_file [0:15];
    `ifdef VERILATOR
    export "DPI-C" function get_register_value;
    function int unsigned get_register_value(input int idx);
    // $display("当前模块的完整路径: %m");
        if (idx >= 0 && idx <= 15) begin
            return reg_file[idx];
        end else begin
            return 32'h0;
        end
    endfunction
    `endif

    assign wen = (i_rd != 5'b0) && wbu_valid? (16'b1 << i_rd) : 16'b0; // 写使能信号

    // 生成 16 个寄存器
    // ysyx_25020042_Reg #(32, 32'b0) zero (clock, reset, i_data, reg_file[0],  wen[0]);
    // ysyx_25020042_Reg #(32, 32'b0) ra   (clock, reset, i_data, reg_file[1],  wen[1]);
    // ysyx_25020042_Reg #(32, 32'b0) sp   (clock, reset, i_data, reg_file[2],  wen[2]);
    // ysyx_25020042_Reg #(32, 32'b0) gp   (clock, reset, i_data, reg_file[3],  wen[3]);
    // ysyx_25020042_Reg #(32, 32'b0) tp   (clock, reset, i_data, reg_file[4],  wen[4]);
    // ysyx_25020042_Reg #(32, 32'b0) t0   (clock, reset, i_data, reg_file[5],  wen[5]);
    // ysyx_25020042_Reg #(32, 32'b0) t1   (clock, reset, i_data, reg_file[6],  wen[6]);
    // ysyx_25020042_Reg #(32, 32'b0) t2   (clock, reset, i_data, reg_file[7],  wen[7]);
    // ysyx_25020042_Reg #(32, 32'b0) s0   (clock, reset, i_data, reg_file[8],  wen[8]);
    // ysyx_25020042_Reg #(32, 32'b0) s1   (clock, reset, i_data, reg_file[9],  wen[9]);
    // ysyx_25020042_Reg #(32, 32'b0) a0   (clock, reset, i_data, reg_file[10], wen[10]);
    // ysyx_25020042_Reg #(32, 32'b0) a1   (clock, reset, i_data, reg_file[11], wen[11]);
    // ysyx_25020042_Reg #(32, 32'b0) a2   (clock, reset, i_data, reg_file[12], wen[12]);
    // ysyx_25020042_Reg #(32, 32'b0) a3   (clock, reset, i_data, reg_file[13], wen[13]);
    // ysyx_25020042_Reg #(32, 32'b0) a4   (clock, reset, i_data, reg_file[14], wen[14]);
    // ysyx_25020042_Reg #(32, 32'b0) a5   (clock, reset, i_data, reg_file[15], wen[15]);
    reg [31:0] zero;
    reg [31:0] ra;  
    reg [31:0] sp; 
    reg [31:0] gp;  
    reg [31:0] tp;  
    reg [31:0] t0;  
    reg [31:0] t1;  
    reg [31:0] t2;  
    reg [31:0] s0;  
    reg [31:0] s1;  
    reg [31:0] a0;  
    reg [31:0] a1;  
    reg [31:0] a2;  
    reg [31:0] a3;  
    reg [31:0] a4;  
    reg [31:0] a5; 
    always @(posedge clock) begin
        if (reset) begin
            zero <= 32'b0;
            ra   <= 32'b0;
            sp   <= 32'b0;
            gp   <= 32'b0;
            tp   <= 32'b0;
            t0   <= 32'b0;
            t1   <= 32'b0;
            t2   <= 32'b0;
            s0   <= 32'b0;
            s1   <= 32'b0;
            a0   <= 32'b0;
            a1   <= 32'b0;
            a2   <= 32'b0;
            a3   <= 32'b0;
            a4   <= 32'b0;
            a5   <= 32'b0;
        end else begin
            if (wen[1]) ra   <= i_data;
            if (wen[2]) sp   <= i_data;
            if (wen[3]) gp   <= i_data;
            if (wen[4]) tp   <= i_data;
            if (wen[5]) t0   <= i_data;
            if (wen[6]) t1   <= i_data;
            if (wen[7]) t2   <= i_data;
            if (wen[8]) s0   <= i_data;
            if (wen[9]) s1   <= i_data;
            if (wen[10]) a0  <= i_data;
            if (wen[11]) a1  <= i_data;
            if (wen[12]) a2  <= i_data;
            if (wen[13]) a3  <= i_data;
            if (wen[14]) a4  <= i_data;
            if (wen[15]) a5  <= i_data;
        end
    end
    assign reg_file [0] = zero;
    assign reg_file [1] = ra;
    assign reg_file [2] = sp;
    assign reg_file [3] = gp;
    assign reg_file [4] = tp;
    assign reg_file [5] = t0;
    assign reg_file [6] = t1;
    assign reg_file [7] = t2;
    assign reg_file [8] = s0;
    assign reg_file [9] = s1;
    assign reg_file [10] = a0;
    assign reg_file [11] = a1;
    assign reg_file [12] = a2;
    assign reg_file [13] = a3;
    assign reg_file [14] = a4;
    assign reg_file [15] = a5;

// 读取寄存器
/* verilator lint_off WIDTHTRUNC */
    assign o_src1 = (i_rs1 == 5'b0)? 32'b0 : reg_file[i_rs1];
    assign o_src2 = (i_rs2 == 5'b0)? 32'b0 : reg_file[i_rs2];
/* verilator lint_on WIDTHTRUNC */

endmodule

/* 触发器模板 */
// module ysyx_25020042_Reg #(WIDTH = 1, RESET_VAL = 0) (
//   input clk,
//   input reset,
//   input [WIDTH-1:0] i_data,
//   output reg [WIDTH-1:0] o_data,
//   input wen
// );
//   always @(posedge clk) begin
//     if (reset) o_data <= RESET_VAL;
//     else if (wen) o_data <= i_data;
//   end
// endmodule

module ysyx_25020042_WBU(
    input clock,
    input reset,
    input [31:0] i_exu_data,
    input [31:0] i_cur_pc,
    input i_B_jump_signal,
    input i_jal_signal,
    input i_jalr_signal,
    input i_lsu_busy,
    input i_csrrs_signal,
    input i_csrrw_signal,
    input i_mret_signal,
    input i_ecall_signal,
    input  [31:0] i_load_wdata,
    input  [31:0] i_csr_rdata,
    /* verilator lint_off UNUSEDSIGNAL */
    input  [31:0] i_mstatus_rdata,
    input  [31:0] i_mtvec_rdata,
    input  [31:0] i_mepc_rdata,
    input  [31:0] i_mcause_rdata,
    /* verilator lint_on UNUSEDSIGNAL */
    input  ifu_valid,
    input  lsu_valid,
    output reg wbu_ready,
    output reg wbu_valid,
    output reg [31:0] csr_wdata,
    output reg [31:0] reg_wdata,
    /* verilator lint_off UNDRIVEN */
    output reg [31:0] o_mstatus_wdata,
    /* verilator lint_off UNUSEDSIGNAL */
    output reg [31:0] o_mtvec_wdata,
    /* verilator lint_on UNUSEDSIGNAL */
    /* verilator lint_on UNDRIVEN */
    output reg [31:0] o_mepc_wdata,
    output reg [31:0] o_mcause_wdata,
    output reg [31:0] next_pc
);

    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam LSU_WAIT = 2'b10;
    reg [1:0] state;



always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        next_pc <= 32'h3000_0004;
        reg_wdata <= 32'b0;
        csr_wdata <= 32'b0;
        wbu_ready <= 1'b0;
        wbu_valid <= 1'b0;
    end
    else begin
        case(state)
            IDLE: begin
                if (ifu_valid) begin
                    if (i_lsu_busy) begin
                        state <= LSU_WAIT;
                    end else begin
                        state <= WAIT;
                        wbu_ready <= 1'b1;
                    end
                end
                else begin
                    state <= IDLE;
                    if (wbu_ready) begin
                        wbu_ready <= 1'b0;
                    end
                    if (wbu_valid) begin
                        wbu_valid <= 1'b0;
                    end
                end
            end

            WAIT: begin
                if (wbu_ready) begin
                    wbu_ready <= 1'b0;
                end
                if (i_jal_signal == 1'b1 || i_jalr_signal == 1'b1)begin
                    next_pc <= i_exu_data;
                    reg_wdata <= i_cur_pc + 4;
                end else if (i_B_jump_signal == 1'b1) begin
                    next_pc <= i_exu_data;
                end else if (i_mret_signal == 1'b1)begin
                    next_pc <= i_mepc_rdata;
                end else if (i_ecall_signal == 1'b1)begin
                    next_pc <= i_mtvec_rdata;
                    o_mepc_wdata <= i_cur_pc;
                    o_mcause_wdata <= 32'd11; // 没有实现特权级转换
                
                end else if (i_csrrs_signal == 1'b1 || i_csrrw_signal == 1'b1) begin
                    csr_wdata <= i_exu_data;
                    reg_wdata <= i_csr_rdata;
                    next_pc <= i_cur_pc + 4;
                end
                else begin
                    next_pc <= i_cur_pc + 4;
                    reg_wdata <= i_exu_data;
                end

                state <= IDLE;
                wbu_valid <= 1'b1;
            end

            LSU_WAIT: begin
                if (lsu_valid) begin
                    wbu_ready <= 1'b1;
                    reg_wdata <= i_load_wdata;
                    state <= IDLE;
                    next_pc <= i_cur_pc + 4;
                    wbu_valid <= 1'b1;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end



endmodule

module ysyx_25020042_csr (
    input clock,
    input reset,
    input i_ecall_signal,
    input [31:0] i_csr_wdata,
    input [11:0] i_csr_addr,
    input [31:0] i_mstatus_wdata,
    input [31:0] i_mtvec_wdata,
    input [31:0] i_mepc_wdata,
    input [31:0] i_mcause_wdata,
    input wbu_valid,
    output [31:0] o_mstatus,
    output [31:0] o_mtvec,
    output [31:0] o_mepc,
    output [31:0] o_mcause,
    output reg [31:0] o_csr_rdata
);
`ifdef VERILATOR
export "DPI-C" function get_mstatus_value;
export "DPI-C" function get_mtvec_value;
export "DPI-C" function get_mepc_value;
export "DPI-C" function get_mcause_value;

    function int unsigned get_mstatus_value();   
        return o_mstatus;
    endfunction
    function int unsigned get_mtvec_value();   
        return o_mtvec;
    endfunction
    function int unsigned get_mepc_value();    
        return o_mepc;
    endfunction
    function int unsigned get_mcause_value();   
        return o_mcause;
    endfunction
`endif
reg [5:0] wen;
wire [31:0] mstatus_wdata;
wire [31:0] mtvec_wdata;
wire [31:0] mepc_wdata;
wire [31:0] mcause_wdata;
wire [31:0] mcycle_val;
wire [31:0] mcycleh_val;
wire [31:0] mvendorid_val;
wire [31:0] marchid_val;
wire [31:0] mcycle_wdata;
wire [31:0] mcycleh_wdata;



assign mstatus_wdata = (i_ecall_signal == 1'b1) ? i_mstatus_wdata : i_csr_wdata;
assign mtvec_wdata   = (i_ecall_signal == 1'b1) ? i_mtvec_wdata   : i_csr_wdata;
assign mepc_wdata    = (i_ecall_signal == 1'b1) ? i_mepc_wdata    : i_csr_wdata;
assign mcause_wdata  = (i_ecall_signal == 1'b1) ? i_mcause_wdata  : i_csr_wdata;
assign mcycle_wdata  = (wen[4] == 1'b1) ? i_csr_wdata    : mcycle_val + 1;
assign mcycleh_wdata = (wen[5] == 1'b1) ? i_csr_wdata    : mcycle_val == 32'hffffffff ? mcycleh_val + 1 : mcycleh_val;


always @(*) begin
    wen = 6'b0;
    o_csr_rdata = 32'b0;
    if (wbu_valid) begin
        if(i_ecall_signal == 1'b1 ) begin
            wen = 6'b001100;
        end else if(i_csr_addr == 12'h300) begin
            wen[0] = 1'b1;
        end else if(i_csr_addr == 12'h305) begin
            wen[1] = 1'b1;
        end else if(i_csr_addr == 12'h341) begin
            wen[2] = 1'b1;
        end else if(i_csr_addr == 12'h342) begin
            wen[3] = 1'b1;
        end else if(i_csr_addr == 12'hB00) begin
            wen[4] = 1'b1;
        end else if(i_csr_addr == 12'hB80) begin
            wen[5] = 1'b1;
        end else begin
            wen = 6'b0;
        end
    end else begin  wen = 6'b0; end

    if(i_csr_addr == 12'h300) begin
        o_csr_rdata = o_mstatus;
    end else if(i_csr_addr == 12'h305) begin
        o_csr_rdata = o_mtvec;
    end else if(i_csr_addr == 12'h341) begin
        o_csr_rdata = o_mepc;
    end else if(i_csr_addr == 12'h342) begin
        o_csr_rdata = o_mcause;
    end else if(i_csr_addr == 12'hB00) begin
        o_csr_rdata = mcycle_val;
    end else if(i_csr_addr == 12'hB80) begin
        o_csr_rdata = mcycleh_val;
    end else if(i_csr_addr == 12'hF11) begin
        o_csr_rdata = mvendorid_val;
    end else if(i_csr_addr == 12'hF12) begin
        o_csr_rdata = marchid_val;
    end else begin
        o_csr_rdata = 32'b0;
    end
    
end

// ysyx_25020042_Reg #(32, 32'h1800)     mstatus  (clock, reset, mstatus_wdata , o_mstatus     ,  wen[0]);
// ysyx_25020042_Reg #(32, 32'h0)        mtvec    (clock, reset, mtvec_wdata   , o_mtvec       ,  wen[1]);
// ysyx_25020042_Reg #(32, 32'h0)        mepc     (clock, reset, mepc_wdata    , o_mepc        ,  wen[2]);
// ysyx_25020042_Reg #(32, 32'h0)        mcause   (clock, reset, mcause_wdata  , o_mcause      ,  wen[3]);
// ysyx_25020042_Reg #(32, 32'h0)        mcycle   (clock, reset, mcycle_wdata  , mcycle_val    ,  1'b1  ); 
// ysyx_25020042_Reg #(32, 32'h0)        mcycleh  (clock, reset, mcycleh_wdata , mcycleh_val   ,  1'b1  ); 
// ysyx_25020042_Reg #(32, 32'h79737978) mvendorid(clock, reset, 32'h79737978  , mvendorid_val ,  1'b0  ); 
// ysyx_25020042_Reg #(32, 32'h017DC68A) marchid  (clock, reset, 32'h017DC68A  , marchid_val   ,  1'b0  ); 
reg [31:0] mstatus;  
reg [31:0] mtvec;    
reg [31:0] mepc;     
reg [31:0] mcause;   
reg [31:0] mcycle;   
reg [31:0] mcycleh;  
reg [31:0] mvendorid;
reg [31:0] marchid;  
assign o_mstatus = mstatus;
assign o_mtvec   = mtvec;
assign o_mepc    = mepc;
assign o_mcause  = mcause;
assign mcycle_val = mcycle;
assign mcycleh_val = mcycleh;
assign mvendorid_val = mvendorid;
assign marchid_val = marchid;
always @(posedge clock) begin
    if(reset) begin
        mstatus   <= 32'h1800;
        mtvec     <= 32'h0;
        mepc      <= 32'h0;
        mcause    <= 32'h0;
        mcycle    <= 32'h0;
        mcycleh   <= 32'h0;
        mvendorid <= 32'h79737978;
        marchid   <= 32'h017DC68A;
    end
    else begin
        if(wen[0]) begin
            mstatus   <= mstatus_wdata;
        end
        if(wen[1]) begin
            mtvec     <= mtvec_wdata;
        end
        if(wen[2]) begin
            mepc      <= mepc_wdata;
        end
        if(wen[3]) begin
            mcause    <= mcause_wdata;
        end
        mcycle    <= mcycle_wdata;
        mcycleh   <= mcycleh_wdata;
    end
end

endmodule

module ysyx_25020042_LSU(
    input clock,
    input reset,
    input i_lbu_signal,
    input i_lhu_signal,
    input i_lb_signal,
    input i_lh_signal,
    input i_lw_signal,
    input i_sb_signal,
    input i_sh_signal,
    input i_sw_signal,
    input [31:0] i_src2,
    input [31:0] i_data,
    /* verilator lint_off UNUSEDSIGNAL */
    input [3:0] i_wmask,//表示写哪些位
    /* verilator lint_on UNUSEDSIGNAL */
    input ifu_valid,
    input wbu_ready,
    output reg lsu_valid,
    output reg lsu_ready,
    output            o_lsu_busy,
    output reg [31:0] o_rdata,
    output reg [31:0] lsu_addr,
    output reg lsu_wen,
    // output reg lsu_ren,
    output reg [31:0] lsu_wdata,
    output reg [3:0] lsu_wmask,
    input [31:0] lsu_rdata,
    output reg lsu_reqValid,
    input lsu_respValid,
    output reg [1:0] lsu_size
);

localparam IDLE = 1'b0;
localparam WAIT = 1'b1;

reg state;
// reg [31:0] rdata;
wire [31:0] shifted_rdata = lsu_rdata >> (lsu_addr[1:0] * 8);
wire wen = i_sb_signal | i_sh_signal | i_sw_signal;
wire ren = i_lbu_signal | i_lhu_signal | i_lb_signal | i_lh_signal | i_lw_signal;
assign o_lsu_busy = ren | wen;

always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        // rdata <=32'b0;
        lsu_ready <= 1'b0;
        lsu_valid <= 1'b0;
        lsu_reqValid <= 1'b0;
        lsu_size <= 2'b0;
        o_rdata <= 32'b0;
        lsu_wen <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if(ifu_valid && (wen || ren)) begin
                    state <= WAIT;
                    lsu_ready <= 1'b1;
                    lsu_wen <= wen;
                    // if (i_data >= 32'h1000_0000 && i_data <= 32'h1000_0fff) begin
                    //     lsu_wdata <= i_src2;
                    // end
                    // else begin
                    //     lsu_wdata <= i_src2 << (i_data[1:0] * 8);
                    // end
                    lsu_wdata <= i_src2 << (i_data[1:0] * 8);
                    lsu_addr <= i_data;
                    // lsu_wdata <= i_src2 << (i_data[1:0] * 8);
                    lsu_wmask <= i_wmask << i_data[1:0];
                    lsu_reqValid <= 1'b1;
                    if (i_sb_signal || i_lb_signal ||i_lbu_signal) begin
                        lsu_size <= 2'b00;
                    end else if (i_sh_signal || i_lh_signal || i_lhu_signal) begin
                        lsu_size <= 2'b01;
                    end else if (i_sw_signal || i_lw_signal) begin
                        lsu_size <= 2'b10;
                    end else begin
                        lsu_size <= 2'b00;
                    end
                end
                else begin
                    state <= IDLE;
                    if (lsu_valid && wbu_ready) begin
                        lsu_valid <= 1'b0;
                    end
                end
            end
            WAIT: begin
                if(lsu_ready) begin
                    lsu_ready <= 1'b0;
                end
                
                if(lsu_reqValid) begin
                    lsu_reqValid <= 1'b0;
                end

                if (lsu_respValid) begin
                    lsu_valid <= 1'b1;
                    state <= IDLE;
                    if(lsu_wen) begin
                        lsu_wen <= 1'b0;
                    end
                    // if(i_lw_signal == 1'b1) begin
                    //     o_rdata <= lsu_rdata[31:0];
                    // end else if(i_lhu_signal == 1'b1) begin
                    //     o_rdata <= {16'b0, lsu_rdata[15:0]};
                    // end else if(i_lh_signal == 1'b1) begin
                    //     o_rdata <= {{16{lsu_rdata[15]}}, lsu_rdata[15:0]};
                    // end else if(i_lbu_signal == 1'b1) begin
                    //     o_rdata <= {24'b0, lsu_rdata[7:0]};
                    // end else if(i_lb_signal == 1'b1) begin
                    //     o_rdata <= {{24{lsu_rdata[7]}}, lsu_rdata[7:0]};
                    // end else begin
                    //     o_rdata <= 0;
                    // end
                    if(i_lw_signal == 1'b1) begin
                        o_rdata <= shifted_rdata[31:0];
                    end else if(i_lhu_signal == 1'b1) begin
                        o_rdata <= {16'b0, shifted_rdata[15:0]};
                    end else if(i_lh_signal == 1'b1) begin
                        o_rdata <= {{16{shifted_rdata[15]}}, shifted_rdata[15:0]};
                    end else if(i_lbu_signal == 1'b1) begin
                        o_rdata <= {24'b0, shifted_rdata[7:0]};
                    end else if(i_lb_signal == 1'b1) begin
                        o_rdata <= {{24{shifted_rdata[7]}}, shifted_rdata[7:0]};
                    end else begin
                        o_rdata <= 0;
                    end
                end
                
            end
        endcase

    end
    
end

endmodule
/* verilator lint_on DECLFILENAME */
