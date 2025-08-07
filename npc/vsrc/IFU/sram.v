
module sram # (parameter DELAY = 1)(
    input i_sys_clk,
    input i_sys_rst_n,
    input [31:0] i_addr, // address
    input i_read_signal, // read signal
    output [31:0] o_sram_data,
    output o_sram_valid
);

import "DPI-C" function int pmem_read(input int raddr, input int len);

localparam IDLE = 0;
localparam READ = 1;

reg state;
reg next_state;
reg [7:0] count;
reg [31:0] sram_data;
assign o_sram_data = sram_data;
assign o_sram_valid = (state == READ) && (count >= DELAY);

always @(*) begin
    if(!i_sys_rst_n) begin
        next_state = IDLE;
    end
    else begin
        case (state) 
            IDLE: begin
                if(i_read_signal) begin
                    next_state = READ;
                end
                else begin
                    next_state = IDLE;
                end
            end
            READ: begin
                if(count >= DELAY) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = READ;
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
                // if (i_read_signal) begin
                //     count <= count + 1;  
                // end
            end
            READ: begin
                if(count >= DELAY) begin
                    count <= 0;
                end
                else begin
                    count <= count + 1;
                    if(count == DELAY - 1) begin
                    sram_data <= pmem_read(i_addr, 4);
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
