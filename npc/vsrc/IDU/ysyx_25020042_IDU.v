module ysyx_25020042_IDU (
    input   wire         clock                 ,  
    input   wire         reset                 ,
    input   wire         ifu_valid             ,
    input   wire         exu_ready             ,
    output  reg          idu_ready             ,
    output  reg          idu_valid             ,
    `ifdef VERILATOR
    output reg  [63:0]   csr_perfomance_counter,
    `endif
 
    input  wire          i_jump_valid          ,
    input  wire [31:0]   i_inst                ,
    input  wire [31:0]   i_pc_data             ,
    input  wire [4:0]    i_prev_rd_0           ,
    input  wire [4:0]    i_prev_rd_1           ,
    input  wire [4:0]    i_prev_rd_2           ,
    output reg  [7:0]    o_instruction_out     ,
    `ifdef VERILATOR
    output reg [31:0]    o_instruction_data    ,
    `endif
    output reg  [31:0]   o_imm                 ,
    output reg  [31:0]   o_pc_data             ,
    output reg  [11:0]   o_csr_addr            ,
    output reg  [5:0]    o_shamt               ,
    output reg  [4:0]    o_rd                  ,
    output reg  [4:0]    o_rs1                 ,
    output reg  [4:0]    o_rs2
);

    `ifdef VERILATOR
        always @(posedge clock) begin
            if (reset) begin
                csr_perfomance_counter <= 0;
            end
            if (exu_ready & idu_valid & !raw_hit & csr_valid) begin
                csr_perfomance_counter <= csr_perfomance_counter + 1;
            end
        end
    `endif

    localparam  NOP_INST     = 3'b000;
    localparam  EXU_INST     = 3'b001;
    localparam  JUMP_INST    = 3'b010;
    localparam  MEM_INST     = 3'b011;
    localparam  CSR_INST     = 3'b100;
    localparam  SPECIAL_INST = 3'b101;

    wire csr_valid = (opcode == 7'b1110011);
    wire [6:0] opcode = i_inst[6:0];
    wire [11:7] rd = i_inst[11:7];
    wire [19:15] rs1 = i_inst[19:15];
    wire [24:20] rs2 = i_inst[24:20];
    wire [14:12] funct3 = i_inst[14:12];
    wire [31:25] funct7 = i_inst[31:25];
    wire [31:0]  u_imm = {i_inst[31:12], 12'b0};
    wire [31:0]  i_imm = {{20{i_inst[31]}}, i_inst[31:20]};
    wire [31:0]  s_imm = {{20{i_inst[31]}}, i_inst[31:25], i_inst[11:7]};
    wire [31:0]  b_imm = {{19{i_inst[31]}}, i_inst[31], i_inst[7], i_inst[30:25], i_inst[11:8], 1'b0};
    wire [31:0]  j_imm = {{11{i_inst[31]}}, i_inst[31], i_inst[19:12], i_inst[20], i_inst[30:21], 1'b0};
    wire [24:20] shamt = i_inst[24:20];
    wire [11:0] csr_addr = i_inst[31:20];

    wire u_type_signal = (opcode == 7'b0110111 | opcode == 7'b0010111);
    wire i_type_signal = (opcode == 7'b1100111 | opcode == 7'b0000011 | opcode == 7'b0010011 | opcode == 7'b0001111 | opcode == 7'b1110011);
    wire s_type_signal = (opcode == 7'b0100011);
    wire b_type_signal = (opcode == 7'b1100011);
    wire j_type_signal = (opcode == 7'b1101111);
    wire r_type_signal = (opcode == 7'b0110011);

    reg  raw_hit;
    // reg  [4:0] prev_rd_0;
    // reg  [4:0] prev_rd_1;
    // reg  [4:0] prev_rd_2;

 // RAW check
    // always @(posedge clock) begin
    //     if (reset) begin
    //         prev_rd_0 <= 5'b0;
    //         prev_rd_1 <= 5'b0;
    //         prev_rd_2 <= 5'b0;
    //     end
    //     else begin
    //         if (exu_ready & idu_valid & !raw_hit) begin
    //             prev_rd_1 <= prev_rd_0;
    //             prev_rd_2 <= prev_rd_1;
    //             prev_rd_0 <= (r_type_signal | i_type_signal | u_type_signal | j_type_signal) ? rd : 5'b0;
    //         end
    //         else if (wbu_valid & raw_hit) begin
    //             prev_rd_1 <= prev_rd_0;
    //             prev_rd_2 <= prev_rd_1;
    //             prev_rd_0 <= 5'b0;
    //         end
    //     end
    // end

    always @(*) begin
        raw_hit = 1'b0;
        if ((rd != 0) && (rs1 != 0 || rs2 != 0)) begin
            case (1'b1)
                i_type_signal:  begin
                    raw_hit = (i_prev_rd_0 == rs1) | (i_prev_rd_1 == rs1) | (i_prev_rd_2 == rs1) ? 1'b1 : 1'b0;
                end
                s_type_signal:  begin
                    raw_hit = (i_prev_rd_0 == rs1) | (i_prev_rd_1 == rs1) | (i_prev_rd_2 == rs1) 
                            | (i_prev_rd_0 == rs2) | (i_prev_rd_1 == rs2) | (i_prev_rd_2 == rs2) ? 1'b1 : 1'b0;
                end
                b_type_signal:  begin
                    raw_hit = (i_prev_rd_0 == rs1) | (i_prev_rd_1 == rs1) | (i_prev_rd_2 == rs1) 
                            | (i_prev_rd_0 == rs2) | (i_prev_rd_1 == rs2) | (i_prev_rd_2 == rs2) ? 1'b1 : 1'b0;
                end
                r_type_signal:  begin
                    raw_hit = (i_prev_rd_0 == rs1) | (i_prev_rd_1 == rs1) | (i_prev_rd_2 == rs1) 
                            | (i_prev_rd_0 == rs2) | (i_prev_rd_1 == rs2) | (i_prev_rd_2 == rs2) ? 1'b1 : 1'b0;
                end
                default: raw_hit = 1'b0;
            endcase
        end
    end


    always @ (posedge clock) begin
        if (reset) begin
            idu_ready <= 1'b1;
            idu_valid <= 1'b0;
        end
        else if (i_jump_valid) begin
            idu_ready <= 1'b1;
            idu_valid <= 1'b0;
        end
        else if (ifu_valid & idu_ready) begin
            if (raw_hit) begin
                idu_ready <= 1'b0;
                idu_valid <= 1'b0;
            end
            else begin
                idu_ready <= 1'b0;
                idu_valid <= 1'b1;
            end
        end
        else if (exu_ready & idu_valid & !raw_hit) begin
            idu_ready <= 1'b1;
            idu_valid <= 1'b0;
        end
        else if (!idu_ready & !idu_valid & !raw_hit) begin
            idu_ready <= 1'b0;
            idu_valid <= 1'b1;
        end
    end

    always @ (posedge clock) begin
        if (reset) 
            o_imm <= 32'b0;
        else if (ifu_valid & idu_ready) begin
            case (1'b1)
                u_type_signal: o_imm <= u_imm;
                i_type_signal: o_imm <= i_imm;
                s_type_signal: o_imm <= s_imm;
                j_type_signal: o_imm <= j_imm;
                b_type_signal: o_imm <= b_imm;
                default: o_imm <= 32'b0;
            endcase
        end
    end

    always @ (posedge clock) begin
        if (reset)
            o_rs1 <= 5'b0;
        else if (ifu_valid & idu_ready) begin
            if (r_type_signal | i_type_signal | j_type_signal | b_type_signal | s_type_signal)
                o_rs1 <= rs1;
            else 
                o_rs1 <= 5'b0;
        end
    end

    always @ (posedge clock) begin
        if (reset)
            o_rs2 <= 5'b0;
        else if (ifu_valid & idu_ready) begin
            if (b_type_signal | s_type_signal | r_type_signal)
                o_rs2 <= rs2;
            else
                o_rs2 <= 5'b0;
        end
    end

    always @ (posedge clock) begin
        if (reset) begin
            o_pc_data <= 32'b0;
            `ifdef VERILATOR
                o_instruction_data <= 32'b0;
            `endif
        end
        else if (ifu_valid & idu_ready) begin
            o_pc_data <= i_pc_data;
                `ifdef VERILATOR
                    o_instruction_data <= i_inst;
                `endif
        end
    end

    always @ (posedge clock) begin
        if (reset)
            o_rd <= 5'b0;
        else if (ifu_valid & idu_ready) begin
            if (r_type_signal | i_type_signal | u_type_signal | j_type_signal) 
                o_rd <= rd;
            else
                o_rd <= 5'b0;
        end
    end

    always @ (posedge clock) begin
        if (reset)
            o_csr_addr <= 12'b0;
        else if (ifu_valid & idu_ready) begin
            if (csr_valid)
                o_csr_addr <= csr_addr;
            else 
                o_csr_addr <= 12'b0;
        end
    end

    always @ (posedge clock) begin
        if (reset)
            o_shamt <= 6'b0;
        else if (ifu_valid & idu_ready) begin
            o_shamt <= {1'b0, shamt};
        end
    end

    always @ (posedge clock) begin
        if (reset) begin
            o_instruction_out     <= 8'b0;
        end
        else begin
            if (ifu_valid & idu_ready) begin
                case (1'b1)
                    u_type_signal: begin
                            o_instruction_out[7:5] <= EXU_INST;
                        case (opcode) 
                        7'b0110111:
                            o_instruction_out[4:0] <= 5'b00110;//lui                        
                        7'b0010111:
                            o_instruction_out[4:0] <= 5'b00101;//auipc
                        default:
                            o_instruction_out[4:0] <= 5'b00000; // nop
                        endcase
                    end

                    s_type_signal: begin
                        if (opcode == 7'b0100011) begin
                            o_instruction_out[7:5] <= MEM_INST;
                            case (funct3) 
                            3'b000:
                                o_instruction_out[4:0] <= 5'b01000;//sb
                            3'b001:
                                o_instruction_out[4:0] <= 5'b00111;//sh
                            3'b010:
                                o_instruction_out[4:0] <= 5'b00110;//sw
                            default:
                                o_instruction_out[4:0] <= 5'b00000; // nop
                            endcase
                        end
                        else begin
                            o_instruction_out[7:5] <= NOP_INST;
                            o_instruction_out[4:0] <= 5'b00000;
                        end
                    end

                    i_type_signal: begin
                        case (opcode) 
                        7'b1100111:begin
                            o_instruction_out[7:5] <= JUMP_INST;
                            case (funct3) 
                            3'b000:
                                o_instruction_out[4:0] <= 5'b00001;//jalr
                            default:
                                o_instruction_out[4:0] <= 5'b00000; // nop
                            endcase
                        end
                        7'b0010011: begin
                            o_instruction_out[7:5] <= EXU_INST;
                            case (funct3) 
                            3'b000:
                                o_instruction_out[4:0] <= 5'b00001;//addi
                            3'b001:
                                o_instruction_out[4:0] <= (funct7 == 7'b0000000) ? 5'b01000 : 5'b00000;//slli
                            3'b010:
                                o_instruction_out[4:0] <= 5'b01001;//slti
                            3'b011:
                                o_instruction_out[4:0] <= 5'b01010;//sltiu
                            3'b100:
                                o_instruction_out[4:0] <= 5'b00011;//xori
                            3'b101:begin
                                if (funct7 == 7'b0000000) 
                                    o_instruction_out[4:0] <= 5'b01011;//srli
                                else if (funct7 == 7'b0100000) 
                                    o_instruction_out[4:0] <= 5'b00111;//srai
                                else
                                    o_instruction_out[4:0] <= 5'b00000;//nop
                                end
                            3'b110:
                                o_instruction_out[4:0] <= 5'b00100;//ori
                            3'b111:
                                o_instruction_out[4:0] <= 5'b00010;//andi
                            default:
                                o_instruction_out[4:0] <= 5'b00000; // nop
                            endcase
                        end

                        7'b1110011: begin
                            o_instruction_out[7:5] <= CSR_INST;
                            case (funct3) 
                            3'b000: begin
                                if ({funct7, rs2} == 12'b000000000001) 
                                    o_instruction_out[4:0] <= 5'b00101;//ebreak                              
                                else if ({funct7, rs2} == 12'b000000000000) 
                                    o_instruction_out[4:0] <= 5'b00011;//ecall  
                                else if ({funct7, rs2} == 12'b001100000010) 
                                    o_instruction_out[4:0] <= 5'b00100;//mret                              
                                else
                                     o_instruction_out[4:0] <= 5'b00000;//nop
                            end
                            3'b001:
                                o_instruction_out[4:0] <= 5'b00010;//csrrw
                            3'b010:
                                o_instruction_out[4:0] <= 5'b00001;//csrrs
                            default:
                                o_instruction_out[4:0] <= 5'b00000; // nop
                            endcase
                        end

                        7'b0000011: begin
                            o_instruction_out[7:5] <= MEM_INST;
                            case (funct3) 
                            3'b000:
                                o_instruction_out[4:0] <= 5'b00100;//lb
                            3'b001:
                                o_instruction_out[4:0] <= 5'b00010;//lh
                            3'b010:
                                o_instruction_out[4:0] <= 5'b00001;//lw
                            3'b100:
                                o_instruction_out[4:0] <= 5'b00101;//lbu
                            3'b101:
                                o_instruction_out[4:0] <= 5'b00011;//lhu
                            default:
                                o_instruction_out[4:0] <= 5'b00000; // nop
                            endcase
                        end
                        7'b0001111: begin
                            o_instruction_out[7:5] <= SPECIAL_INST;
                            case (funct3) 
                            3'b001:
                                o_instruction_out[4:0] <= 5'b00001;//fencei
                            default:
                                o_instruction_out[4:0] <= 5'b00000; // nop
                            endcase
                        end
                        default:
                            o_instruction_out[4:0] <= 5'b00000; // nop
                        endcase
                    end

                    r_type_signal: begin
                        o_instruction_out[7:5] <= EXU_INST;
                        if (funct7 == 7'b0000000) begin
                            case (funct3)
                            3'b000:
                                o_instruction_out[4:0] <= 5'b01101;//add
                            3'b001:
                                o_instruction_out[4:0] <= 5'b01100;//sll
                            3'b010:
                                o_instruction_out[4:0] <= 5'b10010;//slt
                            3'b011:
                                o_instruction_out[4:0] <= 5'b10011;//sltu
                            3'b100:
                                o_instruction_out[4:0] <= 5'b10000;//xor
                            3'b101:
                                o_instruction_out[4:0] <= 5'b10101;//srl
                            3'b110:
                                o_instruction_out[4:0] <= 5'b01111;//or
                            3'b111:
                                o_instruction_out[4:0] <= 5'b01110;//and
                            endcase
                        end
                        else if (funct7 == 7'b0100000) begin
                            case (funct3)
                            3'b000:
                                o_instruction_out[4:0] <= 5'b10001;//sub
                            3'b101:
                                o_instruction_out[4:0] <= 5'b10100;//sra
                            default:
                                o_instruction_out[4:0] <= 5'b00000; // nop
                            endcase
                        end
                        else 
                            o_instruction_out[4:0] <= 5'b00000; // nop
                    end

                    b_type_signal: begin
                        o_instruction_out[7:5] <= JUMP_INST;
                        case (funct3) 
                        3'b000:
                            o_instruction_out[4:0] <= 5'b00011;//beq
                        3'b001:
                            o_instruction_out[4:0] <= 5'b00100;//bne
                        3'b100:
                            o_instruction_out[4:0] <= 5'b00111;//blt
                        3'b101:
                            o_instruction_out[4:0] <= 5'b00101;//bge
                        3'b110:
                            o_instruction_out[4:0] <= 5'b01000;//bltu
                        3'b111:
                            o_instruction_out[4:0] <= 5'b00110;//bgeu
                        default:
                            o_instruction_out[4:0] <= 5'b00000; // nop
                        endcase
                    end

                    j_type_signal: begin
                        o_instruction_out[7:5] <= JUMP_INST;
                        o_instruction_out[4:0] <= 5'b00010;//jal
                    end
                endcase
            end
        end
    end

endmodule
