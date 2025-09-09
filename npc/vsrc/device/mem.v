module mem(
    input clock,
    input [31:0] addr,
    input wen,
    // input ren,
    input [31:0] wdata,
    input reqValid,
    input [3:0] wmask,
    output reg [31:0] rdata,
    output reg respValid
);

import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, int len, input int data);

// always @(posedge clock) begin
//     if (reqValid && !wen) begin
//     rdata <= pmem_read(addr, 4);
//     respValid <= 1'b1;
//     end   
//     else if (reqValid && wen) begin
//         /* verilator lint_off WIDTHEXPAND */
//         pmem_write(addr, wmask, wdata);
//         /* verilator lint_on WIDTHEXPAND */
//         respValid <= 1'b1;
//     end
//     if (respValid) begin
//         respValid <= 1'b0;
//     end

// end

//************************延时版本***********************//
// reg [31:0] delay_counter;
// reg [31:0] delay_target;
// reg reqValid_delay;
// reg wen_delay;

// always @(posedge clock) begin
//     if(reqValid) begin
//         reqValid_delay <= reqValid;
//         wen_delay <= wen;
//     end
//     if ((reqValid && !wen) || (reqValid_delay && !wen_delay)) begin
//         if (delay_counter == delay_target) begin
//             rdata <= pmem_read(addr, 4);
//             respValid <= 1'b1;
//             delay_counter <= 0;
//             reqValid_delay <= 1'b0;
//             wen_delay <= 1'b0;
//         end
//         else begin
//             delay_counter <= delay_counter + 1;
//         end
//     end   
//     else if ((reqValid && wen) || (reqValid_delay && wen_delay)) begin
//         if (delay_counter == delay_target) begin
//             /* verilator lint_off WIDTHEXPAND */
//             pmem_write(addr, wmask, wdata);
//             /* verilator lint_on WIDTHEXPAND */
//             respValid <= 1'b1;
//             reqValid_delay <= 1'b0;
//             wen_delay <= 1'b0;
//         end
//         else begin
//             delay_counter <= delay_counter + 1;
//         end
//     end
//     if (respValid) begin
//         respValid <= 1'b0;
//     end

// end

// reg [31:0] lfsr;
// always @(posedge clock) begin
//     if (lfsr == 0) begin
//         lfsr <= 32'hABCDE123;
//     end else if (reqValid) begin
//         lfsr <= {lfsr[30:0], lfsr[31] ^ lfsr[30] ^ lfsr[28] ^ lfsr[25]};
//         delay_target <= lfsr % 10; 
//     end
// end

// 状态定义
reg [1:0] state;
// reg reqValid_delay;
reg wen_delay;
parameter IDLE      = 2'b00;
parameter DELAY     = 2'b01;
parameter RESPOND   = 2'b10;

reg [31:0] delay_counter;
reg [31:0] delay_target;
reg [31:0] lfsr;

// LFSR初始化与更新
always @(posedge clock) begin
    if (lfsr == 0) begin
        lfsr <= 32'hABCDE123; // 初始化LFSR
    end else if (state == IDLE && reqValid) begin
        // 更新LFSR并生成新的随机延迟目标
        lfsr <= {lfsr[30:0], lfsr[31] ^ lfsr[30] ^ lfsr[28] ^ lfsr[25]};
        delay_target <= lfsr % 20; // 生成1-20周期的随机延迟
    end
end

// 主状态机
always @(posedge clock) begin
    
        case (state)
            IDLE: begin
                respValid <= 1'b0;
                delay_counter <= 0;
                if (reqValid) begin
                    state <= DELAY;
                    // reqValid_delay <= reqValid;
                    wen_delay <= wen;
                end
            end
            
            DELAY: begin
                if (delay_counter < delay_target) begin
                    delay_counter <= delay_counter + 1;
                end else begin
                    // 延迟完成，执行操作
                    if (!wen_delay) begin
                        rdata <= pmem_read(addr, 4);
                    end else begin
                        /* verilator lint_off WIDTHEXPAND */
                        pmem_write(addr, wmask, wdata);
                        /* verilator lint_on WIDTHEXPAND */
                    end
                    respValid <= 1'b1;
                    state <= RESPOND;
                end
            end
            
            RESPOND: begin
                respValid <= 1'b0;
                state <= IDLE; // 返回空闲状态
                // reqValid_delay <= 1'b0;
                wen_delay <= 1'b0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    // end
end


endmodule
