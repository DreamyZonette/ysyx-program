module ipc_counter(
    input clk,
    input rst,
    input [31:0] pc,
    input [31:0] nepc,
    input        ebreak,
    input [63:0] ifu_performance_counter,
    input [63:0] exu_performance_counter,
    input [63:0] lsu_performance_counter
);

    reg [63:0] counter;
    reg [63:0] cycle_counter;


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
                $display("\033[1;32mipc = %f\033[0m",  $itor(counter) / $itor(cycle_counter));
            end
        end
    end

endmodule
