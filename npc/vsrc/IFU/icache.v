module icache(
    input              clock            ,
    input              reset            ,
    input              pc_valid         ,
    input   [31:0]     pc_addr          ,
    output reg         instruction_ready,
    output reg [31:0]  instruction      ,
    `ifdef VERILATOR
    output reg [63:0]  icache_hit_count ,
    `endif

    input              io_icache_arready,
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
// reg [63:0] icache_hit_count;

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

parameter CACHE_BLOCK_SIZE  = 4;
parameter CACHE_BLOCK_BANK  = 16;
parameter m                 = $clog2(CACHE_BLOCK_SIZE);
parameter n                 = $clog2(CACHE_BLOCK_BANK);

wire [31:m+n]                 addr_tag   = pc_addr[31:m+n];
wire [m+n-1:m]                index      = pc_addr[m+n-1:m];
wire [m-1:0]                  offset     = pc_addr[m-1:0];
wire [31:m+n]                 icache_tag = icache_addr[index][31:m+n];
wire                          hit        = (icache_tag == addr_tag) && (icache_valid[index]);

reg [CACHE_BLOCK_SIZE*8-1:0] icache_data[0:CACHE_BLOCK_BANK-1];
reg [CACHE_BLOCK_SIZE*8-1:0] icache_addr[0:CACHE_BLOCK_BANK-1];
reg                          icache_valid[0:CACHE_BLOCK_BANK-1];
reg                          state;

localparam IDLE = 1'b0;
localparam READ = 1'b1;

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

integer i;

always @(posedge clock) begin
    if (reset) begin
        for (i = 0; i < CACHE_BLOCK_BANK; i = i + 1) begin
            icache_valid[i] <= 1'b0;
            icache_addr[i]  <= 0;
            icache_data[i]  <= 0;
        end
        instruction <= 0;
    end
    else begin
        if (state == READ) begin
            if (io_icache_rlast && io_icache_rvalid && io_icache_rid == io_icache_arid) begin
                icache_valid[index]          <= 1'b1;
                icache_addr[index][31:m+n]   <= addr_tag;
                icache_addr[index][m+n-1:m]  <= pc_addr[m+n-1:m];
                icache_addr[index][m-1:0]    <= pc_addr[m-1:0];
                icache_data[index]           <= io_icache_rdata;
                instruction_ready            <= 1'b1;
                instruction                  <= io_icache_rdata;
            end
        end
        if (state == IDLE) begin
            if (hit & pc_valid) begin
                instruction_ready <= 1'b1;
                instruction       <= icache_data[index];
            end
            if (instruction_ready)
                instruction_ready <= 1'b0;
        end
    end
end

always @(posedge clock) begin
    if (reset) begin
        io_icache_araddr <= 32'h0;
        io_icache_arvalid <= 1'b0;
        io_icache_rready <= 1'b0;
        io_icache_arid <= 4'h0;
        io_icache_arsize <= 3'b010;
        io_icache_arburst <= 2'b01; // INCR
        io_icache_arlen <= 8'h3; // 4beat
    end
    else begin
        if (state == IDLE && !hit) begin
            io_icache_araddr <= pc_addr;
            io_icache_arvalid <= 1'b1;
        end

        if (io_icache_arvalid & io_icache_arready) begin
            io_icache_arvalid <= 1'b0;
            io_icache_rready <= 1'b1;
        end
            
        if (io_icache_rlast && io_icache_rvalid && io_icache_rid == io_icache_arid) begin
            io_icache_rready <= 1'b0;
        end

        // if (io_icache_rready)
        //     io_icache_rready <= 1'b0;
    end
end

endmodule
