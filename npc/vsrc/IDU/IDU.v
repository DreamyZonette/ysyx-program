module IDU (
    input i_sys_clk,
    input i_sys_rst_n, 
    input   [31:0]  i_inst,
    input   [31:0]  i_wdata,
    output reg [31:0]  o_src1,
    output reg [31:0]  o_src2,
    output reg [31:0]  o_imm,
    output     [3:0]  o_wmask,
    output  o_addi_signal,
    output  o_ebreak_signal,
    output  o_jalr_signal,
    output  o_lbu_signal,
    output  o_lw_signal,
    output  o_auipc_signal,
    output  o_lui_signal,
    output  o_sb_signal,
    output  o_sw_signal,
    output  o_add_signal,
    output  o_halt_signal,
    output  [31:0] o_reg_data [0:31]
    );

    wire [6:0]  opcode;
    wire [31:0] I_imm;
    wire [4:0]  I_rs1;
    wire [4:0]  I_rd;
    wire [4:0]  U_rd;
    wire [31:0] U_imm;
    wire [4:0]  S_rs1;
    wire [4:0]  S_rs2;
    wire [31:0] S_imm;
    wire [4:0]  R_rd;
    wire [4:0]  R_rs1;
    wire [4:0]  R_rs2;
    wire S_halt_signal;
    wire R_halt_signal;
    wire I_halt_signal;
    wire U_halt_signal;
    reg Itype_signal;
    reg Rtype_signal;
    reg Stype_signal;
    reg Utype_signal;
    reg invalid_opcode_signal;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg [31:0] wdata;

    assign opcode = i_inst[6:0];
    assign o_halt_signal = (invalid_opcode_signal | 
        (S_halt_signal & Stype_signal) | 
        (R_halt_signal & Rtype_signal)| (I_halt_signal & Itype_signal) | 
        (U_halt_signal & Utype_signal));

    //根据操作码判断类型
    always @ (*) begin
        Itype_signal = 1'b0;
        Rtype_signal = 1'b0;
        Stype_signal = 1'b0;
        Utype_signal = 1'b0;
        invalid_opcode_signal = 1'b0;
        case(opcode)
        // I型
            7'b1100111:begin
                Itype_signal = 1'b1;
            end
            7'b0000011:begin
                Itype_signal = 1'b1;
            end
            7'b0010011:begin
                Itype_signal = 1'b1;
            end
            7'b0001111:begin
                Itype_signal = 1'b1;
            end
            7'b1110011:begin
                Itype_signal = 1'b1;
            end
        // U型
            7'b0110111:begin
                Utype_signal = 1'b1;
            end
            7'b0010111:begin
                Utype_signal = 1'b1;
            end
        // R型
            7'b0110011:begin
                Rtype_signal = 1'b1;
            end
        // S型
            7'b0100011:begin
                Stype_signal = 1'b1;
            end
            default: begin
                invalid_opcode_signal = 1'b1;
            end
        endcase
    end


    always @(*) begin
        o_imm = 32'b0;
        rs1 = 5'b0;
        rs2 = 5'b0;
        rd  = 5'b0;
        if(Itype_signal == 1'b1) begin
            rs1 = I_rs1;
            rs2 = 5'b0;
            rd  = I_rd;
            o_imm = I_imm;
        end
        else if(Utype_signal == 1'b1) begin
            rs1 = 5'b0;
            rs2 = 5'b0;
            rd  = U_rd;
            o_imm = U_imm;
        end
        else if(Stype_signal == 1'b1) begin
            o_imm  = S_imm;
            rs1  = S_rs1;
            rs2  = S_rs2;
            rd   = 5'b0;
        end
        else if(Rtype_signal == 1'b1) begin
            o_imm = 32'b0;
            rs1  = R_rs1;
            rs2  = R_rs2;
            rd   = R_rd;
        end
    end

    always @(*) begin
        wdata = i_wdata;
    end

    Itype Itype_u(
        .i_inst(i_inst),
        .o_imm(I_imm),
        .o_rs1(I_rs1),
        .o_rd(I_rd),
        .o_addi_signal(o_addi_signal),
        .o_ebreak_signal(o_ebreak_signal),
        .o_jalr_signal(o_jalr_signal),
        .o_lbu_signal(o_lbu_signal),
        .o_lw_signal(o_lw_signal),
        .o_halt_signal(I_halt_signal)
    );
    Utype Utype_u(
        .i_inst(i_inst),
        .o_rd(U_rd),
        .o_imm(U_imm),
        .o_auipc_signal(o_auipc_signal),
        .o_lui_signal(o_lui_signal),
        .o_halt_signal(U_halt_signal)
    );
    Stype Stype_u(
    .i_inst(i_inst),
    .o_rs1(S_rs1),
    .o_rs2(S_rs2),
    .o_imm(S_imm),
    .o_sw_signal(o_sw_signal),
    .o_sb_signal(o_sb_signal),
    .o_halt_signal(S_halt_signal),
    .o_wmask(o_wmask)
    );
    Rtype Rtype_u(
    .i_inst(i_inst),
    .o_rd(R_rd),
    .o_rs1(R_rs1),
    .o_rs2(R_rs2),
    .o_add_signal(o_add_signal),
    .o_halt_signal(R_halt_signal)
    );
    gpr gpr_u(
    .i_sys_clk(i_sys_clk),
    .i_sys_rst_n(i_sys_rst_n), 
    .i_rs1(rs1),
    .i_rs2(rs2),
    .i_rd(rd),
    .i_data(wdata),
    .o_src1(o_src1),
    .o_src2(o_src2),
    .o_reg_data(o_reg_data)
    );

    endmodule

