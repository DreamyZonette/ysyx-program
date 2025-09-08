module IFU(
    input clock,
    input reset_n,
    input [31:0] i_pc,
    input pc_valid,
    input lsu_ready,
    input wbu_ready,
    output reg ifu_valid,
    output wire [31:0] o_instruction,
    output reg [31:0] ifu_addr,
    output reg ifu_ren,
    input [31:0] ifu_rdata
);
import "DPI-C" function int pmem_read(input int raddr, input int len);

// assign o_instruction = $unsigned(pmem_read(i_pc, 4)); 

localparam IDLE = 1'b0;
localparam WAIT = 1'b1;

reg state;
assign o_instruction = ifu_rdata;

always @(posedge clock) begin
    if(!reset_n) begin
        state <= IDLE;
        ifu_valid <= 1'b0;
        ifu_ren <= 1'b0;
        ifu_addr <= 32'h80000000;
    end
    else begin
        case(state)
            IDLE: begin
                if(pc_valid) begin
                    state <= WAIT;
                    ifu_ren <= 1'b1;
                    ifu_addr <= i_pc;
                end
                else begin
                    state <= IDLE;
                    if(wbu_ready || lsu_ready && ifu_valid) begin
                        ifu_valid <= 1'b0;
                    end
                end   
            end
            WAIT: begin
                if (ifu_ren) begin
                    ifu_ren <= 1'b0;
                end
                // o_instruction <= pmem_read(i_pc, 4);
                state <= IDLE;
                ifu_valid <= 1'b1;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
