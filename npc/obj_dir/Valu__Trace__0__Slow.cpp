// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Valu__Syms.h"


VL_ATTR_COLD void Valu___024root__trace_init_sub__TOP__0(Valu___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+81,"alu.src1", false,-1, 31,0);
    tracep->declBus(c+82,"alu.src2", false,-1, 31,0);
    tracep->declBus(c+83,"alu.imm", false,-1, 31,0);
    tracep->declBus(c+84,"ram_data", false,-1, 31,0);
    tracep->declBus(c+85,"op_ins", false,-1, 7,0);
    tracep->declBus(c+86,"alu.out", false,-1, 31,0);
    tracep->declBit(c+87,"alu.ram_signal", false,-1);
    tracep->declBit(c+88,"jump_signal", false,-1);
    tracep->declBus(c+89,"pc_next", false,-1, 31,0);
    tracep->declBus(c+90,"ins", false,-1, 31,0);
    tracep->declBus(c+91,"decoder.rd", false,-1, 4,0);
    tracep->declBus(c+92,"decoder.rs1", false,-1, 4,0);
    tracep->declBus(c+93,"decoder.rs2", false,-1, 4,0);
    tracep->declBus(c+94,"decoder.imm", false,-1, 31,0);
    tracep->declBus(c+95,"instruction", false,-1, 7,0);
    tracep->declBit(c+96,"gpr.clk", false,-1);
    tracep->declBit(c+97,"gpr.rst", false,-1);
    tracep->declBus(c+98,"gpr.rs1", false,-1, 4,0);
    tracep->declBus(c+99,"gpr.rs2", false,-1, 4,0);
    tracep->declBus(c+100,"gpr.rd", false,-1, 4,0);
    tracep->declBus(c+101,"gpr.data_in", false,-1, 31,0);
    tracep->declBus(c+102,"gpr.src1", false,-1, 31,0);
    tracep->declBus(c+103,"gpr.src2", false,-1, 31,0);
    tracep->declBit(c+104,"pc.clk", false,-1);
    tracep->declBit(c+105,"pc.rst", false,-1);
    tracep->declBus(c+106,"din", false,-1, 31,0);
    tracep->declBus(c+107,"dout", false,-1, 31,0);
    tracep->declBit(c+108,"jump", false,-1);
    tracep->declBus(c+109,"rom.addr", false,-1, 31,0);
    tracep->declBus(c+110,"data", false,-1, 31,0);
    tracep->declBus(c+111,"MuxKey.out", false,-1, 0,0);
    tracep->declBus(c+112,"MuxKey.key", false,-1, 0,0);
    tracep->declBus(c+113,"MuxKey.lut", false,-1, 3,0);
    tracep->declBus(c+114,"MuxKeyWithDefault.out", false,-1, 0,0);
    tracep->declBus(c+115,"MuxKeyWithDefault.key", false,-1, 0,0);
    tracep->declBus(c+116,"default_out", false,-1, 0,0);
    tracep->declBus(c+117,"MuxKeyWithDefault.lut", false,-1, 3,0);
    tracep->declBit(c+118,"ram.clk", false,-1);
    tracep->declBit(c+119,"ram.rst", false,-1);
    tracep->declBus(c+120,"ram.data_in", false,-1, 31,0);
    tracep->declBus(c+121,"ram.addr", false,-1, 31,0);
    tracep->declBus(c+122,"byte_en", false,-1, 3,0);
    tracep->declBus(c+123,"data_out", false,-1, 31,0);
    tracep->declBit(c+124,"ram.ram_signal", false,-1);
    tracep->pushNamePrefix("MuxKey ");
    tracep->declBus(c+163,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+164,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+164,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+111,"out", false,-1, 0,0);
    tracep->declBus(c+112,"key", false,-1, 0,0);
    tracep->declBus(c+113,"lut", false,-1, 3,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+163,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+164,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+164,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+165,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+111,"out", false,-1, 0,0);
    tracep->declBus(c+112,"key", false,-1, 0,0);
    tracep->declBus(c+166,"default_out", false,-1, 0,0);
    tracep->declBus(c+113,"lut", false,-1, 3,0);
    tracep->declBus(c+163,"PAIR_LEN", false,-1, 31,0);
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
    tracep->declBus(c+167,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("MuxKeyWithDefault ");
    tracep->declBus(c+163,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+164,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+164,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+114,"out", false,-1, 0,0);
    tracep->declBus(c+115,"key", false,-1, 0,0);
    tracep->declBus(c+116,"default_out", false,-1, 0,0);
    tracep->declBus(c+117,"lut", false,-1, 3,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+163,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+164,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+164,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+164,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+114,"out", false,-1, 0,0);
    tracep->declBus(c+115,"key", false,-1, 0,0);
    tracep->declBus(c+116,"default_out", false,-1, 0,0);
    tracep->declBus(c+117,"lut", false,-1, 3,0);
    tracep->declBus(c+163,"PAIR_LEN", false,-1, 31,0);
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
    tracep->declBus(c+167,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+81,"src1", false,-1, 31,0);
    tracep->declBus(c+82,"src2", false,-1, 31,0);
    tracep->declBus(c+83,"imm", false,-1, 31,0);
    tracep->declBus(c+84,"ram_data", false,-1, 31,0);
    tracep->declBus(c+85,"op_ins", false,-1, 7,0);
    tracep->declBus(c+86,"out", false,-1, 31,0);
    tracep->declBit(c+87,"ram_signal", false,-1);
    tracep->declBit(c+88,"jump_signal", false,-1);
    tracep->declBus(c+89,"pc_next", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("decoder ");
    tracep->declBus(c+169,"INS_BYTES", false,-1, 31,0);
    tracep->declBus(c+170,"REG_ADDR_LEN", false,-1, 31,0);
    tracep->declBus(c+90,"ins", false,-1, 31,0);
    tracep->declBus(c+91,"rd", false,-1, 4,0);
    tracep->declBus(c+92,"rs1", false,-1, 4,0);
    tracep->declBus(c+93,"rs2", false,-1, 4,0);
    tracep->declBus(c+94,"imm", false,-1, 31,0);
    tracep->declBus(c+95,"instruction", false,-1, 7,0);
    tracep->declBus(c+125,"fun1", false,-1, 2,0);
    tracep->declBus(c+126,"opcode", false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("gpr ");
    tracep->declBus(c+170,"REG_ADDR_LEN", false,-1, 31,0);
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+168,"REGS", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+98,"rs1", false,-1, 4,0);
    tracep->declBus(c+99,"rs2", false,-1, 4,0);
    tracep->declBus(c+100,"rd", false,-1, 4,0);
    tracep->declBus(c+101,"data_in", false,-1, 31,0);
    tracep->declBus(c+102,"src1", false,-1, 31,0);
    tracep->declBus(c+103,"src2", false,-1, 31,0);
    tracep->declBus(c+127,"we", false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+17+i*1,"reg_file", true,(i+0), 31,0);
    }
    tracep->pushNamePrefix("genblk1[0] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+49,"dout", false,-1, 31,0);
    tracep->declBit(c+128,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[10] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+50,"dout", false,-1, 31,0);
    tracep->declBit(c+129,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[11] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+51,"dout", false,-1, 31,0);
    tracep->declBit(c+130,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[12] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+52,"dout", false,-1, 31,0);
    tracep->declBit(c+131,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[13] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+53,"dout", false,-1, 31,0);
    tracep->declBit(c+132,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[14] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+54,"dout", false,-1, 31,0);
    tracep->declBit(c+133,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[15] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+55,"dout", false,-1, 31,0);
    tracep->declBit(c+134,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[16] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+56,"dout", false,-1, 31,0);
    tracep->declBit(c+135,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[17] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+57,"dout", false,-1, 31,0);
    tracep->declBit(c+136,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[18] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+58,"dout", false,-1, 31,0);
    tracep->declBit(c+137,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[19] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+59,"dout", false,-1, 31,0);
    tracep->declBit(c+138,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[1] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+60,"dout", false,-1, 31,0);
    tracep->declBit(c+139,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[20] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+61,"dout", false,-1, 31,0);
    tracep->declBit(c+140,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[21] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+62,"dout", false,-1, 31,0);
    tracep->declBit(c+141,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[22] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+63,"dout", false,-1, 31,0);
    tracep->declBit(c+142,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[23] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+64,"dout", false,-1, 31,0);
    tracep->declBit(c+143,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[24] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+65,"dout", false,-1, 31,0);
    tracep->declBit(c+144,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[25] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+66,"dout", false,-1, 31,0);
    tracep->declBit(c+145,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[26] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+67,"dout", false,-1, 31,0);
    tracep->declBit(c+146,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[27] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+68,"dout", false,-1, 31,0);
    tracep->declBit(c+147,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[28] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+69,"dout", false,-1, 31,0);
    tracep->declBit(c+148,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[29] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+70,"dout", false,-1, 31,0);
    tracep->declBit(c+149,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[2] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+71,"dout", false,-1, 31,0);
    tracep->declBit(c+150,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[30] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+72,"dout", false,-1, 31,0);
    tracep->declBit(c+151,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[31] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+73,"dout", false,-1, 31,0);
    tracep->declBit(c+152,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[3] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+74,"dout", false,-1, 31,0);
    tracep->declBit(c+153,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[4] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+75,"dout", false,-1, 31,0);
    tracep->declBit(c+154,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[5] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+76,"dout", false,-1, 31,0);
    tracep->declBit(c+155,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[6] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+77,"dout", false,-1, 31,0);
    tracep->declBit(c+156,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[7] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+78,"dout", false,-1, 31,0);
    tracep->declBit(c+157,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[8] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+79,"dout", false,-1, 31,0);
    tracep->declBit(c+158,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[9] ");
    tracep->pushNamePrefix("r0 ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+165,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+96,"clk", false,-1);
    tracep->declBit(c+97,"rst", false,-1);
    tracep->declBus(c+101,"din", false,-1, 31,0);
    tracep->declBus(c+80,"dout", false,-1, 31,0);
    tracep->declBit(c+159,"wen", false,-1);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("pc ");
    tracep->declBus(c+168,"PC_LEN", false,-1, 31,0);
    tracep->declBus(c+169,"INS_BYTES", false,-1, 31,0);
    tracep->declBit(c+104,"clk", false,-1);
    tracep->declBit(c+105,"rst", false,-1);
    tracep->declBus(c+106,"din", false,-1, 31,0);
    tracep->declBus(c+107,"dout", false,-1, 31,0);
    tracep->declBit(c+108,"jump", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("ram ");
    tracep->declBus(c+168,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+169,"INS_BYTES", false,-1, 31,0);
    tracep->declBus(c+168,"PC_LEN", false,-1, 31,0);
    tracep->declBit(c+118,"clk", false,-1);
    tracep->declBit(c+119,"rst", false,-1);
    tracep->declBus(c+120,"data_in", false,-1, 31,0);
    tracep->declBus(c+121,"addr", false,-1, 31,0);
    tracep->declBus(c+122,"byte_en", false,-1, 3,0);
    tracep->declBus(c+123,"data_out", false,-1, 31,0);
    tracep->declBit(c+124,"ram_signal", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rom ");
    tracep->declBus(c+168,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+109,"addr", false,-1, 31,0);
    tracep->declBus(c+110,"data", false,-1, 31,0);
    tracep->declBus(c+160,"shifted_addr", false,-1, 31,0);
    tracep->declBus(c+161,"rom_offset", false,-1, 9,0);
    tracep->declBus(c+162,"unused_signal", false,-1, 31,10);
    tracep->popNamePrefix(1);
}

VL_ATTR_COLD void Valu___024root__trace_init_top(Valu___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root__trace_init_top\n"); );
    // Body
    Valu___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Valu___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Valu___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Valu___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Valu___024root__trace_register(Valu___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Valu___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Valu___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Valu___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Valu___024root__trace_full_sub_0(Valu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Valu___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root__trace_full_top_0\n"); );
    // Init
    Valu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu___024root*>(voidSelf);
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Valu___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Valu___024root__trace_full_sub_0(Valu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root__trace_full_sub_0\n"); );
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
    bufp->fullIData(oldp+17,(vlSelf->gpr__DOT__reg_file[0]),32);
    bufp->fullIData(oldp+18,(vlSelf->gpr__DOT__reg_file[1]),32);
    bufp->fullIData(oldp+19,(vlSelf->gpr__DOT__reg_file[2]),32);
    bufp->fullIData(oldp+20,(vlSelf->gpr__DOT__reg_file[3]),32);
    bufp->fullIData(oldp+21,(vlSelf->gpr__DOT__reg_file[4]),32);
    bufp->fullIData(oldp+22,(vlSelf->gpr__DOT__reg_file[5]),32);
    bufp->fullIData(oldp+23,(vlSelf->gpr__DOT__reg_file[6]),32);
    bufp->fullIData(oldp+24,(vlSelf->gpr__DOT__reg_file[7]),32);
    bufp->fullIData(oldp+25,(vlSelf->gpr__DOT__reg_file[8]),32);
    bufp->fullIData(oldp+26,(vlSelf->gpr__DOT__reg_file[9]),32);
    bufp->fullIData(oldp+27,(vlSelf->gpr__DOT__reg_file[10]),32);
    bufp->fullIData(oldp+28,(vlSelf->gpr__DOT__reg_file[11]),32);
    bufp->fullIData(oldp+29,(vlSelf->gpr__DOT__reg_file[12]),32);
    bufp->fullIData(oldp+30,(vlSelf->gpr__DOT__reg_file[13]),32);
    bufp->fullIData(oldp+31,(vlSelf->gpr__DOT__reg_file[14]),32);
    bufp->fullIData(oldp+32,(vlSelf->gpr__DOT__reg_file[15]),32);
    bufp->fullIData(oldp+33,(vlSelf->gpr__DOT__reg_file[16]),32);
    bufp->fullIData(oldp+34,(vlSelf->gpr__DOT__reg_file[17]),32);
    bufp->fullIData(oldp+35,(vlSelf->gpr__DOT__reg_file[18]),32);
    bufp->fullIData(oldp+36,(vlSelf->gpr__DOT__reg_file[19]),32);
    bufp->fullIData(oldp+37,(vlSelf->gpr__DOT__reg_file[20]),32);
    bufp->fullIData(oldp+38,(vlSelf->gpr__DOT__reg_file[21]),32);
    bufp->fullIData(oldp+39,(vlSelf->gpr__DOT__reg_file[22]),32);
    bufp->fullIData(oldp+40,(vlSelf->gpr__DOT__reg_file[23]),32);
    bufp->fullIData(oldp+41,(vlSelf->gpr__DOT__reg_file[24]),32);
    bufp->fullIData(oldp+42,(vlSelf->gpr__DOT__reg_file[25]),32);
    bufp->fullIData(oldp+43,(vlSelf->gpr__DOT__reg_file[26]),32);
    bufp->fullIData(oldp+44,(vlSelf->gpr__DOT__reg_file[27]),32);
    bufp->fullIData(oldp+45,(vlSelf->gpr__DOT__reg_file[28]),32);
    bufp->fullIData(oldp+46,(vlSelf->gpr__DOT__reg_file[29]),32);
    bufp->fullIData(oldp+47,(vlSelf->gpr__DOT__reg_file[30]),32);
    bufp->fullIData(oldp+48,(vlSelf->gpr__DOT__reg_file[31]),32);
    bufp->fullIData(oldp+49,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+50,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+51,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+52,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+53,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+54,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+55,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+56,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+57,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+58,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+59,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+60,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+61,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+62,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+63,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+64,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+65,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+66,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+67,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+68,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+69,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+70,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+71,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+72,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+73,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+74,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+75,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+76,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+77,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+78,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+79,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+80,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout),32);
    bufp->fullIData(oldp+81,(vlSelf->alu__02Esrc1),32);
    bufp->fullIData(oldp+82,(vlSelf->alu__02Esrc2),32);
    bufp->fullIData(oldp+83,(vlSelf->alu__02Eimm),32);
    bufp->fullIData(oldp+84,(vlSelf->ram_data),32);
    bufp->fullCData(oldp+85,(vlSelf->op_ins),8);
    bufp->fullIData(oldp+86,(vlSelf->alu__02Eout),32);
    bufp->fullBit(oldp+87,(vlSelf->alu__02Eram_signal));
    bufp->fullBit(oldp+88,(vlSelf->jump_signal));
    bufp->fullIData(oldp+89,(vlSelf->pc_next),32);
    bufp->fullIData(oldp+90,(vlSelf->ins),32);
    bufp->fullCData(oldp+91,(vlSelf->decoder__02Erd),5);
    bufp->fullCData(oldp+92,(vlSelf->decoder__02Ers1),5);
    bufp->fullCData(oldp+93,(vlSelf->decoder__02Ers2),5);
    bufp->fullIData(oldp+94,(vlSelf->decoder__02Eimm),32);
    bufp->fullCData(oldp+95,(vlSelf->instruction),8);
    bufp->fullBit(oldp+96,(vlSelf->gpr__02Eclk));
    bufp->fullBit(oldp+97,(vlSelf->gpr__02Erst));
    bufp->fullCData(oldp+98,(vlSelf->gpr__02Ers1),5);
    bufp->fullCData(oldp+99,(vlSelf->gpr__02Ers2),5);
    bufp->fullCData(oldp+100,(vlSelf->gpr__02Erd),5);
    bufp->fullIData(oldp+101,(vlSelf->gpr__02Edata_in),32);
    bufp->fullIData(oldp+102,(vlSelf->gpr__02Esrc1),32);
    bufp->fullIData(oldp+103,(vlSelf->gpr__02Esrc2),32);
    bufp->fullBit(oldp+104,(vlSelf->pc__02Eclk));
    bufp->fullBit(oldp+105,(vlSelf->pc__02Erst));
    bufp->fullIData(oldp+106,(vlSelf->din),32);
    bufp->fullIData(oldp+107,(vlSelf->dout),32);
    bufp->fullBit(oldp+108,(vlSelf->jump));
    bufp->fullIData(oldp+109,(vlSelf->rom__02Eaddr),32);
    bufp->fullIData(oldp+110,(vlSelf->data),32);
    bufp->fullBit(oldp+111,(vlSelf->MuxKey__02Eout));
    bufp->fullBit(oldp+112,(vlSelf->MuxKey__02Ekey));
    bufp->fullCData(oldp+113,(vlSelf->MuxKey__02Elut),4);
    bufp->fullBit(oldp+114,(vlSelf->MuxKeyWithDefault__02Eout));
    bufp->fullBit(oldp+115,(vlSelf->MuxKeyWithDefault__02Ekey));
    bufp->fullBit(oldp+116,(vlSelf->default_out));
    bufp->fullCData(oldp+117,(vlSelf->MuxKeyWithDefault__02Elut),4);
    bufp->fullBit(oldp+118,(vlSelf->ram__02Eclk));
    bufp->fullBit(oldp+119,(vlSelf->ram__02Erst));
    bufp->fullIData(oldp+120,(vlSelf->ram__02Edata_in),32);
    bufp->fullIData(oldp+121,(vlSelf->ram__02Eaddr),32);
    bufp->fullCData(oldp+122,(vlSelf->byte_en),4);
    bufp->fullIData(oldp+123,(vlSelf->data_out),32);
    bufp->fullBit(oldp+124,(vlSelf->ram__02Eram_signal));
    bufp->fullCData(oldp+125,((7U & (vlSelf->ins >> 0xcU))),3);
    bufp->fullCData(oldp+126,((0x7fU & vlSelf->ins)),7);
    bufp->fullIData(oldp+127,(((0U != (IData)(vlSelf->gpr__02Erd))
                                ? ((IData)(1U) << (IData)(vlSelf->gpr__02Erd))
                                : 0U)),32);
    bufp->fullBit(oldp+128,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & ((IData)(1U) << (IData)(vlSelf->gpr__02Erd)))));
    bufp->fullBit(oldp+129,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0xaU))));
    bufp->fullBit(oldp+130,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0xbU))));
    bufp->fullBit(oldp+131,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0xcU))));
    bufp->fullBit(oldp+132,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0xdU))));
    bufp->fullBit(oldp+133,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0xeU))));
    bufp->fullBit(oldp+134,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0xfU))));
    bufp->fullBit(oldp+135,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x10U))));
    bufp->fullBit(oldp+136,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x11U))));
    bufp->fullBit(oldp+137,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x12U))));
    bufp->fullBit(oldp+138,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x13U))));
    bufp->fullBit(oldp+139,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 1U))));
    bufp->fullBit(oldp+140,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x14U))));
    bufp->fullBit(oldp+141,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x15U))));
    bufp->fullBit(oldp+142,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x16U))));
    bufp->fullBit(oldp+143,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x17U))));
    bufp->fullBit(oldp+144,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x18U))));
    bufp->fullBit(oldp+145,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x19U))));
    bufp->fullBit(oldp+146,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x1aU))));
    bufp->fullBit(oldp+147,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x1bU))));
    bufp->fullBit(oldp+148,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x1cU))));
    bufp->fullBit(oldp+149,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x1dU))));
    bufp->fullBit(oldp+150,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 2U))));
    bufp->fullBit(oldp+151,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x1eU))));
    bufp->fullBit(oldp+152,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 0x1fU))));
    bufp->fullBit(oldp+153,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 3U))));
    bufp->fullBit(oldp+154,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 4U))));
    bufp->fullBit(oldp+155,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 5U))));
    bufp->fullBit(oldp+156,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 6U))));
    bufp->fullBit(oldp+157,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 7U))));
    bufp->fullBit(oldp+158,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 8U))));
    bufp->fullBit(oldp+159,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                             & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                                >> 9U))));
    bufp->fullIData(oldp+160,(((vlSelf->rom__02Eaddr 
                                - (IData)(0x80000000U)) 
                               >> 2U)),32);
    bufp->fullSData(oldp+161,((0x3ffU & ((vlSelf->rom__02Eaddr 
                                          - (IData)(0x80000000U)) 
                                         >> 2U))),10);
    bufp->fullIData(oldp+162,((0x3fffffU & ((vlSelf->rom__02Eaddr 
                                             - (IData)(0x80000000U)) 
                                            >> 0xcU))),22);
    bufp->fullIData(oldp+163,(2U),32);
    bufp->fullIData(oldp+164,(1U),32);
    bufp->fullIData(oldp+165,(0U),32);
    bufp->fullBit(oldp+166,(0U));
    bufp->fullIData(oldp+167,(2U),32);
    bufp->fullIData(oldp+168,(0x20U),32);
    bufp->fullIData(oldp+169,(4U),32);
    bufp->fullIData(oldp+170,(5U),32);
}
