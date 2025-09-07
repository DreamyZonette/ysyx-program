module IFU(
    input clock,
    input reset_n,
    input [31:0] ifu_raddr,
    input wbu_valid,
    // input pc_valid,
    input lsu_ready,
    input wbu_ready,
    output reg ifu_valid,
    output reg [31:0] ifu_rdata
);
import "DPI-C" function int pmem_read(input int raddr, input int len);

// assign o_instruction = $unsigned(pmem_read(ifu_raddr, 4)); 

localparam IDLE = 1'b0;
localparam WAIT = 1'b1;

reg state;

always @(posedge clock) begin
    if(!reset_n) begin
        state <= IDLE;
        ifu_rdata <= 32'b0;
        ifu_valid <= 1'b0;
    end
    else begin
        case(state)
            IDLE: begin
                if(wbu_valid) begin
                    state <= WAIT;
                end
                else begin
                    state <= IDLE;
                    if(wbu_ready || lsu_ready && ifu_valid) begin
                        ifu_valid <= 1'b0;
                    end
                end   
            end
            WAIT: begin
                ifu_rdata <= pmem_read(ifu_raddr, 4);
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
