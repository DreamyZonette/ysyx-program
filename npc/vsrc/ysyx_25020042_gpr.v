module ysyx_25020042_gpr #(REG_ADDR_LEN = 5, WIDTH = 32, REGS = 32) (
    input clk,
    input rst,   
    input  [REG_ADDR_LEN - 1:0] rs1,
    input  [REG_ADDR_LEN - 1:0] rs2,
    input  [REG_ADDR_LEN - 1:0] rd,
    input  [WIDTH - 1:0]        data_in,
    //input  [WIDTH - 1:0]        ram_data,
    output [WIDTH - 1:0]        src1,
    output [WIDTH - 1:0]        src2

    );

    reg [31:0] we;
    reg [REGS - 1:0] reg_file [0:31]; // 32 个寄存器


    // 写使能信号
    always @(*) begin   
        if (rd != 5'b0) begin // x0 寄存器不可写
            we = (32'b1 << rd); // 直接左移生成 one-hot 信号
        end
        else begin
            we = 32'b0;
        end
    end

    // 生成 32 个寄存器
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            Reg #(32, 0) r0 (
                .clk(clk),
                .rst(rst),
                .din(data_in),
                .dout(reg_file[i]),
                .wen(we [i])
            );
        end
    endgenerate


// 读取寄存器
    assign src1 = reg_file[rs1];
    assign src2 = reg_file[rs2];

endmodule





