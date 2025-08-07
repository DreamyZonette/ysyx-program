
module ram # (parameter DELAY = 1)(
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    input wire [31:0] i_raddr, // read address
    input wire [31:0] i_waddr, // write address
    input wire i_rvalid, // store signal
    input wire i_wen, // load signal
    input wire [3:0]i_wmask, // write mask
    input wire [31:0]i_wdata, // write data
    output wire [31:0] o_rdata,// read data
    output wire o_ram_valid
);

import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, input int len, input int data);

localparam IDLE = 0;
localparam LOAD = 1;
localparam STORE = 2;

reg [1:0] state;
reg [1:0] next_state;
reg [7:0] count;
reg [31:0] sram_data;
assign o_rdata = sram_data;
assign o_ram_valid = (state == LOAD || state == STORE) && (count >= DELAY);

always @(*) begin
    if(!i_sys_rst_n) begin
        next_state = IDLE;
    end
    else begin
        case (state) 
            IDLE: begin
                if(i_rvalid) begin
                    next_state = LOAD;
                end
                else if (i_wen) begin
                    next_state = STORE;
                end
                else begin
                    next_state = IDLE;
                end
            end
            LOAD: begin
                if(count >= DELAY) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = LOAD;
                end
            end
            STORE: begin
                if(count >= DELAY) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = STORE;
                end
            end
        default: begin
            next_state = IDLE;
        end
    endcase
    end
end

always @(posedge i_sys_clk) begin
    if(!i_sys_rst_n) begin
        sram_data <= 0;
        count <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                count <= 0;
            end
            LOAD: begin
                if(count >= DELAY) begin
                    count <= 0;
                end
                else begin
                    count <= count + 1;
                    if(count == DELAY - 1) begin
                    sram_data <= pmem_read(i_raddr, 4);
                    end
                end
            end
            STORE: begin
                if(count >= DELAY) begin
                    count <= 0;
                end
                else begin
                    count <= count + 1;
                    if(count == DELAY - 1) begin
                    pmem_write(i_waddr, i_wmask, i_wdata);
                    end
                end
            end
            default: begin
                sram_data <= 0;
                count <= 0;
            end
        endcase
    end
end

always @(posedge i_sys_clk) begin
    if(!i_sys_rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end 



endmodule
