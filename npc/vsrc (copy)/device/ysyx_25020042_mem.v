module ysyx_25020042_mem(
    input clock,
    // axi 握手信号
    input [31:0] slave_araddr,
    input slave_arvalid,
    output reg slave_arready,

    output reg [31:0] slave_rdata,
    output reg slave_rvalid,
    output reg [1:0] slave_rresp,
    input slave_rready,

    input [31:0] slave_awaddr,
    input slave_awvalid,
    output reg slave_awready,

    input [31:0] slave_wdata,
    input [3:0] slave_wstrb,
    input slave_wvalid,
    output reg slave_wready,

    output reg slave_bvalid,
    input slave_bready,
    output reg [1:0] slave_bresp
);

import "DPI-C" function int pmem_read(input int addr, input int len);
import "DPI-C" function void pmem_write(
    input int addr, int len, input int data);


reg [2:0] state;
localparam IDLE = 3'd0;
localparam READ = 3'd1;
localparam READ_WAIT = 3'd2;
localparam WRITE = 3'd3;
localparam WRITE_WAIT = 3'd4;

always @(posedge clock) begin
    case (state)
        IDLE: begin
            if (slave_arvalid) begin
                slave_arready <= 1'b1;
                state <= READ;
            end
            else if (slave_awvalid && slave_wvalid) begin
                slave_awready <= 1'b1;
                slave_wready <= 1'b1;
                state <= WRITE;
            end
        end
        READ: begin
            if (slave_arready) begin
                slave_arready <= 1'b0;
            end
            slave_rdata <= pmem_read(slave_araddr, 4);
            slave_rvalid <= 1'b1;
            slave_rresp <= 2'b00;
            state <= READ_WAIT;
        end
        READ_WAIT: begin
            if (slave_rready) begin
                slave_rvalid <= 1'b0;
                slave_rresp <= 2'b00;
                slave_rdata <= 32'b0;
                state <= IDLE;
            end
        end
        WRITE: begin
            if (slave_awready || slave_wready) begin
                slave_awready <= 1'b0;
                slave_wready <= 1'b0;
            end
            /* verilator lint_off WIDTHEXPAND */
            pmem_write(slave_awaddr, slave_wstrb, slave_wdata);
            /* verilator lint_on WIDTHEXPAND */
            state <= WRITE_WAIT;
            slave_bresp <= 2'b00;
            slave_bvalid <= 1'b1;
        end
        WRITE_WAIT: begin
            if (slave_bready) begin
                slave_bvalid <= 1'b0;
                slave_bresp <= 2'b00;
                state <= IDLE;
            end
        end
        default: begin
            state <= IDLE;
        end
    endcase 
end

// IDLE: begin
        //     if (reqValid) begin
        //         respValid <= 1'b1;
        //         reqReady <= 1'b1;
        //         state <= READ;
        //         if (!wen) begin
        //             rdata <= pmem_read(addr, 4);
        //         end   
        //         else begin
        //             /* verilator lint_off WIDTHEXPAND */
        //             pmem_write(addr, wmask, wdata);
        //             /* verilator lint_on WIDTHEXPAND */
        //         end
                
        //     end
        //     else begin
        //         state <= IDLE;
        //     end
        // end
        // READ: begin
        //     if (reqReady) begin
        //         reqReady <= 1'b0;
        //     end
        //     if (respReady) begin
        //         respValid <= 1'b0;
        //         state <= IDLE;
        //     end
        // end

//************************延时版本***********************//


// // 状态定义
// reg [1:0] state;
// // reg reqValid_delay;
// reg wen_delay;
// parameter IDLE      = 2'b00;
// parameter DELAY     = 2'b01;
// parameter RESPOND   = 2'b10;

// reg [31:0] delay_counter;
// reg [31:0] delay_target;
// reg [31:0] lfsr;

// // LFSR初始化与更新
// always @(posedge clock) begin
//     if (lfsr == 0) begin
//         lfsr <= 32'hABCDE123; // 初始化LFSR
//     end else if (state == IDLE && reqValid) begin
//         // 更新LFSR并生成新的随机延迟目标
//         lfsr <= {lfsr[30:0], lfsr[31] ^ lfsr[30] ^ lfsr[28] ^ lfsr[25]};
//         delay_target <= lfsr % 20; // 生成1-20周期的随机延迟
//     end
// end

// // 主状态机
// always @(posedge clock) begin
    
//         case (state)
//             IDLE: begin
//                 respValid <= 1'b0;
//                 delay_counter <= 0;
//                 if (reqValid) begin
//                     state <= DELAY;
//                     // reqValid_delay <= reqValid;
//                     wen_delay <= wen;
//                 end
//             end
            
//             DELAY: begin
//                 if (delay_counter < delay_target) begin
//                     delay_counter <= delay_counter + 1;
//                 end else begin
//                     // 延迟完成，执行操作
//                     if (!wen_delay) begin
//                         rdata <= pmem_read(addr, 4);
//                     end else begin
//                         /* verilator lint_off WIDTHEXPAND */
//                         pmem_write(addr, wmask, wdata);
//                         /* verilator lint_on WIDTHEXPAND */
//                     end
//                     respValid <= 1'b1;
//                     state <= RESPOND;
//                 end
//             end
            
//             RESPOND: begin
//                 respValid <= 1'b0;
//                 state <= IDLE; // 返回空闲状态
//                 // reqValid_delay <= 1'b0;
//                 wen_delay <= 1'b0;
//             end
//             default: begin
//                 state <= IDLE;
//             end
//         endcase
//     // end
// end


endmodule
