`include "include/defs.vh"

module SRAM #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter MAX_DELAY  = 4,
    parameter MIN_DELAY  = 1
)(
    input  wire                   clk,
    input  wire                   reset,

    // IFU SimpleBus interface
    input  wire                   ifu_reqValid,
    //output reg                    ifu_reqReady,
    input  wire [31:0]            ifu_addr,
    output reg                    ifu_respValid,
    //input  wire                   ifu_respReady,
    output reg  [31:0]            ifu_rdata,
    
    // LSU SimpleBus interface
    input  wire                   lsu_reqValid,
    //output reg                    lsu_reqReady,
    input  wire [31:0]            lsu_addr,
    input  wire                   lsu_wen,    // 1=写，0=读
    input  wire [31:0]            lsu_wdata,
    input  wire [3:0]             lsu_wmask,
    output reg                    lsu_respValid,
    //input  wire                   lsu_respReady,
    output reg  [31:0]            lsu_rdata
);

    import "DPI-C" function int unsigned pmem_read(input int unsigned raddr, input int len);
    import "DPI-C" function void pmem_write(input int unsigned waddr, input int unsigned wdata, input int len);

    typedef enum {IFU_IDLE, IFU_DELAY, IFU_RESP} ifu_state_t;
    ifu_state_t ifu_state, ifu_next_state;
    reg [31:0] ifu_delay_counter; // 延迟计数器
    reg [31:0] ifu_addr_reg;      // 锁存取指地址

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            ifu_state = IFU_IDLE;
            //ifu_reqReady <= 1'b1;   // 空闲时准备接收IFU请求
            ifu_respValid <= 1'b0;  // 初始无响应
            ifu_rdata <= 32'h0;     // 初始读数据为0
            ifu_delay_counter <= 0;
            ifu_addr_reg <= 32'h0;
        end
        else begin
            ifu_state = ifu_next_state; 
            case(ifu_state)
                IFU_IDLE: begin
                    //ifu_reqReady <= 1'b1;
                    ifu_respValid <= 1'b0;

                    if(ifu_reqValid /*&& ifu_reqReady*/) begin
                        ifu_addr_reg <= ifu_addr;
                        //ifu_reqReady <= 1'b0;
                        ifu_delay_counter <= $urandom_range(MIN_DELAY, MAX_DELAY);
                        ifu_next_state = IFU_DELAY;
                    end
                    else begin
                        ifu_next_state = IFU_IDLE;
                    end
                end
                IFU_DELAY: begin
                    //ifu_reqReady <= 1'b0;
                    ifu_respValid <= 1'b0;

                    if(ifu_delay_counter > 0) begin
                        ifu_delay_counter <= ifu_delay_counter - 1;
                        ifu_next_state = IFU_DELAY;
                    end
                    else begin
                        ifu_rdata <= pmem_read(ifu_addr_reg, 4);
                        ifu_respValid <= 1'b1;
                        ifu_next_state = IFU_RESP;
                    end
                end
                IFU_RESP: begin
                    //ifu_reqReady <= 1'b0;
                    ifu_respValid <= 1'b1;
                    if(ifu_respValid /*&& ifu_respReady*/) begin
                        ifu_respValid <= 1'b0;
                        //ifu_reqReady <= 1'b1;
                        ifu_next_state = IFU_IDLE;
                    end
                    else begin
                        ifu_next_state = IFU_RESP;
                    end
                end
                default: begin
                    ifu_next_state = IFU_IDLE;
                end
            endcase
        end
    end

    // -------------------------- 3. LSU状态机（数据访问，支持读写） --------------------------
    typedef enum {LSU_IDLE, LSU_DELAY, LSU_RESP} lsu_state_t;
    lsu_state_t lsu_state, lsu_next_state;
    reg [31:0] lsu_delay_counter;
    reg [31:0] lsu_addr_reg;
    reg [31:0] lsu_wdata_reg;
    reg [3:0]  lsu_wmask_reg;
    reg        lsu_wen_reg;

    always @(*) begin
        case(lsu_state)
            LSU_IDLE: begin
                if(lsu_reqValid /*&& lsu_reqReady*/) begin
                    lsu_next_state = LSU_DELAY;
                end else begin
                    lsu_next_state = LSU_IDLE;
                end
            end
            
            LSU_DELAY: begin
                if(lsu_delay_counter > 0) begin
                    lsu_next_state = LSU_DELAY;
                end else begin
                    lsu_next_state = LSU_RESP;
                end
            end
            
            LSU_RESP: begin
                if(lsu_respValid /*&& lsu_respReady*/) begin
                    lsu_next_state = LSU_IDLE;
                end else begin
                    lsu_next_state = LSU_RESP;
                end
            end
            
            default: lsu_next_state = LSU_IDLE;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            lsu_state <= LSU_IDLE;
            // lsu_reqReady <= 1'b1;
            lsu_respValid <= 1'b0;
            lsu_rdata <= 32'h0;
            lsu_delay_counter <= 0;
            lsu_addr_reg <= 32'h0;
            lsu_wdata_reg <= 32'h0;
            lsu_wmask_reg <= 4'b0000;
            lsu_wen_reg <= 1'b0;
        end
        else begin
            lsu_state <= lsu_next_state;
            
            case(lsu_state)
                LSU_IDLE: begin
                    // lsu_reqReady <= 1'b1;
                    lsu_respValid <= 1'b0;
                    
                    if(lsu_reqValid /*&& lsu_reqReady*/) begin
                        lsu_addr_reg <= lsu_addr;
                        lsu_wdata_reg <= lsu_wdata;
                        lsu_wmask_reg <= lsu_wmask;
                        lsu_wen_reg <= lsu_wen;
                        lsu_delay_counter <= $urandom_range(MIN_DELAY, MAX_DELAY);
                        // lsu_reqReady <= 1'b0;
                    end
                end

                LSU_DELAY: begin
                    // lsu_reqReady <= 1'b0;
                    lsu_respValid <= 1'b0;
                    
                    if(lsu_delay_counter > 0) begin
                        lsu_delay_counter <= lsu_delay_counter - 1;
                    end else begin
                        if(lsu_wen_reg) begin
                            case(lsu_wmask_reg)
                                4'b0001: pmem_write(lsu_addr_reg, lsu_wdata_reg, 1);
                                4'b0011: pmem_write(lsu_addr_reg, lsu_wdata_reg, 2);
                                4'b1111: pmem_write(lsu_addr_reg, lsu_wdata_reg, 4);
                                default: pmem_write(lsu_addr_reg, lsu_wdata_reg, 4);
                            endcase
                            lsu_rdata <= 32'h0;
                        end else begin
                            lsu_rdata <= pmem_read(lsu_addr_reg, 4);
                        end
                        lsu_respValid <= 1'b1;
                    end
                end

                LSU_RESP: begin
                    // lsu_reqReady <= 1'b0;
                    lsu_respValid <= 1'b1;       
                    if(lsu_respValid /*&& lsu_respReady*/) begin
                        lsu_respValid <= 1'b0;
                        // lsu_reqReady <= 1'b1;
                    end
                end
                
                default: begin
                    // lsu_reqReady <= 1'b1;
                    lsu_respValid <= 1'b0;
                end
            endcase
        end
    end

endmodule

