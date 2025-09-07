// Modified by Long for NPC project.
module PC #(PC_LEN = 32)(
    input clock,
    input reset_n,
    input [PC_LEN-1:0] i_next_pc,
    input wbu_valid,
    // output reg pc_valid,
    output reg [PC_LEN-1:0] o_pc
    );
    
    always @(posedge clock) begin
        if (!reset_n)begin
            o_pc <= 32'h80000000;
            // pc_valid <= 1'b1;
        end 
        else if (wbu_valid)begin
            o_pc <= i_next_pc;
            // pc_valid <= 1'b1;
        end
        // else if (pc_valid) begin
        //     pc_valid <= 1'b0;
        // end

    end



endmodule


