`timescale 1ns/1ns 
module ysyx_25020042_PC (
    input              clock,
    input              reset,
    input              ifu_ready,
    input              ifu_handshake,
    input              fault,
    output reg         pc_valid,


    input [31:0] i_jump_pc,
    input              i_jump_valid,
    input [31:0] i_fast_jump_pc,
    input              i_fast_jump_valid,
    output  [31:0] o_pc
    );

    reg [31:0] next_pc;
    reg [31:0] pc;
    assign o_pc = pc;

    always @(posedge clock) begin
        if (reset) begin
            `ifdef PLATFORM_NPC
            next_pc <= 32'h8000_0004;
            `else
            // next_pc <= 32'h3000_0004;
            next_pc <= 32'h8000_0004;

            `endif
        end
        else if (i_jump_valid) begin
            next_pc <= i_jump_pc + 4;
        end
        else if (i_fast_jump_valid) begin
            next_pc <= i_fast_jump_pc + 4;
        end
        else if (ifu_ready & pc_valid) begin
            next_pc <= pc + 4;
        end
        else begin
            next_pc <= next_pc;
        end
    end
    
    always @(posedge clock) begin
        if (reset)begin
            `ifdef PLATFORM_NPC
            pc <= 32'h8000_0000;
            `else
            // o_pc <= 32'h3000_0000;
            pc <= 32'h8000_0000;
            `endif
        end 
        else if (fault)begin
            pc <= 0;
        end
        else if (i_jump_valid) begin
            pc <= i_jump_pc;
        end
        else if (i_fast_jump_valid) begin
            pc <= i_fast_jump_pc;
        end
        else if (ifu_handshake)begin
            pc <= next_pc;
        end
    end

    always @(posedge clock) begin
        if (reset)begin
            pc_valid <= 1'b1;
        end 
        else if (ifu_handshake) 
            pc_valid <= 1'b1;
        else if (i_jump_valid)
            pc_valid <= 1'b1;
        else 
            pc_valid <= ifu_ready ? 1'b0 :pc_valid;
            
    end



endmodule


