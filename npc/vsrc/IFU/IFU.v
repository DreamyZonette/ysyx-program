module IFU(
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    input wire [31:0] i_pc,
    input wire i_pc_valid,
    input wire i_idu_ready,
    output wire o_ifu_valid,
    output wire o_ifu_ready,
    output wire [31:0] o_instruction
);
import "DPI-C" function int pmem_read(input int raddr, input int len);

localparam IDLE = 1'b0;
localparam WAIT_READY = 1'b1;

reg [31:0] instruction;
reg ifu_valid;
reg state;
reg next_state;

assign o_ifu_valid = ifu_valid;
assign o_instruction = instruction; 
assign o_ifu_ready = (state == IDLE) || 
                     (state == WAIT_READY && i_idu_ready); 

// 状态机转移关系
always @(*) begin
    if(!i_sys_rst_n) begin
        next_state = IDLE;
    end else begin
        case (state)
            IDLE: begin
                // 只有没有待处理指令时才接受新请求
                if(i_pc_valid) begin
                    next_state = WAIT_READY;
                end
                else begin
                    next_state = IDLE;
                end
            end
            WAIT_READY: begin
                if(i_idu_ready) begin
                    next_state = i_pc_valid ? WAIT_READY : IDLE;
                end else begin
                    next_state = WAIT_READY;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
end

// 状态机状态处理
always @(posedge i_sys_clk) begin
    if(!i_sys_rst_n) begin
        ifu_valid <= 1'b0;
        instruction <= 32'b0;
    end
    else begin
        case (state)
            IDLE: begin
                ifu_valid <= ifu_valid;
                instruction <= instruction;
                
                if(i_pc_valid && !ifu_valid) begin
                    instruction <= $unsigned(pmem_read(i_pc, 4)); 
                    ifu_valid <= 1'b1;
                end
            end
            WAIT_READY: begin
                instruction <= instruction;
                ifu_valid <= 1'b0;

                if (i_idu_ready == 1'b1) begin
                    ifu_valid <= 1'b0;
                    
                    if(i_pc_valid) begin
                        instruction <= $unsigned(pmem_read(i_pc, 4)); 
                        ifu_valid <= 1'b1; // 保持有效状态
                    end
                end
            end
            default: begin
                instruction <= instruction;
                ifu_valid <= ifu_valid;
            end
        endcase 
    end
end

// 状态机状态更新
always @(posedge i_sys_clk) begin
    if(i_sys_rst_n == 1'b0) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// 最开始方案，直接从pmem中读出指令，然后赋值给instruction
// assign o_instruction = $unsigned(pmem_read(i_pc, 4)); 

endmodule
