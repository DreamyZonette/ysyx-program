// Modified by Long for NPC project.
module ysyx_25020042_PC #(PC_LEN = 32)(
    input              clock,
    input              reset,
    input              ifu_ready,
    input              fault,
    output reg         pc_valid,


    input [PC_LEN-1:0] i_jump_pc,
    input              i_jump_valid,
    output reg [PC_LEN-1:0] o_pc
    );
    
    always @(posedge clock) begin
        if (reset)begin
            `ifndef PLATFORM_NPC
            o_pc <= 32'h3000_0000 - 4;
            `else
            o_pc <= 32'h8000_0000 - 4;
            `endif
            pc_valid <= 1'b1;
        end 
        else begin
            if (fault)begin
                o_pc <= 0;
            end
            else if (i_jump_valid) begin
                o_pc <= i_jump_pc;
                pc_valid <= 1'b1;
            end
            else if (ifu_ready)begin
                pc_valid <= 1'b1;
                o_pc <= o_pc + 4;
            end

            if (ifu_ready & pc_valid) begin
                pc_valid <= 1'b0;
            end
        end

    end



endmodule


