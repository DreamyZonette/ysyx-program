// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


void Vtop___024root__trace_chg_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vtop___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_chg_top_0\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vtop___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Vtop___024root__trace_chg_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgCData(oldp+0,(vlSelf->top__DOT__op_ins),8);
        bufp->chgIData(oldp+1,(vlSelf->top__DOT__addr),32);
        bufp->chgIData(oldp+2,(vlSelf->top__DOT__data),32);
        bufp->chgCData(oldp+3,((0x1fU & (vlSelf->top__DOT__data 
                                         >> 0xfU))),5);
        bufp->chgCData(oldp+4,((0x1fU & (vlSelf->top__DOT__data 
                                         >> 0x14U))),5);
        bufp->chgIData(oldp+5,(((0x13U == (0x7fU & vlSelf->top__DOT__data))
                                 ? (((- (IData)((vlSelf->top__DOT__data 
                                                 >> 0x1fU))) 
                                     << 0xcU) | (vlSelf->top__DOT__data 
                                                 >> 0x14U))
                                 : 0U)),32);
        bufp->chgIData(oldp+6,(vlSelf->top__DOT__src1),32);
        bufp->chgIData(oldp+7,(vlSelf->top__DOT__gpr__DOT__reg_file
                               [(0x1fU & (vlSelf->top__DOT__data 
                                          >> 0x14U))]),32);
        bufp->chgIData(oldp+8,(vlSelf->top__DOT__result),32);
        bufp->chgCData(oldp+9,((0x1fU & (vlSelf->top__DOT__data 
                                         >> 7U))),5);
        bufp->chgCData(oldp+10,((7U & (vlSelf->top__DOT__data 
                                       >> 0xcU))),3);
        bufp->chgCData(oldp+11,((0x7fU & vlSelf->top__DOT__data)),7);
        bufp->chgIData(oldp+12,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                  >> 7U)))
                                  ? ((IData)(1U) << 
                                     (0x1fU & (vlSelf->top__DOT__data 
                                               >> 7U)))
                                  : 0U)),32);
        bufp->chgIData(oldp+13,(vlSelf->top__DOT__gpr__DOT__reg_file[0]),32);
        bufp->chgIData(oldp+14,(vlSelf->top__DOT__gpr__DOT__reg_file[1]),32);
        bufp->chgIData(oldp+15,(vlSelf->top__DOT__gpr__DOT__reg_file[2]),32);
        bufp->chgIData(oldp+16,(vlSelf->top__DOT__gpr__DOT__reg_file[3]),32);
        bufp->chgIData(oldp+17,(vlSelf->top__DOT__gpr__DOT__reg_file[4]),32);
        bufp->chgIData(oldp+18,(vlSelf->top__DOT__gpr__DOT__reg_file[5]),32);
        bufp->chgIData(oldp+19,(vlSelf->top__DOT__gpr__DOT__reg_file[6]),32);
        bufp->chgIData(oldp+20,(vlSelf->top__DOT__gpr__DOT__reg_file[7]),32);
        bufp->chgIData(oldp+21,(vlSelf->top__DOT__gpr__DOT__reg_file[8]),32);
        bufp->chgIData(oldp+22,(vlSelf->top__DOT__gpr__DOT__reg_file[9]),32);
        bufp->chgIData(oldp+23,(vlSelf->top__DOT__gpr__DOT__reg_file[10]),32);
        bufp->chgIData(oldp+24,(vlSelf->top__DOT__gpr__DOT__reg_file[11]),32);
        bufp->chgIData(oldp+25,(vlSelf->top__DOT__gpr__DOT__reg_file[12]),32);
        bufp->chgIData(oldp+26,(vlSelf->top__DOT__gpr__DOT__reg_file[13]),32);
        bufp->chgIData(oldp+27,(vlSelf->top__DOT__gpr__DOT__reg_file[14]),32);
        bufp->chgIData(oldp+28,(vlSelf->top__DOT__gpr__DOT__reg_file[15]),32);
        bufp->chgIData(oldp+29,(vlSelf->top__DOT__gpr__DOT__reg_file[16]),32);
        bufp->chgIData(oldp+30,(vlSelf->top__DOT__gpr__DOT__reg_file[17]),32);
        bufp->chgIData(oldp+31,(vlSelf->top__DOT__gpr__DOT__reg_file[18]),32);
        bufp->chgIData(oldp+32,(vlSelf->top__DOT__gpr__DOT__reg_file[19]),32);
        bufp->chgIData(oldp+33,(vlSelf->top__DOT__gpr__DOT__reg_file[20]),32);
        bufp->chgIData(oldp+34,(vlSelf->top__DOT__gpr__DOT__reg_file[21]),32);
        bufp->chgIData(oldp+35,(vlSelf->top__DOT__gpr__DOT__reg_file[22]),32);
        bufp->chgIData(oldp+36,(vlSelf->top__DOT__gpr__DOT__reg_file[23]),32);
        bufp->chgIData(oldp+37,(vlSelf->top__DOT__gpr__DOT__reg_file[24]),32);
        bufp->chgIData(oldp+38,(vlSelf->top__DOT__gpr__DOT__reg_file[25]),32);
        bufp->chgIData(oldp+39,(vlSelf->top__DOT__gpr__DOT__reg_file[26]),32);
        bufp->chgIData(oldp+40,(vlSelf->top__DOT__gpr__DOT__reg_file[27]),32);
        bufp->chgIData(oldp+41,(vlSelf->top__DOT__gpr__DOT__reg_file[28]),32);
        bufp->chgIData(oldp+42,(vlSelf->top__DOT__gpr__DOT__reg_file[29]),32);
        bufp->chgIData(oldp+43,(vlSelf->top__DOT__gpr__DOT__reg_file[30]),32);
        bufp->chgIData(oldp+44,(vlSelf->top__DOT__gpr__DOT__reg_file[31]),32);
        bufp->chgIData(oldp+45,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+46,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & ((IData)(1U) << (0x1fU 
                                                  & (vlSelf->top__DOT__data 
                                                     >> 7U))))));
        bufp->chgIData(oldp+47,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+48,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0xaU))));
        bufp->chgIData(oldp+49,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+50,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0xbU))));
        bufp->chgIData(oldp+51,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+52,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0xcU))));
        bufp->chgIData(oldp+53,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+54,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0xdU))));
        bufp->chgIData(oldp+55,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+56,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0xeU))));
        bufp->chgIData(oldp+57,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+58,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0xfU))));
        bufp->chgIData(oldp+59,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+60,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x10U))));
        bufp->chgIData(oldp+61,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+62,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x11U))));
        bufp->chgIData(oldp+63,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+64,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x12U))));
        bufp->chgIData(oldp+65,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+66,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x13U))));
        bufp->chgIData(oldp+67,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+68,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 1U))));
        bufp->chgIData(oldp+69,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+70,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x14U))));
        bufp->chgIData(oldp+71,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+72,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x15U))));
        bufp->chgIData(oldp+73,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+74,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x16U))));
        bufp->chgIData(oldp+75,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+76,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x17U))));
        bufp->chgIData(oldp+77,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+78,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x18U))));
        bufp->chgIData(oldp+79,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+80,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x19U))));
        bufp->chgIData(oldp+81,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+82,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x1aU))));
        bufp->chgIData(oldp+83,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+84,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x1bU))));
        bufp->chgIData(oldp+85,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+86,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x1cU))));
        bufp->chgIData(oldp+87,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+88,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x1dU))));
        bufp->chgIData(oldp+89,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+90,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 2U))));
        bufp->chgIData(oldp+91,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+92,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x1eU))));
        bufp->chgIData(oldp+93,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+94,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 0x1fU))));
        bufp->chgIData(oldp+95,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+96,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 3U))));
        bufp->chgIData(oldp+97,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+98,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                >> 7U))) 
                               & (((IData)(1U) << (0x1fU 
                                                   & (vlSelf->top__DOT__data 
                                                      >> 7U))) 
                                  >> 4U))));
        bufp->chgIData(oldp+99,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+100,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                 >> 7U))) 
                                & (((IData)(1U) << 
                                    (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                                   >> 5U))));
        bufp->chgIData(oldp+101,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+102,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                 >> 7U))) 
                                & (((IData)(1U) << 
                                    (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                                   >> 6U))));
        bufp->chgIData(oldp+103,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+104,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                 >> 7U))) 
                                & (((IData)(1U) << 
                                    (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                                   >> 7U))));
        bufp->chgIData(oldp+105,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+106,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                 >> 7U))) 
                                & (((IData)(1U) << 
                                    (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                                   >> 8U))));
        bufp->chgIData(oldp+107,(vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout),32);
        bufp->chgBit(oldp+108,(((0U != (0x1fU & (vlSelf->top__DOT__data 
                                                 >> 7U))) 
                                & (((IData)(1U) << 
                                    (0x1fU & (vlSelf->top__DOT__data 
                                              >> 7U))) 
                                   >> 9U))));
    }
    bufp->chgBit(oldp+109,(vlSelf->clk));
    bufp->chgBit(oldp+110,(vlSelf->reset));
}

void Vtop___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_cleanup\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
