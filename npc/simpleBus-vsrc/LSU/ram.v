/* verilator lint_off DECLFILENAME */
module ram (
    /* verilator lint_off UNUSEDSIGNAL */
    input [31:0] addr,
    input [31:0] wdata,
    /* verilator lint_on UNUSEDSIGNAL */
    output reg [31:0] rdata
);
    wire [31:0] ram_out [255:0];
    wire [7:0] ram_offset;

    assign ram_offset = addr[7:0];

    genvar i;
    generate
        for (i = 0; i < 256; i = i + 1) begin : ram_mem
        Reg #(
        .WIDTH(32),        // 设置寄存器宽度为32位
        .RESET_VAL(0)      // 复位值为0（可自定义）
        ) u_reg (
        .clk(1),
        .sys_rst_n(1),
        .i_data(wdata),   // 所有寄存器共享数据输入
        .o_data(ram_out[i]),// 独立输出到总线数组
        .wen(1'b1)   // 独立的地址译码写使能
        );
    end
    endgenerate

    always @(*) begin
        rdata = ram_out[ram_offset];
    end

    





endmodule
 /* verilator lint_on DECLFILENAME */
