// Modified by Long for NPC project.
module PC #(PC_LEN = 32)(
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    input wire i_wbu_valid,
    input wire i_ifu_ready,
    input wire [PC_LEN-1:0] i_next_pc,
    output wire o_pc_valid,
    output wire o_pc_ready, 
    output wire [PC_LEN-1:0] o_pc
    );
    reg [PC_LEN-1:0] pc;
    // reg pc_valid;

    // assign o_pc_valid = pc_valid;
    assign o_pc_valid = i_wbu_valid && i_ifu_ready;
    assign o_pc = pc;
    assign o_pc_ready = i_ifu_ready;
    
    always @(posedge i_sys_clk) begin
        if (!i_sys_rst_n)begin
            pc <= 32'h80000000;
            // pc_valid <= 1;
        end 
        else begin
            if (i_wbu_valid && i_ifu_ready) begin
                pc <= i_next_pc;
                // pc_valid <= 1;
            end
            else if (pc_valid && !i_ifu_ready) begin
                // pc_valid <= 0;
            end
            else begin
                // pc_valid <= 0;
            end
        end
    end

endmodule
