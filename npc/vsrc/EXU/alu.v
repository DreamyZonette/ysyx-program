// /* verilator lint_off DECLFILENAME */
// module alu #(WIDTH = 32)(
//     input [WIDTH-1:0] i_src1,
//     input [WIDTH-1:0] i_src2,
//     input [WIDTH-1:0] i_imm ,
//     input [WIDTH-1:0] i_offset ,
//     input [WIDTH-1:0] i_ram_data,
//     input             i_addi_signal,
//     input             i_jalr_signal,
//     output reg [WIDTH-1:0] o_result,
//     );

//     always @ (*) begin
//         o_result = 32'b0;
//         if(i_addi_signal == 1'b1) begin
//             o_result = i_src1 + i_imm;
//         end
//         if(i_jalr_signal == 1'b1) begin
//             o_result = i_src1 + i_offset;
//         end
//     end
//     //临时
//     assign pc_next = 0;
    
// endmodule
// /* verilator lint_off DECLFILENAME */
