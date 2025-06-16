module ysyx_25020042_ram #(WIDTH = 32, INS_BYTES = 4, PC_LEN = 32)(
    input clk,
    input rst,
    input [WIDTH-1:0] data_in,
    input [PC_LEN-1:0] addr,
    input [INS_BYTES-1:0] byte_en,
    output [WIDTH-1:0] data_out,
    input ram_signal
    );
    
    reg [WIDTH-1:0] ram_mem [32'h80001024:32'h80000000 + 2048-1] = '{default:0};

    always @(posedge clk) begin
        if (rst) begin
            ram_mem[addr] <= 0;
        end
        else if (ram_signal) begin
            if (byte_en == 4'b0001) begin
                ram_mem[addr] <= {ram_mem[addr][WIDTH-1:8], data_in[7:0]};
            end
            else if (byte_en == 4'b0010) begin
                ram_mem[addr] <= {ram_mem[addr][WIDTH-1:16], data_in[15:0]};
            end
            else if (byte_en == 4'b0100) begin
                ram_mem[addr] <= {ram_mem[addr][WIDTH-1:24], data_in[23:0]};
            end
            else if (byte_en == 4'b1111) begin
                ram_mem[addr] <= data_in;
            end
            else begin
                ram_mem[addr] <= ram_mem[addr];
            end
        end
        
    end

    assign data_out = ram_mem[addr];

endmodule
