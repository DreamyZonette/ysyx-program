module ysyx_25020042_gpr  (
    input clock,
    input reset,   
    input  [4:0] i_rs1,
    input  [4:0] i_rs2,
    input  [4:0] i_rd,
    input  [31:0] i_data,
    input  wbu_valid,
    output [31:0] o_src1,
    output [31:0] o_src2
    );
    
    /* verilator lint_off UNUSEDSIGNAL */
    wire [15:0] wen;
    /* verilator lint_on UNUSEDSIGNAL */
    wire [31:0] reg_file [0:15];

    export "DPI-C" function get_register_value;
    function int unsigned get_register_value(input int idx);
    // $display("当前模块的完整路径: %m");
        if (idx >= 0 && idx <= 15) begin
            return reg_file[idx];
        end else begin
            return 32'h0;
        end
    endfunction

    assign wen = (i_rd != 5'b0) && wbu_valid? (16'b1 << i_rd) : 16'b0; // 写使能信号

    // // 生成 16 个寄存器
    // ysyx_25020042_Reg #(32, 32'b0) zero (clock, reset, i_data, reg_file[0],  wen[0]);
    // ysyx_25020042_Reg #(32, 32'b0) ra   (clock, reset, i_data, reg_file[1],  wen[1]);
    // ysyx_25020042_Reg #(32, 32'b0) sp   (clock, reset, i_data, reg_file[2],  wen[2]);
    // ysyx_25020042_Reg #(32, 32'b0) gp   (clock, reset, i_data, reg_file[3],  wen[3]);
    // ysyx_25020042_Reg #(32, 32'b0) tp   (clock, reset, i_data, reg_file[4],  wen[4]);
    // ysyx_25020042_Reg #(32, 32'b0) t0   (clock, reset, i_data, reg_file[5],  wen[5]);
    // ysyx_25020042_Reg #(32, 32'b0) t1   (clock, reset, i_data, reg_file[6],  wen[6]);
    // ysyx_25020042_Reg #(32, 32'b0) t2   (clock, reset, i_data, reg_file[7],  wen[7]);
    // ysyx_25020042_Reg #(32, 32'b0) s0   (clock, reset, i_data, reg_file[8],  wen[8]);
    // ysyx_25020042_Reg #(32, 32'b0) s1   (clock, reset, i_data, reg_file[9],  wen[9]);
    // ysyx_25020042_Reg #(32, 32'b0) a0   (clock, reset, i_data, reg_file[10], wen[10]);
    // ysyx_25020042_Reg #(32, 32'b0) a1   (clock, reset, i_data, reg_file[11], wen[11]);
    // ysyx_25020042_Reg #(32, 32'b0) a2   (clock, reset, i_data, reg_file[12], wen[12]);
    // ysyx_25020042_Reg #(32, 32'b0) a3   (clock, reset, i_data, reg_file[13], wen[13]);
    // ysyx_25020042_Reg #(32, 32'b0) a4   (clock, reset, i_data, reg_file[14], wen[14]);
    // ysyx_25020042_Reg #(32, 32'b0) a5   (clock, reset, i_data, reg_file[15], wen[15]);

     reg [31:0] zero;
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
            zero <= 32'b0;
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
    assign reg_file [0] = zero;
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
/* verilator lint_off WIDTHTRUNC */
    assign o_src1 = (i_rs1 == 5'b0)? 32'b0 : reg_file[i_rs1];
    assign o_src2 = (i_rs2 == 5'b0)? 32'b0 : reg_file[i_rs2];
/* verilator lint_on WIDTHTRUNC */

endmodule





