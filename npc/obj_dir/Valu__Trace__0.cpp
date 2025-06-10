// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Valu__Syms.h"


void Valu___024root__trace_chg_sub_0(Valu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Valu___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root__trace_chg_top_0\n"); );
    // Init
    Valu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu___024root*>(voidSelf);
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Valu___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Valu___024root__trace_chg_sub_0(Valu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgCData(oldp+0,(vlSelf->MuxKey__DOT__i0__DOT__pair_list[0]),2);
        bufp->chgCData(oldp+1,(vlSelf->MuxKey__DOT__i0__DOT__pair_list[1]),2);
        bufp->chgBit(oldp+2,(vlSelf->MuxKey__DOT__i0__DOT__key_list[0]));
        bufp->chgBit(oldp+3,(vlSelf->MuxKey__DOT__i0__DOT__key_list[1]));
        bufp->chgBit(oldp+4,(vlSelf->MuxKey__DOT__i0__DOT__data_list[0]));
        bufp->chgBit(oldp+5,(vlSelf->MuxKey__DOT__i0__DOT__data_list[1]));
        bufp->chgBit(oldp+6,(vlSelf->MuxKey__DOT__i0__DOT__lut_out));
        bufp->chgBit(oldp+7,(vlSelf->MuxKey__DOT__i0__DOT__hit));
        bufp->chgCData(oldp+8,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__pair_list[0]),2);
        bufp->chgCData(oldp+9,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__pair_list[1]),2);
        bufp->chgBit(oldp+10,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list[0]));
        bufp->chgBit(oldp+11,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list[1]));
        bufp->chgBit(oldp+12,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__data_list[0]));
        bufp->chgBit(oldp+13,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__data_list[1]));
        bufp->chgBit(oldp+14,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__lut_out));
        bufp->chgBit(oldp+15,(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__hit));
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[2U])) {
        bufp->chgIData(oldp+16,(vlSelf->gpr__DOT__reg_file[0]),32);
        bufp->chgIData(oldp+17,(vlSelf->gpr__DOT__reg_file[1]),32);
        bufp->chgIData(oldp+18,(vlSelf->gpr__DOT__reg_file[2]),32);
        bufp->chgIData(oldp+19,(vlSelf->gpr__DOT__reg_file[3]),32);
        bufp->chgIData(oldp+20,(vlSelf->gpr__DOT__reg_file[4]),32);
        bufp->chgIData(oldp+21,(vlSelf->gpr__DOT__reg_file[5]),32);
        bufp->chgIData(oldp+22,(vlSelf->gpr__DOT__reg_file[6]),32);
        bufp->chgIData(oldp+23,(vlSelf->gpr__DOT__reg_file[7]),32);
        bufp->chgIData(oldp+24,(vlSelf->gpr__DOT__reg_file[8]),32);
        bufp->chgIData(oldp+25,(vlSelf->gpr__DOT__reg_file[9]),32);
        bufp->chgIData(oldp+26,(vlSelf->gpr__DOT__reg_file[10]),32);
        bufp->chgIData(oldp+27,(vlSelf->gpr__DOT__reg_file[11]),32);
        bufp->chgIData(oldp+28,(vlSelf->gpr__DOT__reg_file[12]),32);
        bufp->chgIData(oldp+29,(vlSelf->gpr__DOT__reg_file[13]),32);
        bufp->chgIData(oldp+30,(vlSelf->gpr__DOT__reg_file[14]),32);
        bufp->chgIData(oldp+31,(vlSelf->gpr__DOT__reg_file[15]),32);
        bufp->chgIData(oldp+32,(vlSelf->gpr__DOT__reg_file[16]),32);
        bufp->chgIData(oldp+33,(vlSelf->gpr__DOT__reg_file[17]),32);
        bufp->chgIData(oldp+34,(vlSelf->gpr__DOT__reg_file[18]),32);
        bufp->chgIData(oldp+35,(vlSelf->gpr__DOT__reg_file[19]),32);
        bufp->chgIData(oldp+36,(vlSelf->gpr__DOT__reg_file[20]),32);
        bufp->chgIData(oldp+37,(vlSelf->gpr__DOT__reg_file[21]),32);
        bufp->chgIData(oldp+38,(vlSelf->gpr__DOT__reg_file[22]),32);
        bufp->chgIData(oldp+39,(vlSelf->gpr__DOT__reg_file[23]),32);
        bufp->chgIData(oldp+40,(vlSelf->gpr__DOT__reg_file[24]),32);
        bufp->chgIData(oldp+41,(vlSelf->gpr__DOT__reg_file[25]),32);
        bufp->chgIData(oldp+42,(vlSelf->gpr__DOT__reg_file[26]),32);
        bufp->chgIData(oldp+43,(vlSelf->gpr__DOT__reg_file[27]),32);
        bufp->chgIData(oldp+44,(vlSelf->gpr__DOT__reg_file[28]),32);
        bufp->chgIData(oldp+45,(vlSelf->gpr__DOT__reg_file[29]),32);
        bufp->chgIData(oldp+46,(vlSelf->gpr__DOT__reg_file[30]),32);
        bufp->chgIData(oldp+47,(vlSelf->gpr__DOT__reg_file[31]),32);
        bufp->chgIData(oldp+48,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+49,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+50,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+51,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+52,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+53,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+54,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+55,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+56,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+57,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+58,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+59,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+60,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+61,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+62,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+63,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+64,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+65,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+66,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+67,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+68,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+69,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+70,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+71,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+72,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+73,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+74,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+75,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+76,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+77,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+78,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout),32);
        bufp->chgIData(oldp+79,(vlSelf->gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout),32);
    }
    bufp->chgIData(oldp+80,(vlSelf->alu__02Esrc1),32);
    bufp->chgIData(oldp+81,(vlSelf->alu__02Esrc2),32);
    bufp->chgIData(oldp+82,(vlSelf->alu__02Eimm),32);
    bufp->chgIData(oldp+83,(vlSelf->ram_data),32);
    bufp->chgCData(oldp+84,(vlSelf->op_ins),8);
    bufp->chgIData(oldp+85,(vlSelf->alu__02Eout),32);
    bufp->chgBit(oldp+86,(vlSelf->alu__02Eram_signal));
    bufp->chgBit(oldp+87,(vlSelf->jump_signal));
    bufp->chgIData(oldp+88,(vlSelf->pc_next),32);
    bufp->chgIData(oldp+89,(vlSelf->ins),32);
    bufp->chgCData(oldp+90,(vlSelf->decoder__02Erd),5);
    bufp->chgCData(oldp+91,(vlSelf->decoder__02Ers1),5);
    bufp->chgCData(oldp+92,(vlSelf->decoder__02Ers2),5);
    bufp->chgIData(oldp+93,(vlSelf->decoder__02Eimm),32);
    bufp->chgCData(oldp+94,(vlSelf->instruction),8);
    bufp->chgBit(oldp+95,(vlSelf->gpr__02Eclk));
    bufp->chgBit(oldp+96,(vlSelf->gpr__02Erst));
    bufp->chgCData(oldp+97,(vlSelf->gpr__02Ers1),5);
    bufp->chgCData(oldp+98,(vlSelf->gpr__02Ers2),5);
    bufp->chgCData(oldp+99,(vlSelf->gpr__02Erd),5);
    bufp->chgIData(oldp+100,(vlSelf->gpr__02Edata_in),32);
    bufp->chgIData(oldp+101,(vlSelf->gpr__02Esrc1),32);
    bufp->chgIData(oldp+102,(vlSelf->gpr__02Esrc2),32);
    bufp->chgBit(oldp+103,(vlSelf->pc__02Eclk));
    bufp->chgBit(oldp+104,(vlSelf->pc__02Erst));
    bufp->chgIData(oldp+105,(vlSelf->din),32);
    bufp->chgIData(oldp+106,(vlSelf->dout),32);
    bufp->chgBit(oldp+107,(vlSelf->jump));
    bufp->chgIData(oldp+108,(vlSelf->rom__02Eaddr),32);
    bufp->chgIData(oldp+109,(vlSelf->data),32);
    bufp->chgBit(oldp+110,(vlSelf->MuxKey__02Eout));
    bufp->chgBit(oldp+111,(vlSelf->MuxKey__02Ekey));
    bufp->chgCData(oldp+112,(vlSelf->MuxKey__02Elut),4);
    bufp->chgBit(oldp+113,(vlSelf->MuxKeyWithDefault__02Eout));
    bufp->chgBit(oldp+114,(vlSelf->MuxKeyWithDefault__02Ekey));
    bufp->chgBit(oldp+115,(vlSelf->default_out));
    bufp->chgCData(oldp+116,(vlSelf->MuxKeyWithDefault__02Elut),4);
    bufp->chgBit(oldp+117,(vlSelf->ram__02Eclk));
    bufp->chgBit(oldp+118,(vlSelf->ram__02Erst));
    bufp->chgIData(oldp+119,(vlSelf->ram__02Edata_in),32);
    bufp->chgIData(oldp+120,(vlSelf->ram__02Eaddr),32);
    bufp->chgCData(oldp+121,(vlSelf->byte_en),4);
    bufp->chgIData(oldp+122,(vlSelf->data_out),32);
    bufp->chgBit(oldp+123,(vlSelf->ram__02Eram_signal));
    bufp->chgCData(oldp+124,((7U & (vlSelf->ins >> 0xcU))),3);
    bufp->chgCData(oldp+125,((0x7fU & vlSelf->ins)),7);
    bufp->chgIData(oldp+126,(((0U != (IData)(vlSelf->gpr__02Erd))
                               ? ((IData)(1U) << (IData)(vlSelf->gpr__02Erd))
                               : 0U)),32);
    bufp->chgBit(oldp+127,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & ((IData)(1U) << (IData)(vlSelf->gpr__02Erd)))));
    bufp->chgBit(oldp+128,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0xaU))));
    bufp->chgBit(oldp+129,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0xbU))));
    bufp->chgBit(oldp+130,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0xcU))));
    bufp->chgBit(oldp+131,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0xdU))));
    bufp->chgBit(oldp+132,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0xeU))));
    bufp->chgBit(oldp+133,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0xfU))));
    bufp->chgBit(oldp+134,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x10U))));
    bufp->chgBit(oldp+135,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x11U))));
    bufp->chgBit(oldp+136,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x12U))));
    bufp->chgBit(oldp+137,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x13U))));
    bufp->chgBit(oldp+138,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 1U))));
    bufp->chgBit(oldp+139,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x14U))));
    bufp->chgBit(oldp+140,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x15U))));
    bufp->chgBit(oldp+141,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x16U))));
    bufp->chgBit(oldp+142,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x17U))));
    bufp->chgBit(oldp+143,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x18U))));
    bufp->chgBit(oldp+144,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x19U))));
    bufp->chgBit(oldp+145,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x1aU))));
    bufp->chgBit(oldp+146,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x1bU))));
    bufp->chgBit(oldp+147,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x1cU))));
    bufp->chgBit(oldp+148,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x1dU))));
    bufp->chgBit(oldp+149,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 2U))));
    bufp->chgBit(oldp+150,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x1eU))));
    bufp->chgBit(oldp+151,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 0x1fU))));
    bufp->chgBit(oldp+152,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 3U))));
    bufp->chgBit(oldp+153,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 4U))));
    bufp->chgBit(oldp+154,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 5U))));
    bufp->chgBit(oldp+155,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 6U))));
    bufp->chgBit(oldp+156,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 7U))));
    bufp->chgBit(oldp+157,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 8U))));
    bufp->chgBit(oldp+158,(((0U != (IData)(vlSelf->gpr__02Erd)) 
                            & (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
                               >> 9U))));
    bufp->chgIData(oldp+159,(((vlSelf->rom__02Eaddr 
                               - (IData)(0x80000000U)) 
                              >> 2U)),32);
    bufp->chgSData(oldp+160,((0x3ffU & ((vlSelf->rom__02Eaddr 
                                         - (IData)(0x80000000U)) 
                                        >> 2U))),10);
    bufp->chgIData(oldp+161,((0x3fffffU & ((vlSelf->rom__02Eaddr 
                                            - (IData)(0x80000000U)) 
                                           >> 0xcU))),22);
}

void Valu___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root__trace_cleanup\n"); );
    // Init
    Valu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu___024root*>(voidSelf);
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
}
