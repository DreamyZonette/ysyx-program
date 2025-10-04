module ysyx_25020042_IFU(
    input clock,
    input reset,
    input [31:0] i_pc,
    input pc_valid,
    input lsu_ready,
    input wbu_ready,
    output reg ifu_valid,
    output reg [31:0] o_instruction,
    output reg [31:0] ifu_addr,
    // output reg ifu_wen,
    input [31:0] ifu_rdata,
    output reg ifu_reqValid,
    input ifu_respValid,
    output reg ifu_respReady,
    input ifu_reqReady
);
export "DPI-C" function get_pc;
export "DPI-C" function get_instruction;

    function int unsigned get_pc();   
        return i_pc;
    endfunction
    function int unsigned get_instruction();   
        return o_instruction;
    endfunction

localparam IDLE = 1'b0;
localparam WAIT = 1'b1;

reg state;

always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        ifu_valid <= 1'b0;
        // ifu_wen <= 1'b0;
        // ifu_addr <= 32'h30000000;
        ifu_addr <= 32'h0;
        ifu_reqValid <= 1'b0;
        o_instruction <= 32'h0;
        ifu_respReady <= 1'b0;
    end
    else begin
        case(state)
            IDLE: begin
                if (ifu_respReady) begin
                    ifu_respReady <= 1'b0;
                end
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
                if (ifu_reqReady) begin
                    ifu_reqValid <= 1'b0;
                end
                if (ifu_respValid) begin
                    ifu_respReady <= 1'b1;
                    state <= IDLE;
                    ifu_valid <= 1'b1;
                    o_instruction <= ifu_rdata;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
