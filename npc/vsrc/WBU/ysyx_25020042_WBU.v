module ysyx_25020042_WBU(
    input             clock,
    input             reset,
    input             lsu_valid,
    output reg        wbu_ready,
    output reg        wbu_valid,
    
    input [31:0]      i_data,
    input [31:0]      i_pc_data,
    input  [7:0]      i_inst,
    `ifdef VERILATOR
    input  [31:0]     i_instruction_data,
    `endif
    input  [11:0]     i_csr_addr,
    output reg [31:0] csr_wdata,
    output reg [11:0] csr_addr,
    output reg [31:0] o_mepc_wdata,
    output reg [31:0] o_mcause_wdata
);

    localparam  CSR_INST     = 3'b100;

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
        csr_wdata <= 32'b0;
        wbu_ready <= 1'b1;
        wbu_valid <= 1'b0;
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
                    case(i_inst[7:5])
                        CSR_INST: begin
                            case (i_inst[4:0])
                                5'b00011: begin // ecall
                                    o_mepc_wdata <= i_pc_data;
                                    o_mcause_wdata <= 32'd11; // 没有实现特权级转换
                                end
                                default: begin
                                    csr_wdata <= i_data;
                                    csr_addr <= i_csr_addr;
                                end
                            endcase
                        end

                        default: begin
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
                // o_rd <= 5'b0;
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
