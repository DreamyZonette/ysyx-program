module ysyx_25020042_IFU(
    input clock,
    input reset,
    input [31:0] i_pc,
    input pc_valid,
    input lsu_ready,
    input wbu_ready,
    output reg ifu_valid,
    output reg [31:0] o_instruction,

    output reg [31:0] ifu_araddr,
    output reg ifu_arvalid,
    input ifu_arready,
    input [31:0] ifu_rdata,
    input ifu_rvalid,
    output reg ifu_rready,
    input [1:0] ifu_rresp
);
export "DPI-C" function get_pc;
export "DPI-C" function get_instruction;

    function int unsigned get_pc();   
        return i_pc;
    endfunction
    function int unsigned get_instruction();   
        return o_instruction;
    endfunction

localparam RIDLE = 2'b00;
localparam RWAIT = 2'b01;
localparam RWAIT_READY = 2'b10;
localparam ARIDLE = 2'b00;
localparam ARWAIT = 2'b01;
localparam ARWAIT_READY = 2'b10;

reg [1:0] Rstate;

always @(posedge clock) begin
    if(reset) begin
        Rstate <= RIDLE;
        ifu_valid <= 1'b0;
        ifu_araddr <= 32'h0;
        ifu_arvalid <= 1'b0;
        o_instruction <= 32'h0;
        ifu_rready <= 1'b0;
    end
    else begin
        case(Rstate)
            RIDLE: begin
                if (ifu_rready) begin
                    ifu_rready <= 1'b0;
                end
                if(pc_valid) begin
                    ifu_araddr <= i_pc;
                    ifu_arvalid <= 1'b1;
                    Rstate <= RWAIT_READY;
                end
                else begin
                    Rstate <= RIDLE;
                    if(wbu_ready || lsu_ready && ifu_valid) begin
                        ifu_valid <= 1'b0;
                    end
                end   
            end
            RWAIT_READY: begin
                if (ifu_arready) begin
                    ifu_arvalid <= 1'b0;
                    Rstate <= RWAIT;
                end
                else begin
                    Rstate <= RWAIT_READY;
                end
            end
            RWAIT: begin
                if (ifu_rvalid) begin
                    ifu_rready <= 1'b1;
                    Rstate <= RIDLE;
                    ifu_valid <= 1'b1;
                    o_instruction <= ifu_rdata;
                end
            end
            default: begin
                Rstate <= RIDLE;
            end
        endcase
    end
end

endmodule
