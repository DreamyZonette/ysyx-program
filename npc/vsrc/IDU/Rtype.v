module Rtype (
    input [31:0] i_inst,
    output [4:0] o_rd,
    output [4:0] o_rs1,
    output [4:0] o_rs2,
    output reg o_add_signal
);

    wire [2:0] fun1;
    wire [6:0] fun2;
    wire [6:0] opcode;

    assign opcode = i_inst[6:0];
    assign o_rd   = i_inst[11:7];
    assign fun1   = i_inst[14:12];
    assign o_rs1  = i_inst[19:15];
    assign o_rs2  = i_inst[24:20];
    assign fun2   = i_inst[31:25];

    always @ (*) begin
        // 初始化
        o_add_signal = 1'b0;

        // 指令识别
        case (opcode)
            7'b0110011: begin
                if (fun1 == 3'b000 && fun2 == 0000000) begin
                    o_add_signal   = 1'b1;
                end
            end
            //待扩展
            default: begin
                
            end
        endcase
    end


endmodule
