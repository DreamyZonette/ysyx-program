module ysyx_25020042_EXU(
    input wire clock,
    input wire reset,
    input wire idu_valid,
    input wire lsu_ready,
    output reg exu_ready,
    output reg exu_valid,

    `ifdef VERILATOR
    output reg [63:0] performance_counter,
    `endif

    input wire [7:0] i_inst,
    input wire [31:0] i_src1,
    input wire [31:0] i_src2,
    input wire [31:0] i_imm,
    input wire [31:0] i_pc_data,
    input wire [5:0]  i_shamt,
    input wire [31:0] i_csr_data,
    // output reg [7:0] o_instruction_out,
    output reg        o_B_jump_signal,
    output wire [31:0] o_data
);

    localparam  NOP_INST     = 3'b000;
    localparam  EXU_INST     = 3'b001;
    localparam  JUMP_INST    = 3'b010;
    localparam  MEM_INST     = 3'b011;
    localparam  CSR_INST     = 3'b100;
    localparam  SPECIAL_INST = 3'b101;

    reg [31:0] alu_data1;
    reg [31:0] alu_data2;
    reg [3:0] alu_ctrl;
    wire [31:0] alu_out;
    wire equal       = (i_src1 == i_src2);
    wire sign_less   = $signed(i_src1) < $signed(i_src2) ? 1'b1 : 1'b0;
    wire unsign_less = (i_src1 < i_src2);

    assign o_data = alu_out;

    `ifdef VERILATOR
    // reg [63:0] performance_counter;
    always @(posedge clock) begin
        if(reset) 
            performance_counter <= 0;
        else if (idu_valid & exu_ready)
            performance_counter <= performance_counter + 1;
    end
    `endif

    always @(posedge clock) begin
        if (reset) begin
            exu_ready <= 1;
            exu_valid <= 0;
        end
        else if (idu_valid & exu_ready) begin
            exu_ready <= 0;
            exu_valid <= 1;
        end
        else if (lsu_ready & exu_valid) begin
            exu_ready <= 1;
            exu_valid <= 0;
        end
    end

    // always @(posedge clock) begin
    //     if (reset) begin
    //         o_instruction_out <= 0;
    //     end
    //     else if (idu_valid & exu_ready) begin
    //         o_instruction_out <= i_inst;
    //     end
    // end

    always @(*) begin
        o_B_jump_signal = 1'b0;
        if(i_inst[7:5] == JUMP_INST) begin
            case(i_inst[4:0])
            5'b00001:  // jalr
                o_B_jump_signal = 1'b0;
            5'b00010:  // jal
                o_B_jump_signal = 1'b0;
            5'b00011:  // beq
                o_B_jump_signal = equal ? 1'b1 : 1'b0;
            5'b00100:  // bne
                o_B_jump_signal = equal ? 1'b0 : 1'b1;
            5'b00101:  // bge
                o_B_jump_signal = sign_less ? 1'b0 : 1'b1;
            5'b00110:  // bgeu
                o_B_jump_signal = unsign_less ? 1'b0 : 1'b1;   
            5'b00111:  // blt
                o_B_jump_signal = sign_less ? 1'b1 : 1'b0;          
            5'b01000:  // bltu
                o_B_jump_signal = unsign_less ? 1'b1 : 1'b0;           
            default: 
                o_B_jump_signal = 1'b0;
            endcase
        end
    end

// ALUctr[3] | ALUctr[2:0] | ALU操作
// ---------|------------|--------------------------------
// 0        | 000        | 选择加法器输出，做加法
// 1        | 000        | 选择加法器输出，做减法
// ×        | 001        | 选择移位器输出，左移
// 0        | 010        | 做减法，选择带符号小于置位结果输出, Less按带符号结果设置
// 1        | 010        | 做减法，选择无符号小于置位结果输出, Less按无符号结果设置
// ×        | 011        | 选择ALU输入B的结果直接输出
// ×        | 100        | 选择异或输出
// 0        | 101        | 选择移位器输出，逻辑右移
// 1        | 101        | 选择移位器输出，算术右移
// ×        | 110        | 选择逻辑或输出
// ×        | 111        | 选择逻辑与输出
    always @(*) begin
        case(i_inst[7:5])
            EXU_INST: begin
                case(i_inst[4:0])
                    5'b00001: begin//addi 
                        alu_data1 = i_src1;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b0000;
                    end
                    5'b00010: begin // andi
                        alu_data1 = i_src1;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b0111;
                    end
                    5'b00011: begin // xori
                        alu_data1 = i_src1;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b0100;
                    end
                    5'b00100: begin // ori
                        alu_data1 = i_src1;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b0110;
                    end
                    5'b00101: begin//auipc
                        alu_data1 = i_pc_data;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b0000;
                    end
                    5'b00110: begin // lui
                        alu_data1 = 0;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b0011;
                    end
                    5'b00111: begin // srai
                        alu_data1 = i_src1;
                        alu_data2 = {26'b0 ,i_shamt};
                        alu_ctrl = 4'b1101;
                    end
                    5'b01000: begin // slli
                        alu_data1 = i_src1;
                        alu_data2 = {26'b0 ,i_shamt};
                        alu_ctrl = 4'b0001;
                    end
                    5'b01001: begin // slti
                        alu_data1 = i_src1;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b0010;
                    end
                    5'b01010: begin // sltiu
                        alu_data1 = i_src1;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b1010;
                    end
                    5'b01011: begin // srli
                        alu_data1 = i_src1;
                        alu_data2 = {26'b0 ,i_shamt};
                        alu_ctrl = 4'b0101;
                    end
                    5'b01100: begin // sll
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b0001;
                    end
                    5'b01101: begin // add
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b0000;
                    end
                    5'b01110: begin //and
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b0111;
                    end
                    5'b01111: begin //or
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b0110;
                    end
                    5'b10000: begin // xor
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b0100;
                    end
                    5'b10001: begin // sub
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b1000;
                    end
                    5'b10010: begin // slt
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b0010;
                    end
                    5'b10011: begin // sltu
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b1010;
                    end
                    5'b10100: begin // sra
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b0101;
                    end
                    5'b10101: begin // srl
                        alu_data1 = i_src1;
                        alu_data2 = i_src2;
                        alu_ctrl = 4'b1101;
                    end
                    default: begin
                        alu_data1 = 0;
                        alu_data2 = 0;
                        alu_ctrl = 4'b0011;
                    end
                endcase
            end
            JUMP_INST: begin
                case(i_inst[4:0])
                    5'b00001: begin // jalr
                        alu_data1 = i_src1;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b0000;
                    end
                    // 5'b00010: begin // jal
                    //     alu_data1 = i_pc_data;
                    //     alu_data2 = i_imm;
                    //     alu_ctrl = 4'b0000;
                    // end
                    // 5'b00011: begin // beq
                    //     alu_data1 = i_pc_data;
                    //     alu_data2 = i_imm;
                    //     alu_ctrl = 4'b0000;
                    // end
                    // 5'b00100: begin // bne
                    //     alu_data1 = i_pc_data;
                    //     alu_data2 = i_imm;
                    //     alu_ctrl = 4'b0000;
                    // end
                    // 5'b00101: begin // bge
                    //     alu_data1 = i_pc_data;
                    //     alu_data2 = i_imm;
                    //     alu_ctrl = 4'b0000;
                    // end
                    // 5'b00110: begin // bgeu
                    //     alu_data1 = i_pc_data;
                    //     alu_data2 = i_imm;
                    //     alu_ctrl = 4'b0000;
                    // end
                    // 5'b00111: begin // blt
                    //     alu_data1 = i_pc_data;
                    //     alu_data2 = i_imm;
                    //     alu_ctrl = 4'b0000;
                    // end
                    // 5'b01000: begin // bltu
                    //     alu_data1 = i_pc_data;
                    //     alu_data2 = i_imm;
                    //     alu_ctrl = 4'b0000;
                    // end
                    default: begin
                        alu_data1 = i_pc_data;
                        alu_data2 = i_imm;
                        alu_ctrl = 4'b0000;
                    end
                endcase
            end

            MEM_INST: begin
                alu_data1 = i_src1;
                alu_data2 = i_imm;
                alu_ctrl = 4'b0000;
                // case(i_inst[4:0])
                //     5'b00001: begin // lw
                //         alu_data1 = i_src1;
                //         alu_data2 = i_imm;
                //         alu_ctrl = 4'b0000;
                //     end
                //     5'b00010: begin // lh
                //         alu_data1 = i_src1;
                //         alu_data2 = i_imm;
                //         alu_ctrl = 4'b0000;
                //     end
                //     5'b00011: begin // lhu
                //         alu_data1 = i_src1;
                //         alu_data2 = i_imm;
                //         alu_ctrl = 4'b0000;
                //     end
                //     5'b00100: begin // lb
                //         alu_data1 = i_src1;
                //         alu_data2 = i_imm;
                //         alu_ctrl = 4'b0000;
                //     end
                //     5'b00101: begin // lbu
                //         alu_data1 = i_src1;
                //         alu_data2 = i_imm;
                //         alu_ctrl = 4'b0000;
                //     end
                //     5'b00110: begin // sw
                //         alu_data1 = i_src1;
                //         alu_data2 = i_imm;
                //         alu_ctrl = 4'b0000;
                //     end
                //     5'b00111: begin // sh
                //         alu_data1 = i_src1;
                //         alu_data2 = i_imm;
                //         alu_ctrl = 4'b0000;
                //     end
                //     5'b01000: begin // sb
                //         alu_data1 = i_src1;
                //         alu_data2 = i_imm;
                //         alu_ctrl = 4'b0000;
                //     end
                //     default: begin
                //         alu_data1 = 0;
                //         alu_data2 = 0;
                //         alu_ctrl = 4'b0011;
                //     end
                // endcase
            end

            CSR_INST: begin
                case(i_inst[4:0])
                    5'b00001: begin // csrrs
                        alu_data1 = i_src1;
                        alu_data2 = i_csr_data;
                        alu_ctrl = 4'b0110;
                    end
                    5'b00010: begin // csrrw
                        alu_data1 = 0;
                        alu_data2 = i_src1;
                        alu_ctrl = 4'b0011;
                    end
                    5'b00011: begin // ecall
                        alu_data1 = 0;
                        alu_data2 = 0;
                        alu_ctrl = 4'b0011;
                    end
                    5'b00100: begin // mret
                        alu_data1 = 0;
                        alu_data2 = 0;
                        alu_ctrl = 4'b0011;
                    end
                    5'b00101: begin // ebreak
                        alu_data1 = 0;
                        alu_data2 = 0;
                        alu_ctrl = 4'b0011;
                    end
                    default: begin
                        alu_data1 = 0;
                        alu_data2 = 0;
                        alu_ctrl = 4'b0011;
                    end
                endcase
            end

            SPECIAL_INST: begin
                case(i_inst[4:0])
                    5'b00001: begin // fencei
                        alu_data1 = 0;
                        alu_data2 = 0;
                        alu_ctrl = 4'b0011;
                    end
                    default: begin
                        alu_data1 = 0;
                        alu_data2 = 0;
                        alu_ctrl = 4'b0011;
                    end
                endcase
            end

            default: begin
                alu_data1 = 0;
                alu_data2 = 0;
                alu_ctrl = 4'b0011;
            end

        endcase
    end

ysyx_25020042_alu u_alu(
    .data1(alu_data1),
    .data2(alu_data2),
    .ALUctrl(alu_ctrl),
    .o_data(alu_out)
);

endmodule
