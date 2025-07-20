module WBU(
    input i_sys_clk,
    input i_sys_rst_n,
    input [31:0] i_sys_addr,
    input [31:0] i_sys_wdata,
    input i_B_jump_signal,
    input i_jal_signal,
    input i_jalr_signal,
    input i_load_signal,
    input  [31:0] i_load_wdata,
    output [31:0] o_reg_wdata,
    output reg [31:0] o_next_pc
);

    wire jump_signal = i_jalr_signal | i_B_jump_signal | i_jal_signal;
    assign o_reg_wdata = i_load_wdata ? i_load_wdata : i_sys_wdata;

    always @(posedge i_sys_clk or negedge i_sys_rst_n) begin
        if (!i_sys_rst_n) begin
            o_next_pc <= 32'h8000_0000;
        end else if (jump_signal == 1'b1)begin
            o_next_pc <= i_sys_wdata;
        end else begin
            o_next_pc <= i_sys_addr + 4;
        end
    end



endmodule
