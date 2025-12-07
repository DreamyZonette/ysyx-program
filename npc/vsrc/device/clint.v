module clint(
    input clock,
    input reset,
    // axi 握手信号
    /* verilator lint_off UNUSEDSIGNAL */
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
    /* verilator lint_on UNUSEDSIGNAL */
);


reg [2:0] state;
localparam IDLE = 3'd0;
localparam READ = 3'd1;
localparam READ_WAIT = 3'd2;
localparam WRITE = 3'd3;
localparam WRITE_WAIT = 3'd4;
reg [31:0] mtime;
reg [31:0] mtimeh;

always @(posedge clock) begin
    if (reset) begin
        mtime <= 32'b0;
        mtimeh <= 32'b0;
    end
    else begin
        mtime <= mtime + 1;
        mtimeh <= mtime == 32'hffffffff ? mtimeh + 1 : mtimeh;
    end
end

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
            if (slave_araddr == 32'ha0000048) begin
                slave_rdata <= mtime;
            end
            else if (slave_araddr == 32'ha000004c) begin
                slave_rdata <= mtimeh;
            end
            else begin
                slave_rdata <= 32'b0;
            end
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


endmodule
