// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


VL_ATTR_COLD void Vtop___024root__trace_init_sub__TOP__0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"reset", false,-1);
    tracep->pushNamePrefix("top ");
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"reset", false,-1);
    tracep->declBus(c+1,"op_ins", false,-1, 7,0);
    tracep->declBus(c+2,"addr", false,-1, 31,0);
    tracep->declBus(c+116,"pc_next", false,-1, 31,0);
    tracep->declBus(c+3,"cur_data", false,-1, 31,0);
    tracep->declBus(c+4,"ram_data", false,-1, 31,0);
    tracep->declBus(c+5,"rs1", false,-1, 4,0);
    tracep->declBus(c+6,"rs2", false,-1, 4,0);
    tracep->declBus(c+7,"imm", false,-1, 31,0);
    tracep->declBus(c+8,"src1", false,-1, 31,0);
    tracep->declBus(c+9,"src2", false,-1, 31,0);
    tracep->declBus(c+10,"result", false,-1, 31,0);
    tracep->declBus(c+11,"rd", false,-1, 4,0);
    tracep->declBit(c+117,"jump_singnal", false,-1);
    tracep->declBit(c+117,"ram_signal", false,-1);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+8,"src1", false,-1, 31,0);
    tracep->declBus(c+9,"src2", false,-1, 31,0);
    tracep->declBus(c+7,"imm", false,-1, 31,0);
    tracep->declBus(c+4,"ram_data", false,-1, 31,0);
    tracep->declBus(c+1,"op_ins", false,-1, 7,0);
    tracep->declBus(c+10,"out", false,-1, 31,0);
    tracep->declBit(c+117,"ram_signal", false,-1);
    tracep->declBit(c+117,"jump_signal", false,-1);
    tracep->declBus(c+116,"pc_next", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("decoder ");
    tracep->declBus(c+119,"INS_BYTES", false,-1, 31,0);
    tracep->declBus(c+120,"REG_ADDR_LEN", false,-1, 31,0);
    tracep->declBus(c+3,"ins", false,-1, 31,0);
    tracep->declBus(c+11,"rd", false,-1, 4,0);
    tracep->declBus(c+5,"rs1", false,-1, 4,0);
    tracep->declBus(c+6,"rs2", false,-1, 4,0);
    tracep->declBus(c+7,"imm", false,-1, 31,0);
    tracep->declBus(c+1,"instruction", false,-1, 7,0);
    tracep->declBus(c+12,"fun1", false,-1, 2,0);
    tracep->declBus(c+13,"opcode", false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("gpr ");
    tracep->declBus(c+120,"REG_ADDR_LEN", false,-1, 31,0);
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+118,"REGS", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+5,"rs1", false,-1, 4,0);
    tracep->declBus(c+6,"rs2", false,-1, 4,0);
    tracep->declBus(c+11,"rd", false,-1, 4,0);
    tracep->declBus(c+10,"data_in", false,-1, 31,0);
    tracep->declBus(c+8,"src1", false,-1, 31,0);
    tracep->declBus(c+9,"src2", false,-1, 31,0);
    tracep->declBus(c+14,"we", false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+15+i*1,"reg_file", true,(i+0), 31,0);
    }
    tracep->pushNamePrefix("genblk1[0] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+47,"dout", false,-1, 31,0);
    tracep->declBit(c+48,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[10] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+49,"dout", false,-1, 31,0);
    tracep->declBit(c+50,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[11] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+51,"dout", false,-1, 31,0);
    tracep->declBit(c+52,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[12] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+53,"dout", false,-1, 31,0);
    tracep->declBit(c+54,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[13] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+55,"dout", false,-1, 31,0);
    tracep->declBit(c+56,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[14] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+57,"dout", false,-1, 31,0);
    tracep->declBit(c+58,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[15] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+59,"dout", false,-1, 31,0);
    tracep->declBit(c+60,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[16] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+61,"dout", false,-1, 31,0);
    tracep->declBit(c+62,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[17] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+63,"dout", false,-1, 31,0);
    tracep->declBit(c+64,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[18] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+65,"dout", false,-1, 31,0);
    tracep->declBit(c+66,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[19] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+67,"dout", false,-1, 31,0);
    tracep->declBit(c+68,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[1] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+69,"dout", false,-1, 31,0);
    tracep->declBit(c+70,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[20] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+71,"dout", false,-1, 31,0);
    tracep->declBit(c+72,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[21] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+73,"dout", false,-1, 31,0);
    tracep->declBit(c+74,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[22] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+75,"dout", false,-1, 31,0);
    tracep->declBit(c+76,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[23] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+77,"dout", false,-1, 31,0);
    tracep->declBit(c+78,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[24] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+79,"dout", false,-1, 31,0);
    tracep->declBit(c+80,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[25] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+81,"dout", false,-1, 31,0);
    tracep->declBit(c+82,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[26] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+83,"dout", false,-1, 31,0);
    tracep->declBit(c+84,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[27] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+85,"dout", false,-1, 31,0);
    tracep->declBit(c+86,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[28] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+87,"dout", false,-1, 31,0);
    tracep->declBit(c+88,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[29] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+89,"dout", false,-1, 31,0);
    tracep->declBit(c+90,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[2] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+91,"dout", false,-1, 31,0);
    tracep->declBit(c+92,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[30] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+93,"dout", false,-1, 31,0);
    tracep->declBit(c+94,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[31] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+95,"dout", false,-1, 31,0);
    tracep->declBit(c+96,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[3] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+97,"dout", false,-1, 31,0);
    tracep->declBit(c+98,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[4] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+99,"dout", false,-1, 31,0);
    tracep->declBit(c+100,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[5] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+101,"dout", false,-1, 31,0);
    tracep->declBit(c+102,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[6] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+103,"dout", false,-1, 31,0);
    tracep->declBit(c+104,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[7] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+105,"dout", false,-1, 31,0);
    tracep->declBit(c+106,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[8] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+107,"dout", false,-1, 31,0);
    tracep->declBit(c+108,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[9] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+116,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"din", false,-1, 31,0);
    tracep->declBus(c+109,"dout", false,-1, 31,0);
    tracep->declBit(c+110,"wen", false,-1);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("pc ");
    tracep->declBus(c+118,"PC_LEN", false,-1, 31,0);
    tracep->declBus(c+119,"INS_BYTES", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+116,"din", false,-1, 31,0);
    tracep->declBus(c+2,"dout", false,-1, 31,0);
    tracep->declBit(c+117,"jump", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("ram ");
    tracep->declBus(c+118,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+119,"INS_BYTES", false,-1, 31,0);
    tracep->declBus(c+118,"PC_LEN", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBit(c+115,"rst", false,-1);
    tracep->declBus(c+10,"data_in", false,-1, 31,0);
    tracep->declBus(c+2,"addr", false,-1, 31,0);
    tracep->declBus(c+121,"byte_en", false,-1, 3,0);
    tracep->declBus(c+4,"data_out", false,-1, 31,0);
    tracep->declBit(c+117,"ram_signal", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rom ");
    tracep->declBus(c+118,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBit(c+114,"clk", false,-1);
    tracep->declBus(c+2,"addr", false,-1, 31,0);
    tracep->declBus(c+3,"data", false,-1, 31,0);
    tracep->declBus(c+111,"shifted_addr", false,-1, 31,0);
    tracep->declBus(c+112,"rom_offset", false,-1, 9,0);
    tracep->declBus(c+113,"unused_signal", false,-1, 31,10);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Vtop___024root__trace_init_top(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_init_top\n"); );
    // Body
    Vtop___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vtop___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtop___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtop___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vtop___024root__trace_register(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Vtop___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Vtop___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Vtop___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vtop___024root__trace_full_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vtop___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_full_top_0\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vtop___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vtop___024root__trace_full_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullCData(oldp+1,(vlSelf->top__DOT__op_ins),8);
    bufp->fullIData(oldp+2,(vlSelf->top__DOT__addr),32);
    bufp->fullIData(oldp+3,(vlSelf->top__DOT__cur_data),32);
    bufp->fullIData(oldp+4,(((0x825U >= (0xfffU & ((IData)(0x801U) 
                                                   + vlSelf->top__DOT__addr)))
                              ? vlSelf->top__DOT__ram__DOT__ram_mem
                             [(0xfffU & ((IData)(0x801U) 
                                         + vlSelf->top__DOT__addr))]
                              : 0U)),32);
    bufp->fullCData(oldp+5,((0x1fU & (vlSelf->top__DOT__cur_data 
                                      >> 0xfU))),5);
    bufp->fullCData(oldp+6,((0x1fU & (vlSelf->top__DOT__cur_data 
                                      >> 0x14U))),5);
    bufp->fullIData(oldp+7,(((0x13U == (0x7fU & vlSelf->top__DOT__cur_data))
                              ? (((- (IData)((vlSelf->top__DOT__cur_data 
                                              >> 0x1fU))) 
                                  << 0xcU) | (vlSelf->top__DOT__cur_data 
                                              >> 0x14U))
                              : 0U)),32);
    bufp->fullIData(oldp+8,(vlSelf->top__DOT__src1),32);
    bufp->fullIData(oldp+9,(vlSelf->top__DOT__gpr__DOT__reg_file
                            [(0x1fU & (vlSelf->top__DOT__cur_data 
                                       >> 0x14U))]),32);
    bufp->fullIData(oldp+10,(vlSelf->top__DOT__result),32);
    bufp->fullCData(oldp+11,((0x1fU & (vlSelf->top__DOT__cur_data 
                                       >> 7U))),5);
    bufp->fullCData(oldp+12,((7U & (vlSelf->top__DOT__cur_data 
                                    >> 0xcU))),3);
    bufp->fullCData(oldp+13,((0x7fU & vlSelf->top__DOT__cur_data)),7);
    bufp->fullIData(oldp+14,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                               >> 7U)))
                               ? ((IData)(1U) << (0x1fU 
                                                  & (vlSelf->top__DOT__cur_data 
                                                     >> 7U)))
                               : 0U)),32);
    bufp->fullIData(oldp+15,(vlSelf->top__DOT__gpr__DOT__reg_file[0]),32);
    bufp->fullIData(oldp+16,(vlSelf->top__DOT__gpr__DOT__reg_file[1]),32);
    bufp->fullIData(oldp+17,(vlSelf->top__DOT__gpr__DOT__reg_file[2]),32);
    bufp->fullIData(oldp+18,(vlSelf->top__DOT__gpr__DOT__reg_file[3]),32);
    bufp->fullIData(oldp+19,(vlSelf->top__DOT__gpr__DOT__reg_file[4]),32);
    bufp->fullIData(oldp+20,(vlSelf->top__DOT__gpr__DOT__reg_file[5]),32);
    bufp->fullIData(oldp+21,(vlSelf->top__DOT__gpr__DOT__reg_file[6]),32);
    bufp->fullIData(oldp+22,(vlSelf->top__DOT__gpr__DOT__reg_file[7]),32);
    bufp->fullIData(oldp+23,(vlSelf->top__DOT__gpr__DOT__reg_file[8]),32);
    bufp->fullIData(oldp+24,(vlSelf->top__DOT__gpr__DOT__reg_file[9]),32);
    bufp->fullIData(oldp+25,(vlSelf->top__DOT__gpr__DOT__reg_file[10]),32);
    bufp->fullIData(oldp+26,(vlSelf->top__DOT__gpr__DOT__reg_file[11]),32);
    bufp->fullIData(oldp+27,(vlSelf->top__DOT__gpr__DOT__reg_file[12]),32);
    bufp->fullIData(oldp+28,(vlSelf->top__DOT__gpr__DOT__reg_file[13]),32);
    bufp->fullIData(oldp+29,(vlSelf->top__DOT__gpr__DOT__reg_file[14]),32);
    bufp->fullIData(oldp+30,(vlSelf->top__DOT__gpr__DOT__reg_file[15]),32);
    bufp->fullIData(oldp+31,(vlSelf->top__DOT__gpr__DOT__reg_file[16]),32);
    bufp->fullIData(oldp+32,(vlSelf->top__DOT__gpr__DOT__reg_file[17]),32);
    bufp->fullIData(oldp+33,(vlSelf->top__DOT__gpr__DOT__reg_file[18]),32);
    bufp->fullIData(oldp+34,(vlSelf->top__DOT__gpr__DOT__reg_file[19]),32);
    bufp->fullIData(oldp+35,(vlSelf->top__DOT__gpr__DOT__reg_file[20]),32);
    bufp->fullIData(oldp+36,(vlSelf->top__DOT__gpr__DOT__reg_file[21]),32);
    bufp->fullIData(oldp+37,(vlSelf->top__DOT__gpr__DOT__reg_file[22]),32);
    bufp->fullIData(oldp+38,(vlSelf->top__DOT__gpr__DOT__reg_file[23]),32);
    bufp->fullIData(oldp+39,(vlSelf->top__DOT__gpr__DOT__reg_file[24]),32);
    bufp->fullIData(oldp+40,(vlSelf->top__DOT__gpr__DOT__reg_file[25]),32);
    bufp->fullIData(oldp+41,(vlSelf->top__DOT__gpr__DOT__reg_file[26]),32);
    bufp->fullIData(oldp+42,(vlSelf->top__DOT__gpr__DOT__reg_file[27]),32);
    bufp->fullIData(oldp+43,(vlSelf->top__DOT__gpr__DOT__reg_file[28]),32);
    bufp->fullIData(oldp+44,(vlSelf->top__DOT__gpr__DOT__reg_file[29]),32);
    bufp->fullIData(oldp+45,(vlSelf->top__DOT__gpr__DOT__reg_file[30]),32);
    bufp->fullIData(oldp+46,(vlSelf->top__DOT__gpr__DOT__reg_file[31]),32);
    bufp->fullIData(oldp+47,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+48,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & ((IData)(1U) << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))))));
    bufp->fullIData(oldp+49,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+50,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0xaU))));
    bufp->fullIData(oldp+51,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+52,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0xbU))));
    bufp->fullIData(oldp+53,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+54,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0xcU))));
    bufp->fullIData(oldp+55,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+56,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0xdU))));
    bufp->fullIData(oldp+57,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+58,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0xeU))));
    bufp->fullIData(oldp+59,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+60,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0xfU))));
    bufp->fullIData(oldp+61,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+62,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x10U))));
    bufp->fullIData(oldp+63,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+64,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x11U))));
    bufp->fullIData(oldp+65,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+66,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x12U))));
    bufp->fullIData(oldp+67,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+68,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x13U))));
    bufp->fullIData(oldp+69,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+70,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 1U))));
    bufp->fullIData(oldp+71,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+72,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x14U))));
    bufp->fullIData(oldp+73,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+74,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x15U))));
    bufp->fullIData(oldp+75,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+76,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x16U))));
    bufp->fullIData(oldp+77,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+78,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x17U))));
    bufp->fullIData(oldp+79,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+80,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x18U))));
    bufp->fullIData(oldp+81,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+82,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x19U))));
    bufp->fullIData(oldp+83,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+84,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x1aU))));
    bufp->fullIData(oldp+85,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+86,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x1bU))));
    bufp->fullIData(oldp+87,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+88,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x1cU))));
    bufp->fullIData(oldp+89,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+90,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x1dU))));
    bufp->fullIData(oldp+91,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+92,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 2U))));
    bufp->fullIData(oldp+93,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+94,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x1eU))));
    bufp->fullIData(oldp+95,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+96,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 0x1fU))));
    bufp->fullIData(oldp+97,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+98,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 7U))) 
                               >> 3U))));
    bufp->fullIData(oldp+99,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+100,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__cur_data 
                                                    >> 7U))) 
                                >> 4U))));
    bufp->fullIData(oldp+101,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+102,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__cur_data 
                                                    >> 7U))) 
                                >> 5U))));
    bufp->fullIData(oldp+103,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+104,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__cur_data 
                                                    >> 7U))) 
                                >> 6U))));
    bufp->fullIData(oldp+105,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+106,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__cur_data 
                                                    >> 7U))) 
                                >> 7U))));
    bufp->fullIData(oldp+107,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+108,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__cur_data 
                                                    >> 7U))) 
                                >> 8U))));
    bufp->fullIData(oldp+109,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+110,(((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__cur_data 
                                                    >> 7U))) 
                                >> 9U))));
    bufp->fullIData(oldp+111,(((vlSelf->top__DOT__addr 
                                - (IData)(0x80000000U)) 
                               >> 2U)),32);
    bufp->fullSData(oldp+112,((0x3ffU & ((vlSelf->top__DOT__addr 
                                          - (IData)(0x80000000U)) 
                                         >> 2U))),10);
    bufp->fullIData(oldp+113,((0x3fffffU & ((vlSelf->top__DOT__addr 
                                             - (IData)(0x80000000U)) 
                                            >> 0xcU))),22);
    bufp->fullBit(oldp+114,(vlSelf->clk));
    bufp->fullBit(oldp+115,(vlSelf->reset));
    bufp->fullIData(oldp+116,(0U),32);
    bufp->fullBit(oldp+117,(0U));
    bufp->fullIData(oldp+118,(0x20U),32);
    bufp->fullIData(oldp+119,(4U),32);
    bufp->fullIData(oldp+120,(5U),32);
    bufp->fullCData(oldp+121,(0xfU),4);
}
