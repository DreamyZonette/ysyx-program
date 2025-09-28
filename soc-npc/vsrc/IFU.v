`include "include/defs.vh"

module ysyx_25020039_IFU (
    input         clk,
    input         reset,
    input  [31:0] branch_target,
    input         pc_src,
    input         id_ready,
    input         wb_valid,
    output reg    if_ready,
    output reg    if_valid,
    output reg [31:0] pc,
    output reg [31:0] instr,

    // SimpleBus interface to SRAM
    output reg        ifu_reqValid,
    // input wire        ifu_reqReady,
    output reg [31:0] ifu_addr,
    input wire        ifu_respValid,
    // output reg        ifu_respReady,
    input wire [31:0] ifu_rdata
);
    typedef enum {IDLE, REQ_WAIT, RESP_WAIT, STALL} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'h3000_0000;
            ifu_addr <= 32'h3000_0000;
            ifu_reqValid <= 1'b0;
            // ifu_respReady <= 1'b1;
            if_valid <= 1'b0;
            if_ready <= 1'b1;
            state <= REQ_WAIT;      // Start with first instruction fetch
            instr <= 32'h0000_0000;
        end else begin
            case (state)
                IDLE: begin
                    if_ready <= 1'b1;
                    if_valid <= 1'b0;
                    ifu_reqValid <= 1'b0;
                    // ifu_respReady <= 1'b1;
                    if (wb_valid) begin
                        // Update PC for next instruction
                        pc <= pc_src ? branch_target : pc + 4;
                        ifu_addr <= pc_src ? branch_target : pc + 4;
                        if_ready <= 1'b0;
                        state <= REQ_WAIT;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                
                REQ_WAIT: begin
                    if_ready <= 1'b0;
                    if_valid <= 1'b0;
                    // ifu_respReady <= 1'b1;
                    
                    // Send request and wait for SRAM to be ready
                    ifu_reqValid <= 1'b1;
                    //$display("[IFU] In RESP_WAIT state: ifu_respValid=%b, ifu_respReady=%b, ifu_rdata=0x%08x", ifu_respValid, ifu_respReady, ifu_rdata);
                    // Request handshake: reqValid && reqReady
                    if (ifu_reqValid /*&& ifu_reqReady*/) begin
                        ifu_reqValid <= 1'b0;  // Request accepted, clear valid
                        state <= RESP_WAIT;
                    end
                    else begin
                        state <= REQ_WAIT; // Keep waiting for SRAM ready
                    end
                end
                
                RESP_WAIT: begin
                    if_ready <= 1'b0;
                    if_valid <= 1'b0;
                    ifu_reqValid <= 1'b0;
                    // ifu_respReady <= 1'b1;
                    
                    // Response handshake: respValid && respReady
                    if (ifu_respValid /*&& ifu_respReady*/) begin
                        instr <= ifu_rdata;
                        state <= STALL;
                    end 
                    else begin
                        state <= RESP_WAIT; // Keep waiting for response
                    end
                end
                
                STALL: begin
                    if_ready <= 1'b0;
                    if_valid <= 1'b1;
                    ifu_reqValid <= 1'b0;
                    // ifu_respReady <= 1'b0; // Not ready for new response
                    if (id_ready) begin
                        state <= IDLE;
                    end 
                    else begin
                        state <= STALL;
                    end
                end
                
                default: begin
                    if_ready <= 1'b0;
                    if_valid <= 1'b0;
                    ifu_reqValid <= 1'b0;
                    // ifu_respReady <= 1'b0;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
