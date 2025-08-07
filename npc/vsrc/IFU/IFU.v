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
// import "DPI-C" function int pmem_read(input int raddr, input int len);

localparam IDLE = 1'b0;
localparam WAIT_READY = 1'b1;

reg [31:0] instruction;
reg state;
reg next_state;
wire read_signal;
wire sram_valid;
wire [31:0] sram_data;

assign o_ifu_valid = (state == WAIT_READY) ;
assign o_instruction = instruction; 
assign o_ifu_ready = (state == IDLE) || 
                     (state == WAIT_READY && i_idu_ready); 
assign read_signal = (state == IDLE) && i_pc_valid;

// 状态机转移关系
always @(*) begin
    if(!i_sys_rst_n) begin
        next_state = IDLE;
    end else begin
        case (state)
            IDLE: begin
                // 只有没有待处理指令时才接受新请求
                // if(i_pc_valid && sram_valid) begin
                if(sram_valid) begin
                    next_state = WAIT_READY;
                end
                else begin
                    next_state = IDLE;
                end
            end
            WAIT_READY: begin
                if(i_idu_ready) begin
                    next_state = IDLE;
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
        instruction <= 32'b0;
    end
    else begin
        case (state)
            IDLE: begin
                instruction <= instruction;
                
                if(sram_valid) begin
                    instruction <= sram_data; 
                end
            end
            WAIT_READY: begin end
            default: begin end
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

sram  #(1) sram_u (
    .i_sys_clk(i_sys_clk),
    .i_sys_rst_n(i_sys_rst_n),
    .i_addr(i_pc), // address
    .i_read_signal(read_signal), // read signal
    .o_sram_data(sram_data),
    .o_sram_valid(sram_valid)
);

// 最开始方案，直接从pmem中读出指令，然后赋值给instruction
// assign o_instruction = $unsigned(pmem_read(i_pc, 4)); 

endmodule
