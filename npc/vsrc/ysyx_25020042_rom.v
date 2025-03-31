module ysyx_25020042_rom # (ADDR_WIDTH = 32)(
    input [ADDR_WIDTH-1:0] addr,// pc
    output [31:0] data
);

    // ROM 定义：1024 项，每项 32 位（4 字节）
    reg [31:0] rom_mem [0:1023] = '{default:0};

    // 地址转换为索引（按 4 字节对齐）
    wire [31:0] rom_offset = (addr - 32'h80000000) >> 2;
    // reg [31:0] rom_mem [80000000+1024-1:80000000] = '{default:0};
    // initial begin
    //     $readmemh("npc/rom.txt", rom_mem);
    // end
    initial begin
        rom_mem[0] = 32'h00500093; // ADDI x1, x0, 5   # x1 = x0 + 5 = 0 + 5 = 5
        rom_mem[1] = 32'hffd08113; // ADDI x2, x1, -3  # x2 = x1 + (-3) = x1 - 3
    end
    // initial begin

    assign data = rom_mem[rom_offset];

    





endmodule

