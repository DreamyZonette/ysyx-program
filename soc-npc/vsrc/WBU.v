`include "include/defs.vh"

module ysyx_25020039_WBU (
    input              clk,
    input              reset,
    input              mem_valid,
    input              if_ready,
    input       [6:0]  opcode,
    input       [2:0]  func3,
    input       [4:0]  id_rd,
    input              id_RegWrite,
    input       [4:0]  rs1,
    input       [4:0]  rs2,
    input       [31:0] pc,
    input       [31:0] imm,
    input       [31:0] alu_result,
    input       [31:0] data_out,
    output wire [31:0] rs1_val,
    output wire [31:0] rs2_val,
    output reg         wb_ready,
    output reg         wb_valid,
    output reg [31:0]  jalr_target,
    output reg         is_jalr,
    output reg [31:0]  wb_data
);
    typedef enum {IDLE, STALL} state_t;
    state_t state, next_state;

    reg        RegWrite_wb;
    reg [4:0]  rd_wb;
    reg [4:0]  rd_wb_pre;
    reg [31:0] regs [0:31];
    assign rs1_val = (rs1 != 0) ? regs[rs1] : 0;
    assign rs2_val = (rs2 != 0) ? regs[rs2] : 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state = STALL;
            wb_ready = 1'b1;
            wb_valid = 1'b1;
            jalr_target = 32'h0;
            is_jalr = 1'b0;
            wb_data = 32'h0;
            for(integer i = 0; i < 32; i = i + 1) begin
                regs[i] <= 32'h0;
            end
        end else begin
            state = next_state;
            case (state)
                IDLE: begin
                    wb_ready = 1'b1;
                    wb_valid = 1'b0;
                    if(mem_valid) begin
                        wb_ready = 1'b0;
                        wb_valid = 1'b0;
                        jalr_target = (rs1_val + imm) & ~32'h1;
                        is_jalr = (opcode == `INST_JALR) & (func3 == 3'b000);
                        // 写回数据选择
                        wb_data = (opcode == `INST_LUI) ? imm :// LUI
                                        (opcode == `INST_AUIPC) ? (pc + imm) :// AUIPC
                                        (opcode == `INST_JALR) ? (pc + 4) : // JAL, JALR
                                        (opcode == `INST_LW) ? data_out :// LW
                                        (opcode == `INST_R || opcode == `INST_I) ? alu_result : 32'b0;
                        //=====写回数据=====
                        rd_wb = id_rd;
                        RegWrite_wb = id_RegWrite;
                        if(RegWrite_wb && rd_wb != 0) begin
                            //$display("[WBU] Write regs[%0d] = 0x%08x", rd_wb_pre, wb_data);
                            regs[rd_wb] <= wb_data;
                        end
                        next_state = if_ready ? STALL : IDLE;
                    end else begin
                        next_state = IDLE;
                    end
                end
                STALL: begin
                    wb_ready = 1'b0;
                    wb_valid = 1'b1;
                    next_state = if_ready ? IDLE : STALL;
                end
                default: begin
                    wb_ready = 1'b0;
                    wb_valid = 1'b0;
                    next_state = IDLE;
                end
            endcase
        end
    end

endmodule