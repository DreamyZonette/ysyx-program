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
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : register_instances
            Reg #(32) Reg_u (
                .clk(i_sys_clk),
                .sys_rst_n(i_sys_rst_n),
                .wen(wen [i]),
                .i_data(i_data),
                .o_data(reg_file[i])   
            );
        end
    endgenerate


// 读取寄存器
    assign o_src1 = (i_rs1 == 5'b0)? 32'b0 : reg_file[i_rs1];
    assign o_src2 = (i_rs2 == 5'b0)? 32'b0 : reg_file[i_rs2];

endmodule





