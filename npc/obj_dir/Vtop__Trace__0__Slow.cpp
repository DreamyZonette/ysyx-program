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
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"reset", false,-1);
    tracep->pushNamePrefix("top ");
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"reset", false,-1);
    tracep->declBus(c+1,"op_ins", false,-1, 7,0);
    tracep->declBus(c+2,"addr", false,-1, 31,0);
    tracep->declBus(c+112,"pc_next", false,-1, 31,0);
    tracep->declBus(c+3,"data", false,-1, 31,0);
    tracep->declBus(c+4,"rs1", false,-1, 4,0);
    tracep->declBus(c+5,"rs2", false,-1, 4,0);
    tracep->declBus(c+6,"imm", false,-1, 31,0);
    tracep->declBus(c+7,"src1", false,-1, 31,0);
    tracep->declBus(c+8,"src2", false,-1, 31,0);
    tracep->declBus(c+9,"result", false,-1, 31,0);
    tracep->declBus(c+10,"rd", false,-1, 4,0);
    tracep->declBit(c+113,"jump_singnal", false,-1);
    tracep->declBit(c+113,"ram_signal", false,-1);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+7,"src1", false,-1, 31,0);
    tracep->declBus(c+8,"src2", false,-1, 31,0);
    tracep->declBus(c+6,"imm", false,-1, 31,0);
    tracep->declBus(c+1,"op_ins", false,-1, 7,0);
    tracep->declBus(c+9,"out", false,-1, 31,0);
    tracep->declBit(c+113,"ram_signal", false,-1);
    tracep->declBit(c+113,"jump_signal", false,-1);
    tracep->declBus(c+112,"pc_next", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("decoder ");
    tracep->declBus(c+115,"INS_BYTES", false,-1, 31,0);
    tracep->declBus(c+116,"REG_ADDR_LEN", false,-1, 31,0);
    tracep->declBus(c+3,"ins", false,-1, 31,0);
    tracep->declBus(c+10,"rd", false,-1, 4,0);
    tracep->declBus(c+4,"rs1", false,-1, 4,0);
    tracep->declBus(c+5,"rs2", false,-1, 4,0);
    tracep->declBus(c+6,"imm", false,-1, 31,0);
    tracep->declBus(c+1,"instruction", false,-1, 7,0);
    tracep->declBus(c+11,"fun1", false,-1, 2,0);
    tracep->declBus(c+12,"opcode", false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("gpr ");
    tracep->declBus(c+116,"REG_ADDR_LEN", false,-1, 31,0);
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+114,"REGS", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+4,"rs1", false,-1, 4,0);
    tracep->declBus(c+5,"rs2", false,-1, 4,0);
    tracep->declBus(c+10,"rd", false,-1, 4,0);
    tracep->declBus(c+9,"data_in", false,-1, 31,0);
    tracep->declBus(c+7,"src1", false,-1, 31,0);
    tracep->declBus(c+8,"src2", false,-1, 31,0);
    tracep->declBus(c+13,"we", false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+14+i*1,"reg_file", true,(i+0), 31,0);
    }
    tracep->pushNamePrefix("genblk1[0] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+46,"dout", false,-1, 31,0);
    tracep->declBit(c+47,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[10] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+48,"dout", false,-1, 31,0);
    tracep->declBit(c+49,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[11] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+50,"dout", false,-1, 31,0);
    tracep->declBit(c+51,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[12] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+52,"dout", false,-1, 31,0);
    tracep->declBit(c+53,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[13] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+54,"dout", false,-1, 31,0);
    tracep->declBit(c+55,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[14] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+56,"dout", false,-1, 31,0);
    tracep->declBit(c+57,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[15] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+58,"dout", false,-1, 31,0);
    tracep->declBit(c+59,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[16] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+60,"dout", false,-1, 31,0);
    tracep->declBit(c+61,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[17] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+62,"dout", false,-1, 31,0);
    tracep->declBit(c+63,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[18] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+64,"dout", false,-1, 31,0);
    tracep->declBit(c+65,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[19] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+66,"dout", false,-1, 31,0);
    tracep->declBit(c+67,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[1] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+68,"dout", false,-1, 31,0);
    tracep->declBit(c+69,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[20] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+70,"dout", false,-1, 31,0);
    tracep->declBit(c+71,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[21] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+72,"dout", false,-1, 31,0);
    tracep->declBit(c+73,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[22] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+74,"dout", false,-1, 31,0);
    tracep->declBit(c+75,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[23] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+76,"dout", false,-1, 31,0);
    tracep->declBit(c+77,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[24] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+78,"dout", false,-1, 31,0);
    tracep->declBit(c+79,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[25] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+80,"dout", false,-1, 31,0);
    tracep->declBit(c+81,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[26] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+82,"dout", false,-1, 31,0);
    tracep->declBit(c+83,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[27] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+84,"dout", false,-1, 31,0);
    tracep->declBit(c+85,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[28] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+86,"dout", false,-1, 31,0);
    tracep->declBit(c+87,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[29] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+88,"dout", false,-1, 31,0);
    tracep->declBit(c+89,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[2] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+90,"dout", false,-1, 31,0);
    tracep->declBit(c+91,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[30] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+92,"dout", false,-1, 31,0);
    tracep->declBit(c+93,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[31] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+94,"dout", false,-1, 31,0);
    tracep->declBit(c+95,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[3] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+96,"dout", false,-1, 31,0);
    tracep->declBit(c+97,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[4] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+98,"dout", false,-1, 31,0);
    tracep->declBit(c+99,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[5] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+100,"dout", false,-1, 31,0);
    tracep->declBit(c+101,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[6] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+102,"dout", false,-1, 31,0);
    tracep->declBit(c+103,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[7] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+104,"dout", false,-1, 31,0);
    tracep->declBit(c+105,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[8] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+106,"dout", false,-1, 31,0);
    tracep->declBit(c+107,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[9] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+112,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"din", false,-1, 31,0);
    tracep->declBus(c+108,"dout", false,-1, 31,0);
    tracep->declBit(c+109,"wen", false,-1);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("pc ");
    tracep->declBus(c+114,"PC_LEN", false,-1, 31,0);
    tracep->declBus(c+115,"INS_BYTES", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+112,"din", false,-1, 31,0);
    tracep->declBus(c+2,"dout", false,-1, 31,0);
    tracep->declBit(c+113,"jump", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("ram ");
    tracep->declBus(c+114,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+115,"INS_BYTES", false,-1, 31,0);
    tracep->declBus(c+114,"PC_LEN", false,-1, 31,0);
    tracep->declBit(c+110,"clk", false,-1);
    tracep->declBit(c+111,"rst", false,-1);
    tracep->declBus(c+9,"data_in", false,-1, 31,0);
    tracep->declBus(c+2,"addr", false,-1, 31,0);
    tracep->declBus(c+117,"byte_en", false,-1, 3,0);
    tracep->declBus(c+3,"data_out", false,-1, 31,0);
    tracep->declBit(c+113,"ram_signal", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rom ");
    tracep->declBus(c+114,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+2,"addr", false,-1, 31,0);
    tracep->declBus(c+3,"data", false,-1, 31,0);
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
    bufp->fullIData(oldp+3,(vlSelf->top__DOT__data),32);
    bufp->fullCData(oldp+4,((0x1fU & (vlSelf->top__DOT__data 
                                      >> 0xfU))),5);
    bufp->fullCData(oldp+5,((0x1fU & (vlSelf->top__DOT__data 
                                      >> 0x14U))),5);
    bufp->fullIData(oldp+6,(((0x13U == (0x7fU & vlSelf->top__DOT__data))
                              ? (((- (IData)((vlSelf->top__DOT__data 
                                              >> 0x1fU))) 
                                  << 0xcU) | (vlSelf->top__DOT__data 
                                              >> 0x14U))
                              : 0U)),32);
    bufp->fullIData(oldp+7,(vlSelf->top__DOT__src1),32);
    bufp->fullIData(oldp+8,(vlSelf->top__DOT__gpr__DOT__reg_file
                            [(0x1fU & (vlSelf->top__DOT__data 
                                       >> 0x14U))]),32);
    bufp->fullIData(oldp+9,(vlSelf->top__DOT__result),32);
    bufp->fullCData(oldp+10,((0x1fU & (vlSelf->top__DOT__data 
                                       >> 7U))),5);
    bufp->fullCData(oldp+11,((7U & (vlSelf->top__DOT__data 
                                    >> 0xcU))),3);
    bufp->fullCData(oldp+12,((0x7fU & vlSelf->top__DOT__data)),7);
    bufp->fullIData(oldp+13,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                               >> 7U)))
                               ? ((IData)(1U) << (0x1fU 
                                                  & (vlSelf->top__DOT__data 
                                                     >> 7U)))
                               : 0U)),32);
    bufp->fullIData(oldp+14,(vlSelf->top__DOT__gpr__DOT__reg_file[0]),32);
    bufp->fullIData(oldp+15,(vlSelf->top__DOT__gpr__DOT__reg_file[1]),32);
    bufp->fullIData(oldp+16,(vlSelf->top__DOT__gpr__DOT__reg_file[2]),32);
    bufp->fullIData(oldp+17,(vlSelf->top__DOT__gpr__DOT__reg_file[3]),32);
    bufp->fullIData(oldp+18,(vlSelf->top__DOT__gpr__DOT__reg_file[4]),32);
    bufp->fullIData(oldp+19,(vlSelf->top__DOT__gpr__DOT__reg_file[5]),32);
    bufp->fullIData(oldp+20,(vlSelf->top__DOT__gpr__DOT__reg_file[6]),32);
    bufp->fullIData(oldp+21,(vlSelf->top__DOT__gpr__DOT__reg_file[7]),32);
    bufp->fullIData(oldp+22,(vlSelf->top__DOT__gpr__DOT__reg_file[8]),32);
    bufp->fullIData(oldp+23,(vlSelf->top__DOT__gpr__DOT__reg_file[9]),32);
    bufp->fullIData(oldp+24,(vlSelf->top__DOT__gpr__DOT__reg_file[10]),32);
    bufp->fullIData(oldp+25,(vlSelf->top__DOT__gpr__DOT__reg_file[11]),32);
    bufp->fullIData(oldp+26,(vlSelf->top__DOT__gpr__DOT__reg_file[12]),32);
    bufp->fullIData(oldp+27,(vlSelf->top__DOT__gpr__DOT__reg_file[13]),32);
    bufp->fullIData(oldp+28,(vlSelf->top__DOT__gpr__DOT__reg_file[14]),32);
    bufp->fullIData(oldp+29,(vlSelf->top__DOT__gpr__DOT__reg_file[15]),32);
    bufp->fullIData(oldp+30,(vlSelf->top__DOT__gpr__DOT__reg_file[16]),32);
    bufp->fullIData(oldp+31,(vlSelf->top__DOT__gpr__DOT__reg_file[17]),32);
    bufp->fullIData(oldp+32,(vlSelf->top__DOT__gpr__DOT__reg_file[18]),32);
    bufp->fullIData(oldp+33,(vlSelf->top__DOT__gpr__DOT__reg_file[19]),32);
    bufp->fullIData(oldp+34,(vlSelf->top__DOT__gpr__DOT__reg_file[20]),32);
    bufp->fullIData(oldp+35,(vlSelf->top__DOT__gpr__DOT__reg_file[21]),32);
    bufp->fullIData(oldp+36,(vlSelf->top__DOT__gpr__DOT__reg_file[22]),32);
    bufp->fullIData(oldp+37,(vlSelf->top__DOT__gpr__DOT__reg_file[23]),32);
    bufp->fullIData(oldp+38,(vlSelf->top__DOT__gpr__DOT__reg_file[24]),32);
    bufp->fullIData(oldp+39,(vlSelf->top__DOT__gpr__DOT__reg_file[25]),32);
    bufp->fullIData(oldp+40,(vlSelf->top__DOT__gpr__DOT__reg_file[26]),32);
    bufp->fullIData(oldp+41,(vlSelf->top__DOT__gpr__DOT__reg_file[27]),32);
    bufp->fullIData(oldp+42,(vlSelf->top__DOT__gpr__DOT__reg_file[28]),32);
    bufp->fullIData(oldp+43,(vlSelf->top__DOT__gpr__DOT__reg_file[29]),32);
    bufp->fullIData(oldp+44,(vlSelf->top__DOT__gpr__DOT__reg_file[30]),32);
    bufp->fullIData(oldp+45,(vlSelf->top__DOT__gpr__DOT__reg_file[31]),32);
    bufp->fullIData(oldp+46,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+47,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & ((IData)(1U) << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))))));
    bufp->fullIData(oldp+48,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+49,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xaU))));
    bufp->fullIData(oldp+50,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+51,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xbU))));
    bufp->fullIData(oldp+52,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+53,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xcU))));
    bufp->fullIData(oldp+54,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+55,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xdU))));
    bufp->fullIData(oldp+56,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+57,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xeU))));
    bufp->fullIData(oldp+58,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+59,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xfU))));
    bufp->fullIData(oldp+60,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+61,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x10U))));
    bufp->fullIData(oldp+62,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+63,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x11U))));
    bufp->fullIData(oldp+64,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+65,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x12U))));
    bufp->fullIData(oldp+66,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+67,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x13U))));
    bufp->fullIData(oldp+68,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+69,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 1U))));
    bufp->fullIData(oldp+70,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+71,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x14U))));
    bufp->fullIData(oldp+72,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+73,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x15U))));
    bufp->fullIData(oldp+74,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+75,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x16U))));
    bufp->fullIData(oldp+76,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+77,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x17U))));
    bufp->fullIData(oldp+78,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+79,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x18U))));
    bufp->fullIData(oldp+80,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+81,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x19U))));
    bufp->fullIData(oldp+82,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+83,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x1aU))));
    bufp->fullIData(oldp+84,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+85,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x1bU))));
    bufp->fullIData(oldp+86,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+87,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x1cU))));
    bufp->fullIData(oldp+88,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+89,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x1dU))));
    bufp->fullIData(oldp+90,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+91,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 2U))));
    bufp->fullIData(oldp+92,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+93,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x1eU))));
    bufp->fullIData(oldp+94,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+95,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x1fU))));
    bufp->fullIData(oldp+96,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+97,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 3U))));
    bufp->fullIData(oldp+98,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+99,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 4U))));
    bufp->fullIData(oldp+100,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+101,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 5U))));
    bufp->fullIData(oldp+102,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+103,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 6U))));
    bufp->fullIData(oldp+104,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+105,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 7U))));
    bufp->fullIData(oldp+106,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+107,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 8U))));
    bufp->fullIData(oldp+108,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+109,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 9U))));
    bufp->fullBit(oldp+110,(vlSelf->clk));
    bufp->fullBit(oldp+111,(vlSelf->reset));
    bufp->fullIData(oldp+112,(0U),32);
    bufp->fullBit(oldp+113,(0U));
    bufp->fullIData(oldp+114,(0x20U),32);
    bufp->fullIData(oldp+115,(4U),32);
    bufp->fullIData(oldp+116,(5U),32);
    bufp->fullCData(oldp+117,(0xfU),4);
}
