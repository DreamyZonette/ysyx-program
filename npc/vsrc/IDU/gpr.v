module gpr  (
    input i_sys_clk,
    input i_sys_rst_n,   
    input  [4:0] i_rs1,
    input  [4:0] i_rs2,
    input  [4:0] i_rd,
    input  [31:0] i_data,
    output [31:0] o_src1,
    output [31:0] o_src2,
    output [31:0] o_reg_data [0:31]
    );
    
    
    reg  [31:0] wen;
    wire [31:0] reg_file [0:31]; // 32 个寄存器

    assign o_reg_data = reg_file;


    // 写使能信号
    always @(*) begin   
        if (i_rd != 5'b0) begin // x0 寄存器不可写
            wen = (32'b1 << i_rd); // 直接左移生成 one-hot 信号
        end
        else begin
            wen = 32'b0;
        end
    end

    // 生成 32 个寄存器
    Reg #(32, 32'b0) zero (i_sys_clk, i_sys_rst_n, i_data, reg_file[0], wen[0]);
    Reg #(32, 32'b0) ra   (i_sys_clk, i_sys_rst_n, i_data, reg_file[1], wen[1]);
    Reg #(32, 32'b0) sp   (i_sys_clk, i_sys_rst_n, i_data, reg_file[2], wen[2]);
    Reg #(32, 32'b0) gp   (i_sys_clk, i_sys_rst_n, i_data, reg_file[3], wen[3]);
    Reg #(32, 32'b0) tp   (i_sys_clk, i_sys_rst_n, i_data, reg_file[4], wen[4]);
    Reg #(32, 32'b0) t0   (i_sys_clk, i_sys_rst_n, i_data, reg_file[5], wen[5]);
    Reg #(32, 32'b0) t1   (i_sys_clk, i_sys_rst_n, i_data, reg_file[6], wen[6]);
    Reg #(32, 32'b0) t2   (i_sys_clk, i_sys_rst_n, i_data, reg_file[7], wen[7]);
    Reg #(32, 32'b0) s0   (i_sys_clk, i_sys_rst_n, i_data, reg_file[8], wen[8]);
    Reg #(32, 32'b0) s1   (i_sys_clk, i_sys_rst_n, i_data, reg_file[9], wen[9]);
    Reg #(32, 32'b0) a0   (i_sys_clk, i_sys_rst_n, i_data, reg_file[10], wen[10]);
    Reg #(32, 32'b0) a1   (i_sys_clk, i_sys_rst_n, i_data, reg_file[11], wen[11]);
    Reg #(32, 32'b0) a2   (i_sys_clk, i_sys_rst_n, i_data, reg_file[12], wen[12]);
    Reg #(32, 32'b0) a3   (i_sys_clk, i_sys_rst_n, i_data, reg_file[13], wen[13]);
    Reg #(32, 32'b0) a4   (i_sys_clk, i_sys_rst_n, i_data, reg_file[14], wen[14]);
    Reg #(32, 32'b0) a5   (i_sys_clk, i_sys_rst_n, i_data, reg_file[15], wen[15]);
    Reg #(32, 32'b0) a6   (i_sys_clk, i_sys_rst_n, i_data, reg_file[16], wen[16]);
    Reg #(32, 32'b0) a7   (i_sys_clk, i_sys_rst_n, i_data, reg_file[17], wen[17]);
    Reg #(32, 32'b0) s2   (i_sys_clk, i_sys_rst_n, i_data, reg_file[18], wen[18]);
    Reg #(32, 32'b0) s3   (i_sys_clk, i_sys_rst_n, i_data, reg_file[19], wen[19]);
    Reg #(32, 32'b0) s4   (i_sys_clk, i_sys_rst_n, i_data, reg_file[20], wen[20]);
    Reg #(32, 32'b0) s5   (i_sys_clk, i_sys_rst_n, i_data, reg_file[21], wen[21]);
    Reg #(32, 32'b0) s6   (i_sys_clk, i_sys_rst_n, i_data, reg_file[22], wen[22]);
    Reg #(32, 32'b0) s7   (i_sys_clk, i_sys_rst_n, i_data, reg_file[23], wen[23]);
    Reg #(32, 32'b0) s8   (i_sys_clk, i_sys_rst_n, i_data, reg_file[24], wen[24]);
    Reg #(32, 32'b0) s9   (i_sys_clk, i_sys_rst_n, i_data, reg_file[25], wen[25]);
    Reg #(32, 32'b0) s10  (i_sys_clk, i_sys_rst_n, i_data, reg_file[26], wen[26]);
    Reg #(32, 32'b0) s11  (i_sys_clk, i_sys_rst_n, i_data, reg_file[27], wen[27]);
    Reg #(32, 32'b0) t4   (i_sys_clk, i_sys_rst_n, i_data, reg_file[29], wen[29]);
    Reg #(32, 32'b0) t5   (i_sys_clk, i_sys_rst_n, i_data, reg_file[30], wen[30]);
    Reg #(32, 32'b0) t6   (i_sys_clk, i_sys_rst_n, i_data, reg_file[31], wen[31]);

    // genvar i;
    // generate
    //     for (i = 0; i < 32; i = i + 1) begin : register_instances
    //         Reg #(32) Reg_u (
    //             .clk(i_sys_clk),
    //             .sys_rst_n(i_sys_rst_n),
    //             .wen(wen [i]),
    //             .i_data(i_data),
    //             .o_data(reg_file[i])   
    //         );
    //     end
    // endgenerate


// 读取寄存器
    assign o_src1 = (i_rs1 == 5'b0)? 32'b0 : reg_file[i_rs1];
    assign o_src2 = (i_rs2 == 5'b0)? 32'b0 : reg_file[i_rs2];

endmodule





