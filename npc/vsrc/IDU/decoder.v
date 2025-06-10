module decoder #(INS_BYTES = 4, REG_ADDR_LEN = 5)(
    input      [INS_BYTES* 8 - 1:0]  i_inst,
    output reg [REG_ADDR_LEN - 1:0]       o_rd ,
    output reg [REG_ADDR_LEN - 1:0]       o_rs1,
    output reg [REG_ADDR_LEN - 1:0]       o_rs2,
    output reg [INS_BYTES* 8 - 1:0]  o_imm,
    output reg [7:0]                 o_instruction
    );

    wire [2:0] fun1;
    wire [6:0] opcode;

    assign o_rd     = i_inst[11:7];
    assign o_rs1    = i_inst[19:15];
    assign o_rs2    = i_inst[24:20];
    assign fun1   = i_inst[14:12];
    assign opcode = i_inst[6:0];

    // 指令识别模块
    always @ (*) begin
        // I-type
        if (i_inst[6:0] == 7'b0010011) begin
            if      (fun1 == 3'b000) o_instruction = 8'h01; // addi
            else if (fun1 == 3'b010) o_instruction = 8'h02; // slti
            else if (fun1 == 3'b011) o_instruction = 8'h03; // sltiu
            else if (fun1 == 3'b100) o_instruction = 8'h04; // xori
            else if (fun1 == 3'b110) o_instruction = 8'h05; // ori
            else if (fun1 == 3'b111) o_instruction = 8'h06; // andi
            else o_instruction = 8'h00;           
        end
        else begin
            o_instruction = 8'h00;
        end
    end
    
    // imm解码模块
    always @ (*) begin
        // I-type
        if (opcode == 7'b0010011) begin
            o_imm = { {20{ins[31]}}, ins[31:20]};
        end
        else begin
            o_imm = 0;
        end
    end
    
   

    endmodule

