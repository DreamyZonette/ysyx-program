module ysyx_25020042_decoder #(INS_BYTES = 4, REG_ADDR_LEN = 5)(
    input      [INS_BYTES* 8 - 1:0]  ins,
    output reg [REG_ADDR_LEN - 1:0]       rd ,
    output reg [REG_ADDR_LEN - 1:0]       rs1,
    output reg [REG_ADDR_LEN - 1:0]       rs2,
    output reg [INS_BYTES* 8 - 1:0]  imm,
    output reg [7:0]                 instruction
    );

    wire [2:0] fun1;
    wire [6:0] opcode;

    assign rd     = ins[11:7];
    assign rs1    = ins[19:15];
    assign rs2    = ins[24:20];
    assign fun1   = ins[14:12];
    assign opcode = ins[6:0];

    // 指令识别模块
    always @ (*) begin
        // I-type
        if (ins[6:0] == 7'b0010011) begin
            if      (fun1 == 3'b000) instruction = 8'h01; // addi
            else if (fun1 == 3'b010) instruction = 8'h02; // slti
            else if (fun1 == 3'b011) instruction = 8'h03; // sltiu
            else if (fun1 == 3'b100) instruction = 8'h04; // xori
            else if (fun1 == 3'b110) instruction = 8'h05; // ori
            else if (fun1 == 3'b111) instruction = 8'h06; // andi
            else instruction = 8'h00;           
        end
        else begin
            instruction = 8'h00;
        end
    end
    
    // imm解码模块
    always @ (*) begin
        // I-type
        if (opcode == 7'b0010011) begin
            imm = { {20{ins[31]}}, ins[31:20]};
        end
        else begin
            imm = 0;
        end
    end
    
   

    endmodule

