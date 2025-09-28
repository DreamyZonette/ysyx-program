`include "include/defs.vh"

module ysyx_25020039_IDU (
    input             clk,
    input             reset,
    input      [31:0] instr,

    input             ex_ready,//来自EX就绪
    input             if_valid,//IF有效
    output reg        id_ready,//ID就绪
    output reg        id_valid,//ID输出是否有效

    output reg [6:0]  opcode,
    output reg [4:0]  rs1,
    output reg [4:0]  rs2,
    output reg [4:0]  rd,
    output reg [31:0] imm,
    output reg [2:0]  func3,
    output reg [6:0]  func7,
    output reg        RegWrite,
    output reg        MemWrite,
    output reg        MemRead,
    output reg [3:0]  alu_op,
    output reg [2:0]  MemLen
    // input      [31:0] branch_total,
    // input      [31:0] branch_correct
);
    // import "DPI-C" function void sim_exit();
    import "DPI-C" function void dpi_ebreak();
    // 状态机定义
    typedef enum {
        IDLE, //空闲等待指令
        STALL //等待下游握手
    } state_t;
    state_t state, next_state;
    // reg [1:0] delay;
    // parameter DELAY_CYCLES = 1;

    reg [31:0] immI;
    reg [31:0] immU;
    reg [31:0] immS;
    reg [31:0] immB;
    reg [31:0] immJ;
    reg [31:0] immR;
    reg [4:0] get_opcode;
    
    assign immI = {{20{instr[31]}}, instr[31:20]};
    assign immU = {instr[31:12], 12'b0};
    assign immS = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    assign immB = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    assign immJ = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
    assign immR = 32'b0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            opcode    = 7'b0;
            rs1       = 5'b0;
            rs2       = 5'b0;
            rd        = 5'b0;
            imm       = 32'b0;
            func3     = 3'b0;
            func7     = 7'b0;
            RegWrite  = 1'b0;
            MemWrite  = 1'b0;
            MemRead   = 1'b0;
            alu_op    = `ALU_ADD;
            MemLen    = `Mem_Word;
        end
        else begin
            state = next_state;
            case (state)
                IDLE: begin
                    id_ready = 1'b1;  //空闲时准备接收指令
                    id_valid = 1'b0;
                    // delay = DELAY_CYCLES;
                    if(if_valid) begin
                        // instr = instr; 
                        id_ready = 1'b0;    //译码时不接收新指令
                        id_valid = 1'b0;    //译码期间不驱动输出

                        opcode = instr[6:0];
                        rs1    = instr[19:15];
                        rs2    = instr[24:20];
                        rd     = instr[11:7];
                        func3  = instr[14:12];
                        func7  = instr[31:25];

                        imm      = 32'b0;
                        RegWrite = 1'b0;
                        MemWrite = 1'b0;
                        MemRead  = 1'b0;
                        alu_op   = `ALU_ADD;
                        MemLen   = `Mem_Word;
                
                        assign get_opcode = opcode[6:2];

                        case(get_opcode)
                            // LUI
                            `INST_TYPE_LUI: begin
                                imm = immU;
                                RegWrite = 1'b1;
                            end
                            // AUIPC
                            `INST_TYPE_AUIPC: begin
                                imm = immU;
                                RegWrite = 1'b1;
                                alu_op=`ALU_ADD;//PC+imm
                            end
                            // JALR
                            `INST_TYPE_JALR: begin
                                if (func3 == 3'b000) begin
                                    imm = immI;
                                    RegWrite = 1'b1;
                                end
                            end
                            `INST_TYPE_S: begin
                                imm=immS;
                                MemWrite=1'b1;
                                alu_op=`ALU_ADD;
                                case(func3)
                                    `F3_SW: MemLen=`Mem_Word;
                                    `F3_SB: MemLen=`Mem_Bit;
                                    default:;
                                endcase
                            end

                            `INST_TYPE_L: begin
                                if(func3 == `F3_LW) begin
                                    imm=immI;
                                    RegWrite=1'b1;
                                    MemRead=1'b1;
                                    alu_op = `ALU_ADD;
                                    MemLen = `Mem_Word;
                                end
                                else if(func3 == `F3_LBU) begin
                                    imm=immI;
                                    RegWrite=1'b1;
                                    MemRead=1'b1;
                                    alu_op = `ALU_ADD;
                                    MemLen = `Mem_UBit;
                                end
                            end

                            `INST_TYPE_R: begin
                                RegWrite = 1'b1;
                                imm = immR;
                                case (func3)
                                    3'b000:   alu_op = (func7[5]) ? `ALU_SUB : `ALU_ADD; // add, sub
                                    default:;
                                endcase
                            end

                            `INST_TYPE_I: begin
                                imm=immI;
                                RegWrite=1'b1;
                                case(func3)
                                    `F3_ADDI: alu_op = `ALU_ADD;
                                    default:;
                                endcase
                            end

                            `INST_TYPE_E: begin
                                if (instr == `INST_EBREAK) begin
                                    dpi_ebreak();
                                    $display("EBREAK: Simulation exiting...");
                                end
                            end
                            default:;
                        endcase
                        next_state = ex_ready ? STALL : IDLE;
                    end
                    else begin
                        next_state = IDLE;
                    end
                end
                STALL: begin
                    id_ready = 1'b0;
                    id_valid = 1'b1;
                    next_state = ex_ready ? IDLE : STALL;
                end
                default: begin
                    id_valid = 1'b0;
                    id_ready = 1'b0;
                    next_state = IDLE;
                end
            endcase
        end
    end
endmodule
