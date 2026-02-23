module ysyx_25020042_WBU(
    input             clock,
    input             reset,
    input             lsu_valid,
    output reg        wbu_ready,
    output reg        wbu_valid,
    
    input [31:0]      i_data,
    input [31:0]      i_pc_data,
    input  [7:0]      i_inst,
    input  [4:0]      i_rd,
    input  [31:0]     i_csr_rdata,
    `ifdef VERILATOR
    input  [31:0]     i_instruction_data,
    `endif
    input  [11:0]     i_csr_addr,
    output reg [4:0]  o_rd,
    output reg [31:0] csr_wdata,
    output reg [11:0] csr_addr,
    output reg [31:0] reg_wdata,
    output reg [31:0] o_mepc_wdata,
    output reg [31:0] o_mcause_wdata
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

`ifdef VERILATOR
    reg [31:0] pc;
    reg [31:0] instruction_data;
    reg        instruction_done;
    always @(posedge clock) begin
        if (reset) begin
            pc <= 0;
            instruction_data <= 0;
            instruction_done <= 0;
        end
        else begin
            instruction_done <= wbu_valid;
            if (lsu_valid & wbu_ready) begin
                instruction_data <= i_instruction_data;
                pc <= i_pc_data;
            end
        end
    end
`endif

always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        reg_wdata <= 32'b0;
        csr_wdata <= 32'b0;
        wbu_ready <= 1'b1;
        wbu_valid <= 1'b0;
        o_rd <= 5'b0;
        o_mepc_wdata <= 32'b0;
        o_mcause_wdata <= 32'b0;
        csr_addr <= 12'b0;
    end
    else begin
        case(state)
            IDLE: begin
                if (lsu_valid & wbu_ready) begin
                    state <= WAIT;
                    wbu_ready <= 1'b0;
                    wbu_valid <= 1'b1;
                    o_rd <= i_rd;
                    case(i_inst[7:5])
                        JUMP_INST: begin
                            if (i_inst[4:0] == 5'b00001 || i_inst[4:0] == 5'b00010) begin
                                reg_wdata <= i_pc_data + 4;
                            end
                        end

                        CSR_INST: begin
                            case (i_inst[4:0])
                                5'b00011: begin // ecall
                                    o_mepc_wdata <= i_pc_data;
                                    o_mcause_wdata <= 32'd11; // 没有实现特权级转换
                                end
                                default: begin
                                    csr_wdata <= i_data;
                                    csr_addr <= i_csr_addr;
                                    reg_wdata <= i_csr_rdata;
                                end
                            endcase
                        end

                        MEM_INST: begin
                            reg_wdata <= i_data;
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
                wbu_valid <= 1'b0;
                wbu_ready <= 1'b1;
                o_rd <= 5'b0;
                csr_addr <= 12'b0;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end



endmodule
