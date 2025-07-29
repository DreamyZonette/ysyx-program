module WBU(
    input i_sys_rst_n,
    input [31:0] i_sys_wdata,
    input [31:0] i_cur_pc,
    input i_jalr_signal,
    input i_load_signal,
    input  [31:0] i_load_wdata,
    output [31:0] o_reg_wdata,
    output reg [31:0] o_next_pc = 32'h8000_0004
);
    reg [31:0] reg_wdata;
    wire jump_signal = i_jalr_signal;
    assign o_reg_wdata = reg_wdata;
    always @(*) begin
        if (!i_sys_rst_n) begin
            o_next_pc = 32'h8000_0004;
        end else if (jump_signal == 1'b1)begin
            o_next_pc = i_sys_wdata;
        end else begin
            o_next_pc = i_cur_pc + 4;
        end
    end

    always @(*) begin
        if (i_load_signal == 1'b1) begin
            reg_wdata = i_load_wdata;
        end else if (i_jalr_signal == 1'b1)begin
            reg_wdata = i_cur_pc + 4;
        end
        else begin
            reg_wdata = i_sys_wdata;
        end
    end



endmodule
