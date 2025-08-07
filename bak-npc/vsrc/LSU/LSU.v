module LSU(
    input wire i_sys_clk,
    input wire i_sys_rst_n,
    input wire i_lbu_signal,
    input wire i_lhu_signal,
    input wire i_lb_signal,
    input wire i_lh_signal,
    input wire i_lw_signal,
    input wire i_sb_signal,
    input wire i_sh_signal,
    input wire i_sw_signal,
    input wire i_exu_valid,
    input wire i_wbu_ready,
    input wire i_idu_valid,
    input wire [31:0] i_src2,
    input wire [31:0] i_data,
    output wire o_load_signal,
    output reg [31:0] o_rdata,
    output wire o_lsu_valid,
    output wire o_lsu_ready
);

// import "DPI-C" function int pmem_read(input int addr, input int len);
// import "DPI-C" function void pmem_write(
//     input int addr, input int len, input int data);

localparam IDLE = 2'b00;
localparam LOAD = 2'b01;
localparam LOAD_DONE = 2'b10;
localparam STORE = 2'b11;

reg [1:0] state;
reg [1:0] next_state;
reg [7:0] mem_op_type; // 锁存内存操作类型
reg [31:0] addr_latched; // 锁存地址
reg [31:0] data_latched; // 锁存数据
reg [3:0] wmask;
wire rvalid;
wire wen;
wire [31:0] rdata;
wire load_signal;
wire store_signal;
wire ram_valid;

// assign o_rdata = rdata;
assign load_signal = i_lbu_signal | i_lhu_signal | i_lb_signal | i_lh_signal | i_lw_signal;
assign store_signal = i_sb_signal | i_sh_signal | i_sw_signal;
assign o_load_signal = load_signal;
assign o_lsu_ready = (state == IDLE);
assign o_lsu_valid = (state == LOAD_DONE);
assign rvalid = (state == LOAD && !ram_valid);
assign wen = (state == STORE && !ram_valid);

// 状态转移逻辑
always @(*) begin
    if (!i_sys_rst_n) begin
        next_state = IDLE;
    end
    else begin
        case (state)
            IDLE: begin
                if(i_exu_valid  && load_signal) begin
                    next_state = LOAD;
                end
                else if(i_exu_valid  && store_signal) begin
                    next_state = STORE;
                end
                else begin
                    next_state = IDLE;
                end
            end
            LOAD: begin
                if (ram_valid) begin
                   next_state = LOAD_DONE; 
                end
                else begin
                    next_state = LOAD;
                end
            end
            LOAD_DONE: begin
                if(i_wbu_ready) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = LOAD_DONE;
                end
            end
            STORE: begin
                if(ram_valid) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = STORE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
end

// 锁存指令信息和数据
always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        mem_op_type <= 8'b0;
        addr_latched <= 32'b0;
        data_latched <= 32'b0;
    end
    else if (state == IDLE && i_exu_valid ) begin
        
        addr_latched <= i_data;
        data_latched <= i_src2;
    end
    else if(state == IDLE && i_idu_valid) begin
        mem_op_type <= {
            i_lbu_signal, i_lhu_signal, i_lb_signal, i_lh_signal, i_lw_signal,
            i_sb_signal, i_sh_signal, i_sw_signal
        };
    end
end

// 状态判断逻辑
// always @(posedge i_sys_clk) begin
//     if (!i_sys_rst_n) begin
//         rdata <= 32'b0;
//         // o_rdata <= 32'b0;
//     end
//     else begin
//         case (state) 
//             IDLE: begin
//             end
//             LOAD: begin
//                  if (ram_valid) begin
//                     // 根据锁存的指令类型执行加载
//                     case (1'b1)
//                         mem_op_type[7]: rdata <= pmem_read(addr_latched, 1); // lbu
//                         mem_op_type[6]: rdata <= pmem_read(addr_latched, 2); // lhu
//                         mem_op_type[5]: rdata <= pmem_read(addr_latched, 1); // lb
//                         mem_op_type[4]: rdata <= pmem_read(addr_latched, 2); // lh
//                         mem_op_type[3]: rdata <= pmem_read(addr_latched, 4); // lw
//                         default: rdata <= 32'b0;
//                     endcase
//                 end
//             end
//             LOAD_DONE: begin 
//                 // case (1'b1)
//                 //     mem_op_type[0]: o_rdata <= {24'b0, rdata[7:0]};  // lbu
//                 //     mem_op_type[1]: o_rdata <= {16'b0, rdata[15:0]}; // lhu
//                 //     mem_op_type[2]: o_rdata <= {{24{rdata[7]}}, rdata[7:0]}; // lb
//                 //     mem_op_type[3]: o_rdata <= {{16{rdata[15]}}, rdata[15:0]}; // lh
//                 //     mem_op_type[4]: o_rdata <= rdata; // lw
//                 //     default: o_rdata <= rdata;
//                 // endcase
//             end
//             STORE: begin
//                 if (ram_valid) begin
//                     // 根据锁存的指令类型执行存储
//                     case (1'b1)
//                         mem_op_type[2]: pmem_write(addr_latched, 1, data_latched); // sb
//                         mem_op_type[1]: pmem_write(addr_latched, 2, data_latched); // sh
//                         mem_op_type[0]: pmem_write(addr_latched, 4, data_latched); // sw
//                         default: ; // 无操作
//                     endcase
//                 end
//             end

//         endcase
//     end
// end

// 输出逻辑
always @(*) begin
    if (!i_sys_rst_n) begin
        o_rdata = 32'b0;
    end
    else begin
        case (1'b1) 
            mem_op_type[7]: o_rdata = {24'b0, rdata[7:0]};  // lbu
            mem_op_type[6]: o_rdata = {16'b0, rdata[15:0]}; // lhu
            mem_op_type[5]: o_rdata = {{24{rdata[7]}}, rdata[7:0]}; // lb
            mem_op_type[4]: o_rdata = {{16{rdata[15]}}, rdata[15:0]}; // lh
            mem_op_type[3]: o_rdata = rdata; // lw
            default: o_rdata = 32'b0;
        endcase
    end
end

always @(*) begin
    if (!i_sys_rst_n) begin
        wmask = 4'b0;
    end
    else begin
        case (1'b1) 
            mem_op_type[2]: wmask = 4'd1; // sb
            mem_op_type[1]: wmask = 4'd2; // sh
            mem_op_type[0]: wmask = 4'd4; // sw
            default: wmask = 4'b0;
        endcase
    end
end

// 状态更新逻辑
always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

ram # (1)ram_u
(
    .i_sys_clk(i_sys_clk),
    .i_sys_rst_n(i_sys_rst_n),
    .i_raddr(addr_latched), 
    .i_waddr(addr_latched), 
    .i_rvalid(rvalid), 
    .i_wen(wen), 
    .i_wmask(wmask), 
    .i_wdata(data_latched), 
    .o_rdata(rdata),
    .o_ram_valid(ram_valid)
);

endmodule
