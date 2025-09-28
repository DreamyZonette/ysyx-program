`include "include/defs.vh"

module ysyx_25020039_EXU (
    input             clk,
    input             reset,
    input             id_valid,//reg模块的输出是否有效
    output reg        ex_ready,//ex就绪状态
    input      [6:0]  opcode,
    input      [31:0] rs1_val,
    input      [31:0] rs2_val,
    input      [31:0] imm,
    input      [3:0]  alu_op,
    input             mem_ready,//下游mem是否就绪
    output reg        ex_valid,//ex输出是否有效
    output reg [31:0] alu_result
);
    typedef enum { IDLE, STALL } state_t;
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state = IDLE;
            ex_ready = 1'b1;
            ex_valid = 1'b0;
            alu_result = 32'b0;
        end else begin
            state = next_state;
            case (state)
                IDLE: begin
                    ex_ready = 1'b1;
                    ex_valid = 1'b0;
                    if(id_valid) begin
                        ex_ready = 1'b0;
                        ex_valid = 1'b0;
                        case (alu_op)
                             `ALU_ADD:  alu_result = rs1_val + ((opcode[6:2] == `INST_TYPE_R || opcode[6:2] == `INST_TYPE_B) ? rs2_val : imm);
                             `ALU_SUB:  alu_result = rs1_val - ((opcode[6:2] == `INST_TYPE_R || opcode[6:2] == `INST_TYPE_B) ? rs2_val : imm);
                            default:   alu_result = 32'b0;
                        endcase
                        next_state = mem_ready ? STALL : IDLE;
                    end
                    else begin
                        next_state = IDLE;
                    end
                end
                STALL: begin
                    ex_ready = 1'b0;
                    ex_valid = 1'b1;
                    next_state = mem_ready ? IDLE : STALL;
                end
                default: begin
                    ex_ready = 1'b0;
                    ex_valid = 1'b0;
                    next_state = IDLE;
                end
            endcase
        end
    end
    
endmodule




    





    
