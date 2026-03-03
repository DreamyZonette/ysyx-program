module ysyx_25020042_WBU(
    input             clock,
    input             reset,
    input             lsu_valid,
    output reg        wbu_ready,
    output reg        wbu_valid,
    
    input [31:0]      i_data,
    input [31:0]      i_pc_data,
    input  [7:0]      i_inst,
    input [31:0]      i_mstatus,
    input  [2:0]      i_IFU_Exception_Handling,
    input  [2:0]      i_IDU_Exception_Handling,
    input  [5:0]      i_LSU_Exception_Handling,
    output            o_Exception_valid,
    `ifdef VERILATOR
    input  [31:0]     i_instruction_data,
    output reg [63:0] performance_counter,
    output reg [63:0] cycles_counter,
    input  [63:0]     i_single_cycles_counter,
    output reg [63:0] o_single_cycles_counter,
    `endif
    input  [11:0]     i_csr_addr,
    output reg [31:0] csr_wdata,
    output reg [11:0] csr_addr,
    output wire [31:0] o_mepc_wdata,
    output reg [31:0] o_mcause_wdata
);


    localparam IDLE = 1'b0;
    localparam WAIT = 1'b1;
    reg  state;
    wire [11:0] Exception_Handling = {i_LSU_Exception_Handling, i_IDU_Exception_Handling, i_IFU_Exception_Handling};
    wire [1:0] MPP = i_mstatus[13:12];
    assign o_Exception_valid = |Exception_Handling;

    localparam Instruction_address_misaligned = 32'd0;
    localparam Instruction_access_fault       = 32'd1;
    localparam Illegal_instruction            = 32'd2;
    localparam Breakpoint                     = 32'd3;
    localparam Load_address_misaligned        = 32'd4;
    localparam Load_access_fault              = 32'd5;
    localparam Store_address_misaligned       = 32'd6;
    localparam Store_access_fault             = 32'd7;
    localparam Environment_call_from_U_mode   = 32'd8;
    localparam Environment_call_from_S_mode   = 32'd9;
    localparam Environment_call_from_M_mode   = 32'd11;
    localparam Instruction_page_fault         = 32'd12;
    localparam Load_page_fault                = 32'd13;
    localparam Store_page_fault               = 32'd15;

`ifdef VERILATOR

    import "DPI-C" function void dpi_ebreak();

    always @(posedge clock) begin
            if (Exception_Handling[4] & wbu_valid) begin
                dpi_ebreak();
            end
    end

    reg [31:0] pc;
    reg [31:0] instruction_data;
    reg        instruction_done;
    always @(posedge clock) begin
        if (reset) begin
            pc <= 0;
            instruction_data <= 0;
            instruction_done <= 0;
        end
        else begin
            instruction_done <= wbu_valid;
            if (lsu_valid & wbu_ready) begin
                instruction_data <= i_instruction_data;
                pc <= i_pc_data;
            end
        end
    end

    always @(posedge clock) begin
        if (reset) begin
            performance_counter <= 0;
            cycles_counter <= 0;
        end
        else if (lsu_valid & wbu_ready) begin
            performance_counter <= performance_counter + 1;
            cycles_counter <= cycles_counter + 1;
        end
    end

     always @(posedge clock) begin
        if (reset) begin
            o_single_cycles_counter <= 0;
        end
        else if (lsu_valid & wbu_ready) begin
            o_single_cycles_counter <= i_single_cycles_counter;
        end
        else begin
            o_single_cycles_counter <= o_single_cycles_counter + 1;
        end
    end
`endif

assign o_mepc_wdata = i_pc_data;
always @(*) begin
    o_mcause_wdata = 32'b0;
    case (1'b1)
        Exception_Handling[0]: o_mcause_wdata = Instruction_address_misaligned;
        Exception_Handling[1]: o_mcause_wdata = Instruction_access_fault;
        Exception_Handling[2]: o_mcause_wdata = Instruction_page_fault;

        Exception_Handling[3]: o_mcause_wdata = Illegal_instruction;
        Exception_Handling[4]: o_mcause_wdata = Breakpoint;
        Exception_Handling[5]: begin 
            case (MPP)
                2'b00: o_mcause_wdata = Environment_call_from_U_mode;
                2'b01: o_mcause_wdata = Environment_call_from_S_mode;
                2'b11: o_mcause_wdata = Environment_call_from_M_mode;
                default: o_mcause_wdata = Environment_call_from_M_mode;
            endcase
        end

        Exception_Handling[6]: o_mcause_wdata = Load_address_misaligned;
        Exception_Handling[7]: o_mcause_wdata = Load_access_fault;
        Exception_Handling[8]: o_mcause_wdata = Store_address_misaligned;
        Exception_Handling[9]: o_mcause_wdata = Store_access_fault;
        Exception_Handling[10]: o_mcause_wdata = Load_page_fault;
        Exception_Handling[11]: o_mcause_wdata = Store_page_fault;
    endcase
end

always @(posedge clock) begin
    if(reset) begin
        state <= IDLE;
        csr_wdata <= 32'b0;
        wbu_ready <= 1'b1;
        wbu_valid <= 1'b0;
        // o_mepc_wdata <= 32'b0;
        // o_mcause_wdata <= 32'b0;
        csr_addr <= 12'b0;
    end
    else begin
        case(state)
            IDLE: begin
                if (lsu_valid & wbu_ready) begin
                    state <= WAIT;
                    wbu_ready <= 1'b0;
                    wbu_valid <= 1'b1;
                    csr_wdata <= i_data;
                    csr_addr <= i_csr_addr;


                end
                else begin
                    state <= IDLE;
                    if (wbu_valid) begin
                        wbu_ready <= 1'b1;
                        wbu_valid <= 1'b0;
                    end
                end
            end

            WAIT: begin
                wbu_valid <= 1'b0;
                wbu_ready <= 1'b1;
                csr_addr <= 12'b0;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end



endmodule
