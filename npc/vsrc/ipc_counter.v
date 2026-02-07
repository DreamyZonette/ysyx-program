module ipc_counter(
    input clk,
    input rst,
    input [31:0] pc,
    input [31:0] nepc,
    input        ebreak
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
            if (ebreak)
            $display("\033[1;32mipc = %f\033[0m",  $itor(counter) / $itor(cycle_counter));
        end
    end

endmodule
