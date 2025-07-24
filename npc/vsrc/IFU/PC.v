// Modified by Long for NPC project.
module PC #(PC_LEN = 32)(
    input i_sys_clk,
    input i_sys_rst_n,
    input [PC_LEN-1:0] i_next_pc,
    output reg [PC_LEN-1:0] o_cur_pc = 32'h80000000,
    output reg [PC_LEN-1:0] o_next_pc = 32'h80000000
    );
    
    always @(posedge i_sys_clk) begin
        if (!i_sys_rst_n)begin
            o_next_pc <= 32'h80000000;
            o_cur_pc <= 32'h80000000;
            $display("PC Reset: PC = 0x%h", 32'h80000000);
        end 
        else begin
            o_cur_pc <= o_next_pc;
            o_next_pc <= i_next_pc;
            //$display("PC Update: next_pc = 0x%h, pc = 0x%h", i_next_pc, o_pc);
        end
    end



endmodule


