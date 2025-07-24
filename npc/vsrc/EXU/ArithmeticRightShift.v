module ArithmeticRightShift(
    input [31:0] i_src1,
    input [4:0] i_shamt,
    output reg [31:0] o_data
);

    always @(*) begin
        case (i_shamt)
            5'd0: o_data = i_src1;
            5'd1: o_data = {i_src1[31], i_src1[31:1]};
            5'd2: o_data = {{2{i_src1[31]}}, i_src1[31:2]};
            5'd3: o_data = {{3{i_src1[31]}}, i_src1[31:3]};
            5'd4: o_data = {{4{i_src1[31]}}, i_src1[31:4]};
            5'd5: o_data = {{5{i_src1[31]}}, i_src1[31:5]};
            5'd6: o_data = {{6{i_src1[31]}}, i_src1[31:6]};
            5'd7: o_data = {{7{i_src1[31]}}, i_src1[31:7]};
            5'd8: o_data = {{8{i_src1[31]}}, i_src1[31:8]};
            5'd9: o_data = {{9{i_src1[31]}}, i_src1[31:9]};
            5'd10: o_data = {{10{i_src1[31]}}, i_src1[31:10]};
            5'd11: o_data = {{11{i_src1[31]}}, i_src1[31:11]};
            5'd12: o_data = {{12{i_src1[31]}}, i_src1[31:12]};
            5'd13: o_data = {{13{i_src1[31]}}, i_src1[31:13]};
            5'd14: o_data = {{14{i_src1[31]}}, i_src1[31:14]};
            5'd15: o_data = {{15{i_src1[31]}}, i_src1[31:15]};
            5'd16: o_data = {{16{i_src1[31]}}, i_src1[31:16]};
            5'd17: o_data = {{17{i_src1[31]}}, i_src1[31:17]};
            5'd18: o_data = {{18{i_src1[31]}}, i_src1[31:18]};
            5'd19: o_data = {{19{i_src1[31]}}, i_src1[31:19]};
            5'd20: o_data = {{20{i_src1[31]}}, i_src1[31:20]};
            5'd21: o_data = {{21{i_src1[31]}}, i_src1[31:21]};
            5'd22: o_data = {{22{i_src1[31]}}, i_src1[31:22]};
            5'd23: o_data = {{23{i_src1[31]}}, i_src1[31:23]};
            5'd24: o_data = {{24{i_src1[31]}}, i_src1[31:24]};
            5'd25: o_data = {{25{i_src1[31]}}, i_src1[31:25]};
            5'd26: o_data = {{26{i_src1[31]}}, i_src1[31:26]};
            5'd27: o_data = {{27{i_src1[31]}}, i_src1[31:27]};
            5'd28: o_data = {{28{i_src1[31]}}, i_src1[31:28]};
            5'd29: o_data = {{29{i_src1[31]}}, i_src1[31:29]};
            5'd30: o_data = {{30{i_src1[31]}}, i_src1[31:30]};
            default: o_data = {32{i_src1[31]}}; // 31位及以上
        endcase
    end

endmodule