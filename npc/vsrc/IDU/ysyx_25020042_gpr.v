`timescale 1ns/1ns 
module ysyx_25020042_gpr  (
    input clock,
    input reset,   
    /* verilator lint_off UNUSEDSIGNAL */
    input  [4:0] i_rs1,
    input  [4:0] i_rs2,
    /* verilator lint_on UNUSEDSIGNAL */
    input  [4:0] i_rd,
    input  [31:0] i_data,
    input  wbu_valid,
    output [31:0] o_src1,
    output [31:0] o_src2
    );
    
    wire [15:0] wen;
    wire [31:0] reg_file [0:15];
    assign wen = wbu_valid? (16'b1 << i_rd) : 16'b0; // 写使能信号

    // reg [31:0] zero;
    reg [31:0] ra;  
    reg [31:0] sp; 
    reg [31:0] gp;  
    reg [31:0] tp;  
    reg [31:0] t0;  
    reg [31:0] t1;  
    reg [31:0] t2;  
    reg [31:0] s0;  
    reg [31:0] s1;  
    reg [31:0] a0;  
    reg [31:0] a1;  
    reg [31:0] a2;  
    reg [31:0] a3;  
    reg [31:0] a4;  
    reg [31:0] a5; 
    always @(posedge clock) begin
        if (reset) begin
            // zero <= 32'b0;
            ra   <= 32'b0;
            sp   <= 32'b0;
            gp   <= 32'b0;
            tp   <= 32'b0;
            t0   <= 32'b0;
            t1   <= 32'b0;
            t2   <= 32'b0;
            s0   <= 32'b0;
            s1   <= 32'b0;
            a0   <= 32'b0;
            a1   <= 32'b0;
            a2   <= 32'b0;
            a3   <= 32'b0;
            a4   <= 32'b0;
            a5   <= 32'b0;
        end else begin
            // if (wen[0]) zero   <= 0;
            if (wen[1]) ra   <= i_data;
            if (wen[2]) sp   <= i_data;
            if (wen[3]) gp   <= i_data;
            if (wen[4]) tp   <= i_data;
            if (wen[5]) t0   <= i_data;
            if (wen[6]) t1   <= i_data;
            if (wen[7]) t2   <= i_data;
            if (wen[8]) s0   <= i_data;
            if (wen[9]) s1   <= i_data;
            if (wen[10]) a0  <= i_data;
            if (wen[11]) a1  <= i_data;
            if (wen[12]) a2  <= i_data;
            if (wen[13]) a3  <= i_data;
            if (wen[14]) a4  <= i_data;
            if (wen[15]) a5  <= i_data;
        end
    end
    assign reg_file [0] = 32'h0;
    assign reg_file [1] = ra;
    assign reg_file [2] = sp;
    assign reg_file [3] = gp;
    assign reg_file [4] = tp;
    assign reg_file [5] = t0;
    assign reg_file [6] = t1;
    assign reg_file [7] = t2;
    assign reg_file [8] = s0;
    assign reg_file [9] = s1;
    assign reg_file [10] = a0;
    assign reg_file [11] = a1;
    assign reg_file [12] = a2;
    assign reg_file [13] = a3;
    assign reg_file [14] = a4;
    assign reg_file [15] = a5;


// 读取寄存器
    assign o_src1 = reg_file[i_rs1[3:0]];
    assign o_src2 = reg_file[i_rs2[3:0]];

endmodule





