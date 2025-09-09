module ysyx_25020042_gpr  (
    input clock,
    input reset_n,   
    input  [4:0] i_rs1,
    input  [4:0] i_rs2,
    input  [4:0] i_rd,
    input  [31:0] i_data,
    input  wbu_valid,
    output [31:0] o_src1,
    output [31:0] o_src2,
    output [31:0] o_reg_data [0:15]
    );
    
    /* verilator lint_off UNUSEDSIGNAL */
    wire [15:0] wen;
    /* verilator lint_on UNUSEDSIGNAL */
    wire [31:0] reg_file [0:15]; // 16 个寄存器

    assign o_reg_data = reg_file;
    assign wen = (i_rd != 5'b0) && wbu_valid? (16'b1 << i_rd) : 16'b0; // 写使能信号

    // 生成 16 个寄存器
    ysyx_25020042_Reg #(32, 32'b0) zero (clock, reset_n, i_data, reg_file[0],  wen[0]);
    ysyx_25020042_Reg #(32, 32'b0) ra   (clock, reset_n, i_data, reg_file[1],  wen[1]);
    ysyx_25020042_Reg #(32, 32'b0) sp   (clock, reset_n, i_data, reg_file[2],  wen[2]);
    ysyx_25020042_Reg #(32, 32'b0) gp   (clock, reset_n, i_data, reg_file[3],  wen[3]);
    ysyx_25020042_Reg #(32, 32'b0) tp   (clock, reset_n, i_data, reg_file[4],  wen[4]);
    ysyx_25020042_Reg #(32, 32'b0) t0   (clock, reset_n, i_data, reg_file[5],  wen[5]);
    ysyx_25020042_Reg #(32, 32'b0) t1   (clock, reset_n, i_data, reg_file[6],  wen[6]);
    ysyx_25020042_Reg #(32, 32'b0) t2   (clock, reset_n, i_data, reg_file[7],  wen[7]);
    ysyx_25020042_Reg #(32, 32'b0) s0   (clock, reset_n, i_data, reg_file[8],  wen[8]);
    ysyx_25020042_Reg #(32, 32'b0) s1   (clock, reset_n, i_data, reg_file[9],  wen[9]);
    ysyx_25020042_Reg #(32, 32'b0) a0   (clock, reset_n, i_data, reg_file[10], wen[10]);
    ysyx_25020042_Reg #(32, 32'b0) a1   (clock, reset_n, i_data, reg_file[11], wen[11]);
    ysyx_25020042_Reg #(32, 32'b0) a2   (clock, reset_n, i_data, reg_file[12], wen[12]);
    ysyx_25020042_Reg #(32, 32'b0) a3   (clock, reset_n, i_data, reg_file[13], wen[13]);
    ysyx_25020042_Reg #(32, 32'b0) a4   (clock, reset_n, i_data, reg_file[14], wen[14]);
    ysyx_25020042_Reg #(32, 32'b0) a5   (clock, reset_n, i_data, reg_file[15], wen[15]);

// 读取寄存器
/* verilator lint_off WIDTHTRUNC */
    assign o_src1 = (i_rs1 == 5'b0)? 32'b0 : reg_file[i_rs1];
    assign o_src2 = (i_rs2 == 5'b0)? 32'b0 : reg_file[i_rs2];
/* verilator lint_on WIDTHTRUNC */

endmodule





