module ysyx_25020042_WBU(
    input             clock,
    input             reset,
    input             lsu_valid,
    output reg        wbu_ready,
    output reg        wbu_valid,
    
    input [31:0]      i_data,
    input [31:0]      i_pc_data,
    input             i_B_jump_signal,
    input  [7:0]      i_inst,
    input  [31:0]     i_load_wdata,
    input  [31:0]     i_csr_rdata,
    input  [31:0]     i_mtvec_rdata,
    input  [31:0]     i_mepc_rdata,
    output reg [31:0] csr_wdata,
    output reg [31:0] reg_wdata,
    output reg [31:0] o_mepc_wdata,
    output reg [31:0] o_mcause_wdata,
    output reg [31:0] jump_pc,
    output reg        jump_valid
);

    localparam  NOP_INST     = 3'b000;
    localparam  EXU_INST     = 3'b001;
    localparam  JUMP_INST    = 3'b010;
    localparam  MEM_INST     = 3'b011;
    localparam  CSR_INST     = 3'b100;
    localparam  SPECIAL_INST = 3'b101;

    localparam IDLE = 1'b0;
    localparam WAIT = 1'b1;
    reg  state;



always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        jump_pc <= 32'h0;
        reg_wdata <= 32'b0;
        csr_wdata <= 32'b0;
        wbu_ready <= 1'b1;
        wbu_valid <= 1'b0;
        jump_valid <= 1'b0;
    end
    else begin
        case(state)
            IDLE: begin
                if (lsu_valid & wbu_ready) begin
                    state <= WAIT;
                    wbu_ready <= 1'b0;
                    wbu_valid <= 1'b1;
                    case(i_inst[7:5])
                        JUMP_INST: begin
                            if (i_B_jump_signal == 1'b1) begin
                                jump_pc <= i_data;
                                jump_valid <= 1'b1;
                            end
                            else if (i_inst[4:0] == 5'b00001 || i_inst[4:0] == 5'b00010) begin
                                reg_wdata <= i_pc_data + 4;
                            end
                        end

                        CSR_INST: begin
                            case (i_inst[4:0])
                                5'b00100: begin // mret
                                    jump_pc <= i_mepc_rdata;
                                    jump_valid <= 1'b1;
                                end
                                5'b00011: begin // ecall
                                    jump_pc <= i_mtvec_rdata;
                                    jump_valid <= 1'b1;
                                    o_mepc_wdata <= i_pc_data;
                                    o_mcause_wdata <= 32'd11; // 没有实现特权级转换
                                end
                                default: begin
                                    csr_wdata <= i_data;
                                    reg_wdata <= i_csr_rdata;
                                end
                            endcase
                        end

                        MEM_INST: begin
                            reg_wdata <= i_load_wdata;
                        end

                        default: begin
                            reg_wdata <= i_data;
                        end
                    endcase


                end
                else begin
                    state <= IDLE;
                    if (wbu_valid) begin
                        wbu_ready <= 1'b1;
                        wbu_valid <= 1'b0;
                    end
                end
            end

            WAIT: begin
                jump_valid <= 1'b0;
                wbu_valid <= 1'b0;
                wbu_ready <= 1'b1;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end



endmodule
