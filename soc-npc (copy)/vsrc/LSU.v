`include "include/defs.vh"

module ysyx_25020039_MEM (
    input             clk,
    input             reset,
    input             ex_valid,     // Upstream EX valid
    output reg        mem_ready,    // MEM ready status
    input             wb_ready,     // Downstream WB ready
    output reg        mem_valid,    // MEM output valid
    input             MemRead,
    input             MemWrite,
    input      [31:0] addr,
    input      [31:0] data_in,
    input      [2:0]  MemLen,
    output reg [31:0] data_out,

    // SimpleBus interface to SRAM
    output reg        lsu_reqValid,
    // input wire        lsu_reqReady,
    output reg [31:0] lsu_addr,
    output reg        lsu_wen,
    output reg [31:0] lsu_wdata,
    output reg [3:0]  lsu_wmask,
    input wire        lsu_respValid,
    // output reg        lsu_respReady,
    input wire [31:0] lsu_rdata,
    output reg [1:0]  lsu_size
);
    // State machine definition
    typedef enum {IDLE, REQ_WAIT, RESP_WAIT, STALL} state_t;
    state_t state, next_state;
    
    reg is_read_op;
    reg [2:0] mem_len_reg;
    reg [1:0] addr_offset_reg;
    wire [1:0] addr_offset = addr[1:0];

    wire [31:0] shifted_rdata;
    assign shifted_rdata = lsu_rdata >> (addr_offset_reg * 8);

    always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= IDLE;
        mem_ready <= 1'b1;
        mem_valid <= 1'b0;
        data_out <= 32'h0;
        lsu_reqValid <= 1'b0;
        // lsu_respReady <= 1'b1;
        lsu_addr <= 32'h0;
        lsu_wen <= 1'b0;
        lsu_wdata <= 32'h0;
        lsu_wmask <= 4'b0000;
        is_read_op <= 1'b0;
        mem_len_reg <= 3'b0;
        addr_offset_reg <= 2'b0;
        lsu_size <= 2'b00;
    end
    else begin
        case(state)
            IDLE: begin
                mem_ready <= 1'b1;
                mem_valid <= 1'b0;
                lsu_reqValid <= 1'b0;
                // lsu_respReady <= 1'b1;
                
                if(ex_valid && mem_ready) begin
                    lsu_addr <= addr;
                    mem_len_reg <= MemLen;
                    addr_offset_reg <= addr_offset;
                    mem_ready <= 1'b0;

                    case(MemLen)
                        `Mem_Bit:  lsu_size <= 2'b00;  // 1字节
                        `Mem_Half: lsu_size <= 2'b01;  // 2字节
                        `Mem_Word: lsu_size <= 2'b10;  // 4字节
                        default:   lsu_size <= 2'b00;
                    endcase
                    
                    if(MemRead) begin
                        is_read_op <= 1'b1;
                        lsu_wen <= 1'b0;
                        lsu_wdata <= 32'h0;
                        lsu_wmask <= 4'b0000;
                        state <= REQ_WAIT;
                    end
                    else if(MemWrite) begin
                        is_read_op <= 1'b0;
                        lsu_wen <= 1'b1;
                        lsu_wdata <= data_in << (addr_offset * 8);
                        case(MemLen)
                            `Mem_Bit:  lsu_wmask <= 4'b0001 << addr_offset;
                            `Mem_Half: lsu_wmask <= 4'b0011 << addr_offset;
                            `Mem_Word: lsu_wmask <= 4'b1111;
                            default:   lsu_wmask <= 4'b1111;
                        endcase
                        state <= REQ_WAIT;
                    end
                    else begin
                        data_out <= 32'h0;
                        state <= STALL;
                    end
                end
                else begin
                    state <= IDLE;
                end
            end

            REQ_WAIT: begin
                mem_ready <= 1'b0;
                mem_valid <= 1'b0;
                // lsu_respReady <= 1'b1;
                lsu_reqValid <= 1'b1;
                if(lsu_reqValid /*&& lsu_reqReady*/) begin
                    lsu_reqValid <= 1'b0;
                    state <= RESP_WAIT;
                end
                else begin
                    state <= REQ_WAIT;
                end
            end

            RESP_WAIT: begin
                mem_ready <= 1'b0;
                mem_valid <= 1'b0;
                lsu_reqValid <= 1'b0;
                // lsu_respReady <= 1'b1;
                if(lsu_respValid /*&& lsu_respReady*/) begin
                    if(is_read_op) begin
                        case(mem_len_reg)
                            `Mem_Bit:   data_out <= {{24{shifted_rdata[7]}},shifted_rdata[7:0]}; 
                            `Mem_UBit:  data_out <= {24'b0,shifted_rdata[7:0]};
                            `Mem_UHalf: data_out <= {16'b0,shifted_rdata[15:0]};
                            `Mem_Half:  data_out <= {{16{shifted_rdata[15]}},shifted_rdata[15:0]};
                            `Mem_Word:  data_out <= lsu_rdata;
                            default:    data_out <= lsu_rdata;
                        endcase
                    end else begin
                        data_out <= 32'h0;
                    end
                    state <= STALL;
                end
                else begin
                    state <= RESP_WAIT;
                end
            end
            
            STALL: begin
                mem_ready <= 1'b0;
                mem_valid <= 1'b1;
                lsu_reqValid <= 1'b0;
                // lsu_respReady <= 1'b0;
                
                if(wb_ready) begin
                    state <= IDLE;
                end
                else begin
                    state <= STALL;
                end
            end

            default: begin
                mem_ready <= 1'b0;
                mem_valid <= 1'b0;
                lsu_reqValid <= 1'b0;
                // lsu_respReady <= 1'b0;
                state <= IDLE;
            end
        endcase
    end
end
endmodule

