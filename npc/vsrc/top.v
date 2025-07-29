   module top (
        input sys_clk,
        input sys_rst_n,
        // input [31:0] inst,
        output [31:0] de_pc,
        output [31:0] de_next_pc,
        output [31:0] de_inst,
        output halt,
        output [31:0] reg_data [0:31]
    );

    import "DPI-C" function void dpi_ebreak();
    // import "DPI-C" function void dpi_return();

    always @(posedge sys_clk) begin
            if (ebreak_signal == 1'b1) begin
                dpi_ebreak();  // 调用 DPI-C 函数
            end
            // else if (instruction == 32'h0000006F) begin
            //     dpi_return();
            // end
        end

    assign halt = EXU_halt_signal | IDU_halt_signal;
    assign de_pc = pc;
    assign de_next_pc = next_pc;
    assign de_inst = instruction;

    wire addi_signal;
    wire ebreak_signal;
    wire jalr_signal;
    wire lbu_signal;
    wire lw_signal;
    wire auipc_signal;
    wire lui_signal;
    wire sb_signal;
    wire sw_signal;
    wire add_signal;
    wire IDU_halt_signal;
    wire EXU_halt_signal;
    wire [31:0] wdata;
    wire [31:0] imm;
    wire [31:0] src1;
    wire [31:0] src2;
    wire [31:0] offset;
    wire [31:0] next_pc;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [3:0] wmask;
    wire [31:0] data;
    wire [31:0] rdata;
    wire load_signal;


    PC PC_u(
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_next_pc(next_pc),
    .o_pc(pc)
    );
    
    IFU IFU_u (
    .i_pc(pc),
    .o_instruction(instruction)
    );

    IDU IDU_u (
    .i_sys_clk(sys_clk),
    .i_sys_rst_n(sys_rst_n),
    .i_inst(instruction),
    .i_wdata(wdata),
    .o_src1(src1),
    .o_src2(src2),
    .o_imm(imm),
    .o_offset(offset),
    .o_wmask(wmask),
    .o_addi_signal(addi_signal),
    .o_ebreak_signal(ebreak_signal),
    .o_jalr_signal(jalr_signal),
    .o_lbu_signal(lbu_signal),
    .o_lw_signal(lw_signal),
    .o_auipc_signal(auipc_signal),
    .o_lui_signal(lui_signal),
    .o_sb_signal(sb_signal),
    .o_sw_signal(sw_signal),
    .o_add_signal(add_signal),
    .o_halt_signal(IDU_halt_signal),
    .o_reg_data(reg_data)
    );

    EXU EXU_u (
    .i_src1(src1),
    .i_src2(src2),
    .i_imm(imm),
    .i_offset(offset),
    .i_pc_data(pc),
    .i_addi_signal(addi_signal),
    .i_jalr_signal(jalr_signal),
    .i_lw_signal(lw_signal),
    .i_lbu_signal(lbu_signal),
    .i_sw_signal(sw_signal),
    .i_sb_signal(sb_signal),
    .i_auipc_signal(auipc_signal),
    .i_lui_signal(lui_signal),
    .i_add_signal(add_signal),
    .i_ebreak_signal(ebreak_signal),
    .o_halt_signal(EXU_halt_signal),
    .o_data(data)
    );

    WBU WBU_u (
    .i_sys_rst_n(sys_rst_n),
    .i_jalr_signal(jalr_signal),
    .i_load_signal(load_signal),
    .i_load_wdata(rdata),
    .i_cur_pc(pc),
    .i_sys_wdata(data),
    .o_reg_wdata(wdata),
    .o_next_pc(next_pc)
    );

    LSU LSU_u (
    .i_sys_clk(sys_clk),
    .i_lbu_signal(lbu_signal),
    .i_lw_signal(lw_signal),
    .i_sb_signal(sb_signal),
    .i_sw_signal(sw_signal),
    .i_src2(src2),
    .i_data(data),
    .i_wmask(wmask),
    .o_load_signal(load_signal),
    .o_rdata(rdata)
);
   
    endmodule
