// /* verilator lint_off DECLFILENAME */
// module rom (
//     input [31:0] addr,
//     output reg [31:0] rdata
// );
//     wire [31:0] rom_out [255:0];
//     wire [7:0] rom_offset;

//     assign rom_offset = addr[7:0];

//     genvar i;
//     generate
//         for (i = 0; i < 256; i = i + 1) begin : rom_mem
//         Reg #(
//         .WIDTH(32),        // 设置寄存器宽度为32位
//         .RESET_VAL(0)      // 复位值为0（可自定义）
//         ) u_reg (
//         .clk(clk),
//         .sys_rst_n(sys_rst_n),
//         .i_data(i_data),   // 所有寄存器共享数据输入
//         .o_data(rom_out[i]),// 独立输出到总线数组
//         .wen(1'b0)   // 独立的地址译码写使能
//         );
//     end
//     endgenerate

//     always @(*) begin
//         rdata = rom_out[rom_offset];
//     end

    





// endmodule
//  /* verilator lint_on DECLFILENAME */
