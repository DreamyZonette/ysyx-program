module ysyx_25020042_alu #(WIDTH = 32)(
    input      [WIDTH-1:0] src1,
    input      [WIDTH-1:0] src2,
    input      [WIDTH-1:0] imm ,
    input      [WIDTH-1:0] ram_data,
    input      [7:0]       op_ins,
    output reg [WIDTH-1:0] out,
    output reg             ram_signal,
    output reg             jump_signal,
    output reg [WIDTH-1:0] pc_next
    
    );

    always @ (*) begin
        case (op_ins)
            8'h01: out = src1 + imm; // addi   
            8'h02: out = src1 + src2;     //临时
            8'h03: out = ram_data;     //临时    
            default: out = 0;
        endcase
    end
    //临时
    assign ram_signal = 0;
    assign jump_signal = 0;
    assign pc_next = 0;
    
endmodule
