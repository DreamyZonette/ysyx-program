// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VReg__Syms.h"


VL_ATTR_COLD void VReg___024root__trace_init_sub__TOP__0(VReg___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+126,"MuxKey.out", false,-1, 0,0);
    tracep->declBus(c+127,"MuxKey.key", false,-1, 0,0);
    tracep->declBus(c+128,"MuxKey.lut", false,-1, 3,0);
    tracep->declBus(c+129,"MuxKeyWithDefault.out", false,-1, 0,0);
    tracep->declBus(c+130,"MuxKeyWithDefault.key", false,-1, 0,0);
    tracep->declBus(c+131,"default_out", false,-1, 0,0);
    tracep->declBus(c+132,"MuxKeyWithDefault.lut", false,-1, 3,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"reset", false,-1);
    tracep->pushNamePrefix("MuxKey ");
    tracep->declBus(c+135,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+136,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+136,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+126,"out", false,-1, 0,0);
    tracep->declBus(c+127,"key", false,-1, 0,0);
    tracep->declBus(c+128,"lut", false,-1, 3,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+135,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+136,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+136,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+137,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+126,"out", false,-1, 0,0);
    tracep->declBus(c+127,"key", false,-1, 0,0);
    tracep->declBus(c+138,"default_out", false,-1, 0,0);
    tracep->declBus(c+128,"lut", false,-1, 3,0);
    tracep->declBus(c+135,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+1+i*1,"pair_list", true,(i+0), 1,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+3+i*1,"key_list", true,(i+0), 0,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+5+i*1,"data_list", true,(i+0), 0,0);
    }
    tracep->declBus(c+7,"lut_out", false,-1, 0,0);
    tracep->declBit(c+8,"hit", false,-1);
    tracep->declBus(c+139,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("MuxKeyWithDefault ");
    tracep->declBus(c+135,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+136,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+136,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+129,"out", false,-1, 0,0);
    tracep->declBus(c+130,"key", false,-1, 0,0);
    tracep->declBus(c+131,"default_out", false,-1, 0,0);
    tracep->declBus(c+132,"lut", false,-1, 3,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+135,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+136,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+136,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+136,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+129,"out", false,-1, 0,0);
    tracep->declBus(c+130,"key", false,-1, 0,0);
    tracep->declBus(c+131,"default_out", false,-1, 0,0);
    tracep->declBus(c+132,"lut", false,-1, 3,0);
    tracep->declBus(c+135,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+9+i*1,"pair_list", true,(i+0), 1,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+11+i*1,"key_list", true,(i+0), 0,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+13+i*1,"data_list", true,(i+0), 0,0);
    }
    tracep->declBus(c+15,"lut_out", false,-1, 0,0);
    tracep->declBit(c+16,"hit", false,-1);
    tracep->declBus(c+139,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("top ");
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"reset", false,-1);
    tracep->declBus(c+17,"op_ins", false,-1, 7,0);
    tracep->declBus(c+18,"addr", false,-1, 31,0);
    tracep->declBus(c+140,"pc_next", false,-1, 31,0);
    tracep->declBus(c+19,"data", false,-1, 31,0);
    tracep->declBus(c+20,"rs1", false,-1, 4,0);
    tracep->declBus(c+21,"rs2", false,-1, 4,0);
    tracep->declBus(c+22,"imm", false,-1, 31,0);
    tracep->declBus(c+23,"src1", false,-1, 31,0);
    tracep->declBus(c+24,"src2", false,-1, 31,0);
    tracep->declBus(c+25,"result", false,-1, 31,0);
    tracep->declBus(c+26,"rd", false,-1, 4,0);
    tracep->declBit(c+141,"jump_singnal", false,-1);
    tracep->declBit(c+142,"ram_signal", false,-1);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+23,"src1", false,-1, 31,0);
    tracep->declBus(c+24,"src2", false,-1, 31,0);
    tracep->declBus(c+22,"imm", false,-1, 31,0);
    tracep->declBus(c+17,"op_ins", false,-1, 7,0);
    tracep->declBus(c+25,"out", false,-1, 31,0);
    tracep->declBit(c+142,"ram_signal", false,-1);
    tracep->declBit(c+141,"jump_signal", false,-1);
    tracep->declBus(c+140,"pc_next", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("decoder ");
    tracep->declBus(c+144,"INS_BYTES", false,-1, 31,0);
    tracep->declBus(c+145,"REG_ADDR_LEN", false,-1, 31,0);
    tracep->declBus(c+19,"ins", false,-1, 31,0);
    tracep->declBus(c+26,"rd", false,-1, 4,0);
    tracep->declBus(c+20,"rs1", false,-1, 4,0);
    tracep->declBus(c+21,"rs2", false,-1, 4,0);
    tracep->declBus(c+22,"imm", false,-1, 31,0);
    tracep->declBus(c+17,"instruction", false,-1, 7,0);
    tracep->declBus(c+27,"fun1", false,-1, 2,0);
    tracep->declBus(c+28,"opcode", false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("gpr ");
    tracep->declBus(c+145,"REG_ADDR_LEN", false,-1, 31,0);
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+143,"REGS", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+20,"rs1", false,-1, 4,0);
    tracep->declBus(c+21,"rs2", false,-1, 4,0);
    tracep->declBus(c+26,"rd", false,-1, 4,0);
    tracep->declBus(c+25,"data_in", false,-1, 31,0);
    tracep->declBus(c+23,"src1", false,-1, 31,0);
    tracep->declBus(c+24,"src2", false,-1, 31,0);
    tracep->declBus(c+29,"we", false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+30+i*1,"reg_file", true,(i+0), 31,0);
    }
    tracep->pushNamePrefix("genblk1[0] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+62,"dout", false,-1, 31,0);
    tracep->declBit(c+63,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[10] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+64,"dout", false,-1, 31,0);
    tracep->declBit(c+65,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[11] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+66,"dout", false,-1, 31,0);
    tracep->declBit(c+67,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[12] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+68,"dout", false,-1, 31,0);
    tracep->declBit(c+69,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[13] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+70,"dout", false,-1, 31,0);
    tracep->declBit(c+71,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[14] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+72,"dout", false,-1, 31,0);
    tracep->declBit(c+73,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[15] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+74,"dout", false,-1, 31,0);
    tracep->declBit(c+75,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[16] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+76,"dout", false,-1, 31,0);
    tracep->declBit(c+77,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[17] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+78,"dout", false,-1, 31,0);
    tracep->declBit(c+79,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[18] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+80,"dout", false,-1, 31,0);
    tracep->declBit(c+81,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[19] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+82,"dout", false,-1, 31,0);
    tracep->declBit(c+83,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[1] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+84,"dout", false,-1, 31,0);
    tracep->declBit(c+85,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[20] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+86,"dout", false,-1, 31,0);
    tracep->declBit(c+87,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[21] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+88,"dout", false,-1, 31,0);
    tracep->declBit(c+89,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[22] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+90,"dout", false,-1, 31,0);
    tracep->declBit(c+91,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[23] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+92,"dout", false,-1, 31,0);
    tracep->declBit(c+93,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[24] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+94,"dout", false,-1, 31,0);
    tracep->declBit(c+95,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[25] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+96,"dout", false,-1, 31,0);
    tracep->declBit(c+97,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[26] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+98,"dout", false,-1, 31,0);
    tracep->declBit(c+99,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[27] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+100,"dout", false,-1, 31,0);
    tracep->declBit(c+101,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[28] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+102,"dout", false,-1, 31,0);
    tracep->declBit(c+103,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[29] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+104,"dout", false,-1, 31,0);
    tracep->declBit(c+105,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[2] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+106,"dout", false,-1, 31,0);
    tracep->declBit(c+107,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[30] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+108,"dout", false,-1, 31,0);
    tracep->declBit(c+109,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[31] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+110,"dout", false,-1, 31,0);
    tracep->declBit(c+111,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[3] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+112,"dout", false,-1, 31,0);
    tracep->declBit(c+113,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[4] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+114,"dout", false,-1, 31,0);
    tracep->declBit(c+115,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[5] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+116,"dout", false,-1, 31,0);
    tracep->declBit(c+117,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[6] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+118,"dout", false,-1, 31,0);
    tracep->declBit(c+119,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[7] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+120,"dout", false,-1, 31,0);
    tracep->declBit(c+121,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[8] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+122,"dout", false,-1, 31,0);
    tracep->declBit(c+123,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[9] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+137,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+124,"dout", false,-1, 31,0);
    tracep->declBit(c+125,"wen", false,-1);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("pc ");
    tracep->declBus(c+143,"PC_LEN", false,-1, 31,0);
    tracep->declBus(c+144,"INS_BYTES", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+140,"din", false,-1, 31,0);
    tracep->declBus(c+18,"dout", false,-1, 31,0);
    tracep->declBit(c+141,"jump", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("ram ");
    tracep->declBus(c+143,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+144,"INS_BYTES", false,-1, 31,0);
    tracep->declBus(c+143,"PC_LEN", false,-1, 31,0);
    tracep->declBit(c+133,"clk", false,-1);
    tracep->declBit(c+134,"rst", false,-1);
    tracep->declBus(c+25,"data_in", false,-1, 31,0);
    tracep->declBus(c+18,"addr", false,-1, 31,0);
    tracep->declBus(c+146,"byte_en", false,-1, 3,0);
    tracep->declBus(c+19,"data_out", false,-1, 31,0);
    tracep->declBit(c+142,"ram_signal", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rom ");
    tracep->declBus(c+143,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+18,"addr", false,-1, 31,0);
    tracep->declBus(c+19,"data", false,-1, 31,0);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void VReg___024root__trace_init_top(VReg___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root__trace_init_top\n"); );
    // Body
    VReg___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void VReg___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VReg___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VReg___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void VReg___024root__trace_register(VReg___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&VReg___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&VReg___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&VReg___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void VReg___024root__trace_full_sub_0(VReg___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void VReg___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root__trace_full_top_0\n"); );
    // Init
    VReg___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VReg___024root*>(voidSelf);
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    VReg___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void VReg___024root__trace_full_sub_0(VReg___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullCData(oldp+1,(vlSelf->MuxKey__DOT__i0__DOT__pair_list[0]),2);
    bufp->fullCData(oldp+2,(vlSelf->MuxKey__DOT__i0__DOT__pair_list[1]),2);
    bufp->fullBit(oldp+3,(vlSelf->MuxKey__DOT__i0__DOT__key_list[0]));
    bufp->fullBit(oldp+4,(vlSelf->MuxKey__DOT__i0__DOT__key_list[1]));
    bufp->fullBit(oldp+5,(vlSelf->MuxKey__DOT__i0__DOT__data_list[0]));
    bufp->fullBit(oldp+6,(vlSelf->MuxKey__DOT__i0__DOT__data_list[1]));
    bufp->fullBit(oldp+7,(vlSelf->MuxKey__DOT__i0__DOT__lut_out));
    bufp->fullBit(oldp+8,(vlSelf->MuxKey__DOT__i0__DOT__hit));
    bufp->fullCData(oldp+9,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__pair_list[0]),2);
    bufp->fullCData(oldp+10,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__pair_list[1]),2);
    bufp->fullBit(oldp+11,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list[0]));
    bufp->fullBit(oldp+12,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list[1]));
    bufp->fullBit(oldp+13,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__data_list[0]));
    bufp->fullBit(oldp+14,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__data_list[1]));
    bufp->fullBit(oldp+15,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__lut_out));
    bufp->fullBit(oldp+16,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__hit));
    bufp->fullCData(oldp+17,(((0x13U == (0x7fU & vlSelf->top__DOT__data))
                               ? ((0U == (7U & (vlSelf->top__DOT__data 
                                                >> 0xcU)))
                                   ? 1U : ((2U == (7U 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 0xcU)))
                                            ? 2U : 
                                           ((3U == 
                                             (7U & 
                                              (vlSelf->top__DOT__data 
                                               >> 0xcU)))
                                             ? 3U : 
                                            ((4U == 
                                              (7U & 
                                               (vlSelf->top__DOT__data 
                                                >> 0xcU)))
                                              ? 4U : 
                                             ((6U == 
                                               (7U 
                                                & (vlSelf->top__DOT__data 
                                                   >> 0xcU)))
                                               ? 5U
                                               : ((7U 
                                                   == 
                                                   (7U 
                                                    & (vlSelf->top__DOT__data 
                                                       >> 0xcU)))
                                                   ? 6U
                                                   : 0U))))))
                               : 0U)),8);
    bufp->fullIData(oldp+18,(vlSelf->top__DOT__addr),32);
    bufp->fullIData(oldp+19,(vlSelf->top__DOT__data),32);
    bufp->fullCData(oldp+20,((0x1fU & (vlSelf->top__DOT__data 
                                       >> 0xfU))),5);
    bufp->fullCData(oldp+21,((0x1fU & (vlSelf->top__DOT__data 
                                       >> 0x14U))),5);
    bufp->fullIData(oldp+22,(((0x13U == (0x7fU & vlSelf->top__DOT__data))
                               ? (((- (IData)((vlSelf->top__DOT__data 
                                               >> 0x1fU))) 
                                   << 0xcU) | (vlSelf->top__DOT__data 
                                               >> 0x14U))
                               : 0U)),32);
    bufp->fullIData(oldp+23,(vlSelf->top__DOT__gpr__DOT__reg_file
                             [(0x1fU & (vlSelf->top__DOT__data 
                                        >> 0xfU))]),32);
    bufp->fullIData(oldp+24,(vlSelf->top__DOT__gpr__DOT__reg_file
                             [(0x1fU & (vlSelf->top__DOT__data 
                                        >> 0x14U))]),32);
    bufp->fullIData(oldp+25,(vlSelf->top__DOT__result),32);
    bufp->fullCData(oldp+26,((0x1fU & (vlSelf->top__DOT__data 
                                       >> 7U))),5);
    bufp->fullCData(oldp+27,((7U & (vlSelf->top__DOT__data 
                                    >> 0xcU))),3);
    bufp->fullCData(oldp+28,((0x7fU & vlSelf->top__DOT__data)),7);
    bufp->fullIData(oldp+29,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                               >> 7U)))
                               ? ((IData)(1U) << (0x1fU 
                                                  & (vlSelf->top__DOT__data 
                                                     >> 7U)))
                               : 0U)),32);
    bufp->fullIData(oldp+30,(vlSelf->top__DOT__gpr__DOT__reg_file[0]),32);
    bufp->fullIData(oldp+31,(vlSelf->top__DOT__gpr__DOT__reg_file[1]),32);
    bufp->fullIData(oldp+32,(vlSelf->top__DOT__gpr__DOT__reg_file[2]),32);
    bufp->fullIData(oldp+33,(vlSelf->top__DOT__gpr__DOT__reg_file[3]),32);
    bufp->fullIData(oldp+34,(vlSelf->top__DOT__gpr__DOT__reg_file[4]),32);
    bufp->fullIData(oldp+35,(vlSelf->top__DOT__gpr__DOT__reg_file[5]),32);
    bufp->fullIData(oldp+36,(vlSelf->top__DOT__gpr__DOT__reg_file[6]),32);
    bufp->fullIData(oldp+37,(vlSelf->top__DOT__gpr__DOT__reg_file[7]),32);
    bufp->fullIData(oldp+38,(vlSelf->top__DOT__gpr__DOT__reg_file[8]),32);
    bufp->fullIData(oldp+39,(vlSelf->top__DOT__gpr__DOT__reg_file[9]),32);
    bufp->fullIData(oldp+40,(vlSelf->top__DOT__gpr__DOT__reg_file[10]),32);
    bufp->fullIData(oldp+41,(vlSelf->top__DOT__gpr__DOT__reg_file[11]),32);
    bufp->fullIData(oldp+42,(vlSelf->top__DOT__gpr__DOT__reg_file[12]),32);
    bufp->fullIData(oldp+43,(vlSelf->top__DOT__gpr__DOT__reg_file[13]),32);
    bufp->fullIData(oldp+44,(vlSelf->top__DOT__gpr__DOT__reg_file[14]),32);
    bufp->fullIData(oldp+45,(vlSelf->top__DOT__gpr__DOT__reg_file[15]),32);
    bufp->fullIData(oldp+46,(vlSelf->top__DOT__gpr__DOT__reg_file[16]),32);
    bufp->fullIData(oldp+47,(vlSelf->top__DOT__gpr__DOT__reg_file[17]),32);
    bufp->fullIData(oldp+48,(vlSelf->top__DOT__gpr__DOT__reg_file[18]),32);
    bufp->fullIData(oldp+49,(vlSelf->top__DOT__gpr__DOT__reg_file[19]),32);
    bufp->fullIData(oldp+50,(vlSelf->top__DOT__gpr__DOT__reg_file[20]),32);
    bufp->fullIData(oldp+51,(vlSelf->top__DOT__gpr__DOT__reg_file[21]),32);
    bufp->fullIData(oldp+52,(vlSelf->top__DOT__gpr__DOT__reg_file[22]),32);
    bufp->fullIData(oldp+53,(vlSelf->top__DOT__gpr__DOT__reg_file[23]),32);
    bufp->fullIData(oldp+54,(vlSelf->top__DOT__gpr__DOT__reg_file[24]),32);
    bufp->fullIData(oldp+55,(vlSelf->top__DOT__gpr__DOT__reg_file[25]),32);
    bufp->fullIData(oldp+56,(vlSelf->top__DOT__gpr__DOT__reg_file[26]),32);
    bufp->fullIData(oldp+57,(vlSelf->top__DOT__gpr__DOT__reg_file[27]),32);
    bufp->fullIData(oldp+58,(vlSelf->top__DOT__gpr__DOT__reg_file[28]),32);
    bufp->fullIData(oldp+59,(vlSelf->top__DOT__gpr__DOT__reg_file[29]),32);
    bufp->fullIData(oldp+60,(vlSelf->top__DOT__gpr__DOT__reg_file[30]),32);
    bufp->fullIData(oldp+61,(vlSelf->top__DOT__gpr__DOT__reg_file[31]),32);
    bufp->fullIData(oldp+62,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+63,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & ((IData)(1U) << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))))));
    bufp->fullIData(oldp+64,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+65,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xaU))));
    bufp->fullIData(oldp+66,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+67,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xbU))));
    bufp->fullIData(oldp+68,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+69,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xcU))));
    bufp->fullIData(oldp+70,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+71,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xdU))));
    bufp->fullIData(oldp+72,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+73,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xeU))));
    bufp->fullIData(oldp+74,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+75,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0xfU))));
    bufp->fullIData(oldp+76,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+77,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x10U))));
    bufp->fullIData(oldp+78,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+79,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x11U))));
    bufp->fullIData(oldp+80,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+81,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x12U))));
    bufp->fullIData(oldp+82,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+83,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x13U))));
    bufp->fullIData(oldp+84,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+85,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 1U))));
    bufp->fullIData(oldp+86,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+87,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x14U))));
    bufp->fullIData(oldp+88,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+89,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x15U))));
    bufp->fullIData(oldp+90,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+91,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x16U))));
    bufp->fullIData(oldp+92,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+93,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x17U))));
    bufp->fullIData(oldp+94,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+95,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x18U))));
    bufp->fullIData(oldp+96,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+97,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x19U))));
    bufp->fullIData(oldp+98,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+99,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                             >> 7U))) 
                            & (((IData)(1U) << (0x1fU 
                                                & (vlSelf->top__DOT__data 
                                                   >> 7U))) 
                               >> 0x1aU))));
    bufp->fullIData(oldp+100,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+101,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 0x1bU))));
    bufp->fullIData(oldp+102,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+103,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 0x1cU))));
    bufp->fullIData(oldp+104,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+105,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 0x1dU))));
    bufp->fullIData(oldp+106,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+107,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 2U))));
    bufp->fullIData(oldp+108,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+109,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 0x1eU))));
    bufp->fullIData(oldp+110,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+111,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 0x1fU))));
    bufp->fullIData(oldp+112,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+113,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 3U))));
    bufp->fullIData(oldp+114,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+115,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 4U))));
    bufp->fullIData(oldp+116,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+117,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 5U))));
    bufp->fullIData(oldp+118,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+119,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 6U))));
    bufp->fullIData(oldp+120,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+121,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 7U))));
    bufp->fullIData(oldp+122,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+123,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 8U))));
    bufp->fullIData(oldp+124,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout),32);
    bufp->fullBit(oldp+125,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                             & (((IData)(1U) << (0x1fU 
                                                 & (vlSelf->top__DOT__data 
                                                    >> 7U))) 
                                >> 9U))));
    bufp->fullBit(oldp+126,(vlSelf->MuxKey__02Eout));
    bufp->fullBit(oldp+127,(vlSelf->MuxKey__02Ekey));
    bufp->fullCData(oldp+128,(vlSelf->MuxKey__02Elut),4);
    bufp->fullBit(oldp+129,(vlSelf->MuxKeyWithDefault__02Eout));
    bufp->fullBit(oldp+130,(vlSelf->MuxKeyWithDefault__02Ekey));
    bufp->fullBit(oldp+131,(vlSelf->default_out));
    bufp->fullCData(oldp+132,(vlSelf->MuxKeyWithDefault__02Elut),4);
    bufp->fullBit(oldp+133,(vlSelf->clk));
    bufp->fullBit(oldp+134,(vlSelf->reset));
    bufp->fullIData(oldp+135,(2U),32);
    bufp->fullIData(oldp+136,(1U),32);
    bufp->fullIData(oldp+137,(0U),32);
    bufp->fullBit(oldp+138,(0U));
    bufp->fullIData(oldp+139,(2U),32);
    bufp->fullIData(oldp+140,(vlSelf->top__DOT__pc_next),32);
    bufp->fullBit(oldp+141,(vlSelf->top__DOT__jump_singnal));
    bufp->fullBit(oldp+142,(vlSelf->top__DOT__ram_signal));
    bufp->fullIData(oldp+143,(0x20U),32);
    bufp->fullIData(oldp+144,(4U),32);
    bufp->fullIData(oldp+145,(5U),32);
    bufp->fullCData(oldp+146,(0xfU),4);
}
