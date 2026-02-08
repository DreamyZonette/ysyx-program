module ipc_counter(
    input clk,
    input rst,
    input [31:0] pc,
    input [31:0] nepc,
    input        ebreak,
    input [63:0] ifu_performance_counter,
    input [63:0] exu_performance_counter,
    input [63:0] lsu_performance_counter,
    output [63:0] csr_performance_counter
);

    wire [63:0] EXU_instructions = ifu_performance_counter - csr_performance_counter - lsu_performance_counter;
    wire [63:0] CSR_instructions = csr_performance_counter;
    wire [63:0] LSU_instructions = lsu_performance_counter;

    reg [63:0] counter;
    reg [63:0] cycle_counter;
    reg [63:0] exu_cycle_counter;
    reg [63:0] lsu_cycle_counter;
    reg [63:0] csr_cycle_counter;
    reg [63:0] single_cycle_counter;
    reg [63:0] ifu_performance_counter_prev;
    reg [63:0] EXU_instructions_prev;
    reg [63:0] CSR_instructions_prev;
    reg [63:0] LSU_instructions_prev;

    always @(posedge clk) begin
        if (rst) begin
            exu_cycle_counter <= 0;
            lsu_cycle_counter <= 0;
            csr_cycle_counter <= 0;
            single_cycle_counter <= 0;
            ifu_performance_counter_prev <= 0;
            LSU_instructions_prev <= 0;
            CSR_instructions_prev <= 0;
            EXU_instructions_prev <= 0;
        end else begin
            single_cycle_counter <= single_cycle_counter + 1;
            ifu_performance_counter_prev <= ifu_performance_counter;
            if (ifu_performance_counter_prev != ifu_performance_counter) begin
                if(LSU_instructions_prev != LSU_instructions) begin
                    lsu_cycle_counter <= lsu_cycle_counter + single_cycle_counter;
                    LSU_instructions_prev <= LSU_instructions;
                end
                else if(CSR_instructions_prev != CSR_instructions) begin
                    csr_cycle_counter <= csr_cycle_counter + single_cycle_counter;
                    CSR_instructions_prev <= CSR_instructions;
                end
                else if(EXU_instructions_prev != EXU_instructions) begin
                    exu_cycle_counter <= exu_cycle_counter + single_cycle_counter;
                    EXU_instructions_prev <= EXU_instructions;
                end
                single_cycle_counter <= 0;
            end
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
            cycle_counter <= 0;
        end else begin
            cycle_counter <= cycle_counter + 1;
            if (pc != nepc)
                counter <= counter + 1;
            if (ebreak) begin
                $display("\033[1;33mIFU Performance Counter: %8d\033[0m", ifu_performance_counter);
                $display("\033[1;33mEXU Performance Counter: %8d\033[0m", exu_performance_counter);
                $display("\033[1;33mLSU Performance Counter: %8d\033[0m", lsu_performance_counter);
                $display("\033[1;33mEXU instructions:%8d account for %02f%% spent %8d cycles\033[0m", 
                        EXU_instructions, $itor(EXU_instructions) / $itor(ifu_performance_counter), exu_cycle_counter);
                $display("\033[1;33mCSR instructions:%2d account for %02f%% spent %8d cycles\033[0m", 
                        CSR_instructions, $itor(CSR_instructions) / $itor(ifu_performance_counter), csr_cycle_counter);
                $display("\033[1;33mLSU instructions:%8d account for %02f%% spent %8d cycles\033[0m", 
                        LSU_instructions, $itor(LSU_instructions) / $itor(ifu_performance_counter), lsu_cycle_counter);
                $display("\033[1;32mipc = %f\033[0m",  $itor(counter) / $itor(cycle_counter));
            end
        end
    end

endmodule
