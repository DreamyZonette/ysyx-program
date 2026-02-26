`ifdef VERILATOR
module ipc_counter(
    input clk,
    input rst,
    // input [31:0] pc,
    input        wbu_valid,
    input        ebreak,
    input [63:0] ifu_performance_counter,
    input [63:0] idu_performance_counter,
    input [63:0] exu_performance_counter,
    input [63:0] lsu_performance_counter,
    input [63:0] wbu_performance_counter,
    input [63:0] csr_hit_counter,
    input [63:0] exu_hit_counter,
    input [63:0] jump_hit_counter,
    input [63:0] mem_hit_counter,
    input [63:0] fence_hit_counter,
    input [63:0] ifu_cycles_counter,
    input [63:0] idu_cycles_counter,
    input [63:0] exu_cycles_counter,
    input [63:0] lsu_cycles_counter,
    input [63:0] wbu_cycles_counter,
    input [63:0] icache_hit_counter
);

    parameter icache_access_time = 1;
    parameter icache_miss_penalty = 30; // 36 apb delay_on dram // 30 axiburst

    wire [63:0] EXU_instructions = exu_hit_counter;
    wire [63:0] CSR_instructions = csr_hit_counter;
    wire [63:0] MEM_instructions = mem_hit_counter;
    wire [63:0] JUMP_instructions = jump_hit_counter;
    wire [63:0] FENCE_instructions = fence_hit_counter;

    // reg [31:0] prev_pc;
    reg [63:0] counter;
    reg [63:0] cycle_counter;
    reg [63:0] exu_cycle_counter;
    reg [63:0] lsu_cycle_counter;
    reg [63:0] csr_cycle_counter;
    reg [63:0] single_cycle_counter;
    reg [63:0] ifu_performance_counter_prev;
    reg [63:0] EXU_instructions_prev;
    reg [63:0] CSR_instructions_prev;
    reg [63:0] MEM_instructions_prev;

    // always @(posedge clk) begin
    //     prev_pc <= pc;
    // end

    always @(posedge clk) begin
        if (rst) begin
            exu_cycle_counter <= 0;
            lsu_cycle_counter <= 0;
            csr_cycle_counter <= 0;
            single_cycle_counter <= 0;
            ifu_performance_counter_prev <= 0;
            MEM_instructions_prev <= 0;
            CSR_instructions_prev <= 0;
            EXU_instructions_prev <= 0;
        end else begin
            single_cycle_counter <= single_cycle_counter + 1;
            ifu_performance_counter_prev <= ifu_performance_counter;
            if (ifu_performance_counter_prev != ifu_performance_counter) begin
                if(MEM_instructions_prev != MEM_instructions) begin
                    lsu_cycle_counter <= lsu_cycle_counter + single_cycle_counter;
                    MEM_instructions_prev <= MEM_instructions;
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
            if (wbu_valid)
                counter <= counter + 1;
            if (ebreak & wbu_valid) begin
                $display("\033[1;33mIFU Performance Counter: %16d spent %16d cycles busy account for %f\033[0m", ifu_performance_counter, ifu_cycles_counter, $itor(ifu_cycles_counter) / $itor(cycle_counter));
                $display("\033[1;33mIDU Performance Counter: %16d spent %16d cycles busy account for %f\033[0m", idu_performance_counter, idu_cycles_counter, $itor(idu_cycles_counter) / $itor(cycle_counter));
                $display("\033[1;33mEXU Performance Counter: %16d spent %16d cycles busy account for %f\033[0m", exu_performance_counter, exu_cycles_counter, $itor(exu_cycles_counter) / $itor(cycle_counter));
                $display("\033[1;33mLSU Performance Counter: %16d spent %16d cycles busy account for %f\033[0m", exu_performance_counter, lsu_cycles_counter, $itor(lsu_cycles_counter) / $itor(cycle_counter));
                $display("\033[1;33mWBU Performance Counter: %16d spent %16d cycles busy account for %f\033[0m", wbu_performance_counter, wbu_cycles_counter, $itor(wbu_cycles_counter) / $itor(cycle_counter));

                $display("\033[1;94mEXU instructions:%16d account for %02f%% spent %16d cycles\033[0m", 
                        EXU_instructions, $itor(EXU_instructions) / $itor(idu_performance_counter), exu_cycle_counter);
                $display("\033[1;94mCSR instructions:%16d account for %02f%% spent %16d cycles\033[0m", 
                        CSR_instructions, $itor(CSR_instructions) / $itor(idu_performance_counter), csr_cycle_counter);
                $display("\033[1;94mMEM instructions:%16d account for %02f%% spent %16d cycles\033[0m", 
                        MEM_instructions, $itor(MEM_instructions) / $itor(idu_performance_counter), lsu_cycle_counter);
                $display("\033[1;94mJUMP instructions:%16d account for %02f%% spent %16d cycles\033[0m", 
                        JUMP_instructions, $itor(JUMP_instructions) / $itor(idu_performance_counter), 0);
                $display("\033[1;94mFENCE instructions:%16d account for %02f%% spent %16d cycles\033[0m", 
                        FENCE_instructions, $itor(FENCE_instructions) / $itor(idu_performance_counter), 0);
                $display("\033[1;94micache hit rate = %f AMAT = %f\033[0m",  
                        $itor(icache_hit_counter) / $itor(ifu_performance_counter), $itor(icache_access_time) + (1 - $itor(icache_hit_counter) / $itor(ifu_performance_counter)) * icache_miss_penalty);
                $display("\033[1;32mTotal instructions: %16d\t Total cycles: %16d\033[0m",  counter , cycle_counter);
                $display("\033[1;32mIPC = %f\033[0m",  $itor(counter) / $itor(cycle_counter));
                $display("\033[1;32mCPI = %f\033[0m",  $itor(cycle_counter) / $itor(counter));
            end
        end
    end

endmodule
`endif
