module ysyx_25020042_IFU(
    input                  clock,
    input                  reset,
    input      [31:0]      i_pc,
    input                  pc_valid,
    input                  lsu_ready,
    input                  wbu_ready,
    output reg             ifu_valid,
    output reg [31:0]      o_instruction,
    `ifdef VERILATOR
    input                  ebreak,
    `endif

    output reg [31:0]      ifu_araddr,
    output reg             ifu_arvalid,
    input                  ifu_arready,
    output reg [7:0]       ifu_arlen,
    output reg [3:0]       ifu_arid,
    output reg [1:0]       ifu_arburst,
    output reg [2:0]       ifu_arsize,
    input      [31:0]      ifu_rdata,
    input                  ifu_rvalid,
    output reg             ifu_rready,
    input      [1:0]       ifu_rresp,
    input                  ifu_rlast,
    input      [3:0]       ifu_rid
);
`ifdef VERILATOR
export "DPI-C" function get_pc;
export "DPI-C" function get_instruction;

    function int unsigned get_pc();   
        return i_pc;
    endfunction
    function int unsigned get_instruction();   
        return o_instruction;
    endfunction

    reg [63:0] performance_counter;
    always @(posedge clock or posedge ebreak) begin
        if(reset) 
            performance_counter <= 0;
        else if (ifu_rvalid)
            performance_counter <= performance_counter + 1;
        else if (ebreak)
            $display("\033[1;33mIFU Performance Counter: %d\033[0m", performance_counter);
    end

`endif

localparam RIDLE = 1'b0;
localparam RWAIT_READY = 1'b1;
localparam ARIDLE = 1'b0;
localparam ARWAIT_READY = 1'b1;

reg Rstate;
reg ARstate;
/* verilator lint_off UNUSEDSIGNAL */
reg [1:0] rresp;
/* verilator lint_on UNUSEDSIGNAL */

always @(posedge clock) begin
    if(reset) begin
        Rstate <= RIDLE;
        ARstate <= ARIDLE;
        ifu_valid <= 1'b0;
        ifu_araddr <= 32'h0;
        ifu_arvalid <= 1'b0;
        o_instruction <= 32'h0;
        ifu_rready <= 1'b0;
        rresp <= 2'b00;
        ifu_arid <= 4'h0;
        ifu_arsize <= 3'b010;
        ifu_arburst <= 2'b00;
        ifu_arlen <= 8'h0;
    end
    else begin
        // 地址通道
        case (ARstate)
            ARIDLE: begin
                if(pc_valid) begin
                    ifu_araddr <= i_pc;
                    ifu_arvalid <= 1'b1;
                    ARstate <= ARWAIT_READY;
                end
                else begin
                    ARstate <= ARIDLE;
                end
            end
            ARWAIT_READY: begin
                if(ifu_arready) begin
                    ifu_arvalid <= 1'b0;
                    ARstate <= ARIDLE;
                    
                end
                else begin 
                    ARstate <= ARWAIT_READY;
                end
            end

        endcase

        case(Rstate)
            RIDLE: begin
                if(ifu_arready && ifu_arvalid) begin
                    Rstate <= RWAIT_READY;
                end
                else begin
                    Rstate <= RIDLE;
                end  
                
                if (ifu_rready) begin
                    ifu_rready <= 1'b0;
                end
                if((wbu_ready || lsu_ready) && ifu_valid) begin
                    ifu_valid <= 1'b0;
                end 
            end
            RWAIT_READY: begin
                if (ifu_rvalid & ifu_rlast & ifu_rid == ifu_arid) begin
                    ifu_rready <= 1'b1;
                    Rstate <= RIDLE;
                    ifu_valid <= 1'b1;
                    o_instruction <= ifu_rdata;
                    rresp <= ifu_rresp;
                end
                else begin
                    Rstate <= RWAIT_READY;
                end
            end
        endcase
        
    end
end

endmodule
