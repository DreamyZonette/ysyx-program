module ysyx_25020042_IFU(
    input clock,
    input reset,
    input [31:0] i_pc,
    input pc_valid,
    input lsu_ready,
    input wbu_ready,
    output reg ifu_valid,
    output wire [31:0] o_instruction,
    output reg [31:0] ifu_addr,
    // output reg ifu_wen,
    input [31:0] ifu_rdata,
    output reg ifu_reqValid,
    input ifu_respValid
);
import "DPI-C" function int pmem_read(input int raddr, input int len);

// assign o_instruction = $unsigned(pmem_read(i_pc, 4)); 

localparam IDLE = 1'b0;
localparam WAIT = 1'b1;

reg state;
assign o_instruction = ifu_rdata;

always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        ifu_valid <= 1'b0;
        // ifu_wen <= 1'b0;
        ifu_addr <= 32'h80000000;
        ifu_reqValid <= 1'b0;
    end
    else begin
        case(state)
            IDLE: begin
                if(pc_valid) begin
                    state <= WAIT;
                    ifu_addr <= i_pc;
                    ifu_reqValid <= 1'b1;
                end
                else begin
                    state <= IDLE;
                    if(wbu_ready || lsu_ready && ifu_valid) begin
                        ifu_valid <= 1'b0;
                    end
                end   
            end
            WAIT: begin
                // if (ifu_ren) begin
                //     ifu_ren <= 1'b0;
                // end
                if (ifu_reqValid) begin
                    ifu_reqValid <= 1'b0;
                end
                // o_instruction <= pmem_read(i_pc, 4);
                if (ifu_respValid) begin
                    state <= IDLE;
                    ifu_valid <= 1'b1;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
