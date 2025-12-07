module axi_arbiter (
    input              clock,
    input              reset,
    // lsu
    input [31:0]       io_lsu_araddr,
    input              io_lsu_arvalid,
    output reg         io_lsu_arready ,

    output reg [31:0]  io_lsu_rdata ,
    output reg         io_lsu_rvalid ,
    output reg [1:0]   io_lsu_rresp ,
    input              io_lsu_rready ,

    input [31:0]       io_lsu_awaddr ,
    input              io_lsu_awvalid ,
    output reg         io_lsu_awready ,

    input [31:0]       io_lsu_wdata ,
    input [3:0]        io_lsu_wstrb ,
    input              io_lsu_wvalid ,
    output reg         io_lsu_wready ,

    output reg         io_lsu_bvalid ,
    input              io_lsu_bready ,
    output reg [1:0]   io_lsu_bresp ,

    //IFU
    input [31:0]       io_ifu_araddr,
    input              io_ifu_arvalid,
    output reg         io_ifu_arready,

    output reg [31:0]  io_ifu_rdata,
    output reg         io_ifu_rvalid,
    output reg [1:0]   io_ifu_rresp,
    input              io_ifu_rready,

    // out
    output reg [31:0]  io_araddr,
    output reg         io_arvalid,
    input              io_arready,

    input [31:0]       io_rdata,
    input              io_rvalid,
    input [1:0]        io_rresp,
    output reg         io_rready,

    output reg [31:0]  io_awaddr,
    output reg         io_awvalid,
    input              io_awready,

    output reg [31:0]  io_wdata,
    output reg [3:0]   io_wstrb,
    output reg         io_wvalid,
    input              io_wready,

    input              io_bvalid,
    output reg         io_bready,
    input [1:0]        io_bresp
);

    // arbiter
    reg [1:0] state;

    parameter ARB_IDLE = 2'd0, ARB_LSU = 2'd1, ARB_IFU = 2'd2;

    always @ (posedge clock) begin
        if (reset) begin
            state <= ARB_IDLE;
        end
        else begin
            case (state)
                ARB_IDLE: begin
                    if (io_lsu_arvalid | io_lsu_awvalid) begin
                        state <= ARB_LSU;
                    end
                    else if (io_ifu_arvalid) begin
                        state <= ARB_IFU;
                    end
                    else begin
                        state <= ARB_IDLE;
                    end
                end
                ARB_LSU: begin
                    if (io_lsu_rready & io_lsu_rvalid) begin
                        state <= ARB_IDLE;
                    end
                    else if (io_lsu_bvalid & io_lsu_bready) begin
                        state <= ARB_IDLE;
                    end
                    else begin
                        state <= ARB_LSU;
                    end
                end
                ARB_IFU: begin
                    if (io_ifu_rready & io_ifu_rvalid) begin
                        state <= ARB_IDLE;
                    end
                    else begin
                        state <= ARB_IFU;
                    end
                end
                default: begin
                    state <= ARB_IDLE;
                end
            endcase      
        end
    end

    always @(*) begin
        if (state == ARB_IFU) begin
            io_araddr = io_ifu_araddr;
            io_arvalid = io_ifu_arvalid;
            io_rready = io_ifu_rready;
            io_awaddr = 0;
            io_awvalid = 0;
            io_wdata = 0;
            io_wstrb = 0;
            io_wvalid = 0;
            io_bready = 0;

            io_ifu_arready = io_arready;
            io_ifu_rdata = io_rdata;
            io_ifu_rvalid = io_rvalid;
            io_ifu_rresp = io_rresp;

            io_lsu_arready = 0;
            io_lsu_rdata = 0;
            io_lsu_rvalid = 0;
            io_lsu_rresp = 0;
            io_lsu_awready = 0;
            io_lsu_wready = 0;
            io_lsu_bvalid = 0;
            io_lsu_bresp = 0;
            
        end
        else if (state == ARB_LSU) begin
            io_araddr = io_lsu_araddr;
            io_arvalid = io_lsu_arvalid;
            io_rready = io_lsu_rready;
            io_awaddr = io_lsu_awaddr;
            io_awvalid = io_lsu_awvalid;
            io_wdata = io_lsu_wdata;
            io_wstrb = io_lsu_wstrb;
            io_wvalid = io_lsu_wvalid;
            io_bready = io_lsu_bready;

            io_lsu_arready = io_arready;
            io_lsu_rdata = io_rdata;
            io_lsu_rvalid = io_rvalid;
            io_lsu_rresp = io_rresp;
            io_lsu_awready = io_awready;
            io_lsu_wready = io_wready;
            io_lsu_bvalid = io_bvalid;
            io_lsu_bresp = io_bresp;

            io_ifu_arready = 0;
            io_ifu_rdata = 0;
            io_ifu_rvalid = 0;
            io_ifu_rresp = 0;
        end
        else begin
            io_araddr = 0;
            io_arvalid = 0;
            io_rready = 0;
            io_awaddr = 0;
            io_awvalid = 0;
            io_wdata = 0;
            io_wstrb = 0;
            io_wvalid = 0;
            io_bready = 0;

            io_lsu_arready = 0;
            io_lsu_rdata = 0;
            io_lsu_rvalid = 0;
            io_lsu_rresp = 0;
            io_lsu_awready = 0;
            io_lsu_wready = 0;
            io_lsu_bvalid = 0;
            io_lsu_bresp = 0;

            io_ifu_arready = 0;
            io_ifu_rdata = 0;
            io_ifu_rvalid = 0;
            io_ifu_rresp = 0;
        end
    end
endmodule
