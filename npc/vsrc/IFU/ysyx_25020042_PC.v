// Modified by Long for NPC project.
module ysyx_25020042_PC #(PC_LEN = 32)(
    input              clock,
    input              reset,
    input              ifu_ready,
    // input              pc_update,
    input              ifu_handsake,
    input              fault,
    output reg         pc_valid,
    input             icache_busy,


    input [PC_LEN-1:0] i_jump_pc,
    input              i_jump_valid,
    output reg [PC_LEN-1:0] o_pc
    );

    reg [31:0] next_pc;
    // reg jump_signal;

    // always @(posedge clock) begin
    //     if (reset) begin
    //         jump_signal <= 1'b0;
    //     end
    //     else begin
    //         if (i_jump_valid & icache_busy) begin
    //             jump_signal <= 1'b1;
    //         end
    //         else if (!icache_busy) begin
    //             jump_signal <= 1'b0;
    //         end
    //     end
    // end

    always @(posedge clock) begin
        if (reset) begin
            `ifndef PLATFORM_NPC
            next_pc <= 32'h3000_0004;
            `else
            next_pc <= 32'h8000_0004;
            `endif
        end
        // else if (i_jump_valid & icache_busy) begin
        //     next_pc <= i_jump_pc;
        // end
        // else if (i_jump_valid & !icache_busy) begin
        //     next_pc <= i_jump_pc + 4;
        // end
        else if (i_jump_valid) begin
            next_pc <= i_jump_pc + 4;
        end
        else if (ifu_ready & pc_valid) begin
            next_pc <= o_pc + 4;
        end
    end
    
    always @(posedge clock) begin
        if (reset)begin
            `ifndef PLATFORM_NPC
            o_pc <= 32'h3000_0000;
            `else
            o_pc <= 32'h8000_0000;
            `endif
            pc_valid <= 1'b1;
        end 
        else begin
            if (fault)begin
                o_pc <= 0;
            end
            // else if (i_jump_valid & !icache_busy)begin
            //     o_pc <= i_jump_pc;
            // end
            // else if (jump_signal & !icache_busy) begin
            //     o_pc <= next_pc;
            // end
            else if (i_jump_valid) begin
                o_pc <= i_jump_pc;
            end
            else if (ifu_handsake)begin
                o_pc <= next_pc;
            end

            if (ifu_handsake) 
                pc_valid <= 1'b1;
            // else if (i_jump_valid & !icache_busy)
            //     pc_valid <= 1'b1;
            // else if (jump_signal & !icache_busy)
            //     pc_valid <= 1'b1;
            else if (i_jump_valid)
                pc_valid <= 1'b1;
            else if (ifu_ready & pc_valid) 
                pc_valid <= 1'b0;
            
        end

    end



endmodule


