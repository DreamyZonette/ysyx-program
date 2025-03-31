module ysyx_25020042_rom # (ADDR_WIDTH = 32)(
    input [ADDR_WIDTH-1:0] addr,// pc
    output [31:0] data
);

    reg [31:0] rom [80000000:80000000+1024-1] = '{default:0};

    assign data = rom[addr];

    





endmodule

