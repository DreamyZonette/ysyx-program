module ysyx_25020042_alu #(WIDTH = 32)(
    input      [WIDTH-1:0] src1,
    input      [WIDTH-1:0] src2,
    input      [WIDTH-1:0] imm ,
    input      [7:0]       op_ins,
    output reg [WIDTH-1:0] out,
    output reg             ram_signal,
    output reg             jump_signal,
    output reg [WIDTH-1:0] pc_next
    );

    always @ (*) begin
        case (op_ins)
            8'h00: out = src1 + imm; // addi            
            default: out = 0;
        endcase
    end
    
endmodule
