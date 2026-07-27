`timescale 1ns/1ns 
module ysyx_25020042_icache(
    input              clock            ,
    input              reset            ,
    input              pc_valid         ,
    input   [31:0]     pc_addr          ,
    output reg         instruction_ready,
    output reg [31:0]  instruction      ,
    output             Instruction_access_fault,
    `ifdef VERILATOR
    output reg [63:0]  icache_hit_count ,
    `endif

    input              io_icache_arready,
    input              fencei_signal    ,
    output reg         io_icache_arvalid,
    output reg [31:0]  io_icache_araddr ,
    output reg [3:0]   io_icache_arid   ,
    output reg [7:0]   io_icache_arlen  ,
    output reg [2:0]   io_icache_arsize ,
    output reg [1:0]   io_icache_arburst,
    output reg         io_icache_rready ,
    input              io_icache_rvalid ,
    input   [1:0]      io_icache_rresp  ,
    input   [31:0]     io_icache_rdata  ,
    input              io_icache_rlast  ,
    input   [3:0]      io_icache_rid    
);

`ifdef VERILATOR

always @(posedge clock) begin
    if (reset) begin
        icache_hit_count <= 0;
    end
    else begin
        if (hit & pc_valid)
            icache_hit_count <= icache_hit_count + 1;
    end
end

`endif

parameter CACHE_BLOCK_SIZE  = 16;
parameter CACHE_BLOCK_BANK  = 4;
parameter CACHE_BLOCK_COUNT = CACHE_BLOCK_SIZE / 4;
parameter m                 = $clog2(CACHE_BLOCK_SIZE);
parameter n                 = $clog2(CACHE_BLOCK_BANK);
parameter SDRAM_BASE_ADDR   = 32'ha0000000;
parameter SDRAM_SIZE        = 32'h20000000;
`ifdef PLATFORM_NPC
wire                          sdram_valid = 1;
`else 
// wire                          sdram_valid = 0;
wire                          sdram_valid    = (pc_addr >= SDRAM_BASE_ADDR) && (pc_addr < SDRAM_BASE_ADDR + SDRAM_SIZE);
`endif
wire [31:m+n]                 addr_tag       = pc_addr[31:m+n];
wire [m+n-1:m]                index          = pc_addr[m+n-1:m];
wire [m-1:2]                  offset         = pc_addr[m-1:2];
wire [31:m+n]                 icache_tag     = icache_addr[index][31:m+n];
wire                          hit            = (icache_tag == addr_tag) && (icache_valid[index]);
wire [31:m]                   burst_addr     = io_icache_araddr[31:m];
wire [m+n-1:m]                burst_index    = burst_addr[m+n-1:m];
wire [m-1:2]                  burst_offset   = burst_count;

reg [32-1:0]                 icache_data[0:CACHE_BLOCK_BANK-1][0:CACHE_BLOCK_COUNT-1];
reg [32-1:0]                 icache_addr[0:CACHE_BLOCK_BANK-1];
reg                          icache_valid[0:CACHE_BLOCK_BANK-1];
reg                          state;
reg [m-1:2]                  burst_count;
reg [1:0]                    rresp;

localparam IDLE = 1'b0;
localparam READ = 1'b1;

assign Instruction_access_fault = rresp[1] | rresp[0];

always @(posedge clock) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        case(state)
            IDLE: begin
                if (pc_valid) begin
                    if(hit)
                        state <= IDLE;
                    else 
                        state <= READ;
                end
                else 
                    state <= IDLE;
            end
            READ: begin
                if (io_icache_rlast && io_icache_rvalid && io_icache_rid == io_icache_arid)
                    state <= IDLE;
                else 
                    state <= READ;
            end
        endcase
    end
end

//  31    m+n m+n-1   m m-1    0
// +---------+---------+--------+
// |   tag   |  index  | offset |
// +---------+---------+--------+

always @(posedge clock) begin
    if (reset) begin
        burst_count <= 0;
    end
    else begin
        if (io_icache_rlast & sdram_valid)
            burst_count <= 0;
        else if (io_icache_rvalid & sdram_valid) 
            burst_count <= burst_count + 1;        
    end
end


integer i;
integer j;

always @(posedge clock) begin
    if (reset) begin
        for (i = 0; i < CACHE_BLOCK_BANK; i = i + 1) begin
            icache_valid[i] <= 1'b0;
            icache_addr[i]  <= 0;
            for (j = 0; j < CACHE_BLOCK_COUNT; j = j + 1) begin
                icache_data[i][j]  <= 0;
            end
        end
        instruction <= 0;
    end
    else begin
        if (state == READ) begin
            if (io_icache_rvalid && io_icache_rid == io_icache_arid) begin
                if (sdram_valid) begin
                    icache_valid[burst_index]                               <= 1'b1;
                    icache_addr[burst_index][31:m+n]                        <= burst_addr[31:m+n];
                    icache_addr[burst_index][m+n-1:m]                       <= burst_addr[m+n-1:m];
                    icache_addr[burst_index][m-1:0]                         <= {m{1'b0}};
                    icache_data[burst_index][burst_offset]           <= io_icache_rdata;
                end
                if (io_icache_rlast) begin
                    instruction_ready            <= 1'b1;
                    if (sdram_valid) begin
                        instruction <= (offset == {(m-2){1'b1}})? io_icache_rdata : icache_data[index][offset];
                    end
                    else begin
                        instruction <= io_icache_rdata;
                    end
                end
            end
        end
        else if (fencei_signal) begin
            for (i = 0; i < CACHE_BLOCK_BANK; i = i + 1) begin
            icache_valid[i] <= 1'b0;
            end
        end
        if (state == IDLE) begin
            if (hit & pc_valid) begin
                instruction_ready <= 1'b1;
                instruction       <= icache_data[index][offset];
            end
            if (instruction_ready)
                instruction_ready <= 1'b0;
        end
    end
end

always @(posedge clock) begin
    if (reset) begin
        // io_icache_araddr <= 32'h0;
        io_icache_arvalid <= 1'b0;
        io_icache_rready <= 1'b0;
        io_icache_arid <= 4'h0;
        io_icache_arsize <= 3'b010;
        io_icache_arburst <= 2'b00; 
        io_icache_arlen <= 8'h0;
        rresp <= 2'b0;
    end
    else begin
        if (state == IDLE && !hit && pc_valid) begin
            if (sdram_valid) begin
                io_icache_araddr  <= {pc_addr[31:m], {m{1'b0}}};
                io_icache_arvalid <= 1'b1;
                io_icache_arburst <= 2'b01; // INCR 01
                io_icache_arlen   <= 8'h3; // 4beat  3
            end
            else begin
                io_icache_arburst <= 2'b00;
                io_icache_arlen   <= 8'h0;
                io_icache_araddr  <= pc_addr;
                io_icache_arvalid <= 1'b1;
            end
        end

        if (io_icache_arvalid & io_icache_arready) begin
            io_icache_arvalid <= 1'b0;
            io_icache_rready <= 1'b1;
        end
            
        if (io_icache_rlast && io_icache_rvalid && io_icache_rid == io_icache_arid) begin
            io_icache_rready <= 1'b0;
            rresp <= io_icache_rresp;
        end
    end
end

endmodule
