// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Valu.h for the primary calling header

#include "verilated.h"

#include "Valu___024root.h"

VL_INLINE_OPT void Valu___024root___ico_sequent__TOP__0(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___ico_sequent__TOP__0\n"); );
    // Body
    vlSelf->decoder__02Erd = (0x1fU & (vlSelf->ins 
                                       >> 7U));
    vlSelf->decoder__02Ers1 = (0x1fU & (vlSelf->ins 
                                        >> 0xfU));
    vlSelf->decoder__02Ers2 = (0x1fU & (vlSelf->ins 
                                        >> 0x14U));
    if ((0x13U == (0x7fU & vlSelf->ins))) {
        vlSelf->decoder__02Eimm = (((- (IData)((vlSelf->ins 
                                                >> 0x1fU))) 
                                    << 0xcU) | (vlSelf->ins 
                                                >> 0x14U));
        vlSelf->instruction = ((0U == (7U & (vlSelf->ins 
                                             >> 0xcU)))
                                ? 1U : ((2U == (7U 
                                                & (vlSelf->ins 
                                                   >> 0xcU)))
                                         ? 2U : ((3U 
                                                  == 
                                                  (7U 
                                                   & (vlSelf->ins 
                                                      >> 0xcU)))
                                                  ? 3U
                                                  : 
                                                 ((4U 
                                                   == 
                                                   (7U 
                                                    & (vlSelf->ins 
                                                       >> 0xcU)))
                                                   ? 4U
                                                   : 
                                                  ((6U 
                                                    == 
                                                    (7U 
                                                     & (vlSelf->ins 
                                                        >> 0xcU)))
                                                    ? 5U
                                                    : 
                                                   ((7U 
                                                     == 
                                                     (7U 
                                                      & (vlSelf->ins 
                                                         >> 0xcU)))
                                                     ? 6U
                                                     : 0U))))));
    } else {
        vlSelf->decoder__02Eimm = 0U;
        vlSelf->instruction = 0U;
    }
    vlSelf->data = vlSelf->rom__DOT__rom_mem[(0x3ffU 
                                              & ((vlSelf->rom__02Eaddr 
                                                  - (IData)(0x80000000U)) 
                                                 >> 2U))];
    vlSelf->data_out = ((0x825U >= (0xfffU & ((IData)(0x801U) 
                                              + vlSelf->ram__02Eaddr)))
                         ? vlSelf->ram__DOT__ram_mem
                        [(0xfffU & ((IData)(0x801U) 
                                    + vlSelf->ram__02Eaddr))]
                         : 0U);
    vlSelf->gpr__02Esrc1 = vlSelf->gpr__DOT__reg_file
        [vlSelf->gpr__02Ers1];
    vlSelf->gpr__02Esrc2 = vlSelf->gpr__DOT__reg_file
        [vlSelf->gpr__02Ers2];
    vlSelf->MuxKey__DOT__i0__DOT__pair_list[0U] = (3U 
                                                   & (IData)(vlSelf->MuxKey__02Elut));
    vlSelf->MuxKey__DOT__i0__DOT__pair_list[1U] = (3U 
                                                   & ((IData)(vlSelf->MuxKey__02Elut) 
                                                      >> 2U));
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__pair_list[0U] 
        = (3U & (IData)(vlSelf->MuxKeyWithDefault__02Elut));
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__pair_list[1U] 
        = (3U & ((IData)(vlSelf->MuxKeyWithDefault__02Elut) 
                 >> 2U));
    vlSelf->alu__02Eout = ((1U == (IData)(vlSelf->op_ins))
                            ? (vlSelf->alu__02Esrc1 
                               + vlSelf->alu__02Eimm)
                            : ((2U == (IData)(vlSelf->op_ins))
                                ? (vlSelf->alu__02Esrc1 
                                   + vlSelf->alu__02Esrc2)
                                : ((3U == (IData)(vlSelf->op_ins))
                                    ? vlSelf->ram_data
                                    : 0U)));
    vlSelf->MuxKey__DOT__i0__DOT__data_list[0U] = (1U 
                                                   & (IData)(vlSelf->MuxKey__02Elut));
    vlSelf->MuxKey__DOT__i0__DOT__data_list[1U] = (1U 
                                                   & ((IData)(vlSelf->MuxKey__02Elut) 
                                                      >> 2U));
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list[0U] 
        = (1U & ((IData)(vlSelf->MuxKeyWithDefault__02Elut) 
                 >> 1U));
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list[1U] 
        = (1U & ((IData)(vlSelf->MuxKeyWithDefault__02Elut) 
                 >> 3U));
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__data_list[0U] 
        = (1U & (IData)(vlSelf->MuxKeyWithDefault__02Elut));
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__data_list[1U] 
        = (1U & ((IData)(vlSelf->MuxKeyWithDefault__02Elut) 
                 >> 2U));
    vlSelf->MuxKey__DOT__i0__DOT__key_list[0U] = (1U 
                                                  & ((IData)(vlSelf->MuxKey__02Elut) 
                                                     >> 1U));
    vlSelf->MuxKey__DOT__i0__DOT__key_list[1U] = (1U 
                                                  & ((IData)(vlSelf->MuxKey__02Elut) 
                                                     >> 3U));
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__lut_out 
        = (((IData)(vlSelf->MuxKeyWithDefault__02Ekey) 
            == vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list
            [0U]) & vlSelf->MuxKeyWithDefault__DOT__i0__DOT__data_list
           [0U]);
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__hit = 
        ((IData)(vlSelf->MuxKeyWithDefault__02Ekey) 
         == vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list
         [0U]);
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__lut_out 
        = ((IData)(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__lut_out) 
           | (((IData)(vlSelf->MuxKeyWithDefault__02Ekey) 
               == vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list
               [1U]) & vlSelf->MuxKeyWithDefault__DOT__i0__DOT__data_list
              [1U]));
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__hit = 
        ((IData)(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__hit) 
         | ((IData)(vlSelf->MuxKeyWithDefault__02Ekey) 
            == vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list
            [1U]));
    vlSelf->MuxKeyWithDefault__02Eout = ((IData)(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__hit)
                                          ? (IData)(vlSelf->MuxKeyWithDefault__DOT__i0__DOT__lut_out)
                                          : (IData)(vlSelf->default_out));
    vlSelf->MuxKey__DOT__i0__DOT__hit = ((IData)(vlSelf->MuxKey__02Ekey) 
                                         == vlSelf->MuxKey__DOT__i0__DOT__key_list
                                         [0U]);
    vlSelf->MuxKey__DOT__i0__DOT__hit = ((IData)(vlSelf->MuxKey__DOT__i0__DOT__hit) 
                                         | ((IData)(vlSelf->MuxKey__02Ekey) 
                                            == vlSelf->MuxKey__DOT__i0__DOT__key_list
                                            [1U]));
    vlSelf->MuxKey__DOT__i0__DOT__lut_out = (((IData)(vlSelf->MuxKey__02Ekey) 
                                              == vlSelf->MuxKey__DOT__i0__DOT__key_list
                                              [0U]) 
                                             & vlSelf->MuxKey__DOT__i0__DOT__data_list
                                             [0U]);
    vlSelf->MuxKey__DOT__i0__DOT__lut_out = ((IData)(vlSelf->MuxKey__DOT__i0__DOT__lut_out) 
                                             | (((IData)(vlSelf->MuxKey__02Ekey) 
                                                 == 
                                                 vlSelf->MuxKey__DOT__i0__DOT__key_list
                                                 [1U]) 
                                                & vlSelf->MuxKey__DOT__i0__DOT__data_list
                                                [1U]));
    vlSelf->MuxKey__02Eout = vlSelf->MuxKey__DOT__i0__DOT__lut_out;
}

void Valu___024root___eval_ico(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_ico\n"); );
    // Body
    if (vlSelf->__VicoTriggered.at(0U)) {
        Valu___024root___ico_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
}

void Valu___024root___eval_act(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_act\n"); );
}

VL_INLINE_OPT void Valu___024root___nba_sequent__TOP__0(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___nba_sequent__TOP__0\n"); );
    // Body
    vlSelf->dout = ((IData)(vlSelf->pc__02Erst) ? 0x80000000U
                     : ((IData)(vlSelf->jump) ? vlSelf->din
                         : ((IData)(4U) + vlSelf->dout)));
}

VL_INLINE_OPT void Valu___024root___nba_sequent__TOP__1(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___nba_sequent__TOP__1\n"); );
    // Init
    SData/*11:0*/ __Vdlyvdim0__ram__DOT__ram_mem__v0;
    __Vdlyvdim0__ram__DOT__ram_mem__v0 = 0;
    IData/*31:0*/ __Vdlyvval__ram__DOT__ram_mem__v0;
    __Vdlyvval__ram__DOT__ram_mem__v0 = 0;
    CData/*0:0*/ __Vdlyvset__ram__DOT__ram_mem__v0;
    __Vdlyvset__ram__DOT__ram_mem__v0 = 0;
    SData/*11:0*/ __Vdlyvdim0__ram__DOT__ram_mem__v1;
    __Vdlyvdim0__ram__DOT__ram_mem__v1 = 0;
    IData/*31:0*/ __Vdlyvval__ram__DOT__ram_mem__v1;
    __Vdlyvval__ram__DOT__ram_mem__v1 = 0;
    CData/*0:0*/ __Vdlyvset__ram__DOT__ram_mem__v1;
    __Vdlyvset__ram__DOT__ram_mem__v1 = 0;
    SData/*11:0*/ __Vdlyvdim0__ram__DOT__ram_mem__v2;
    __Vdlyvdim0__ram__DOT__ram_mem__v2 = 0;
    IData/*31:0*/ __Vdlyvval__ram__DOT__ram_mem__v2;
    __Vdlyvval__ram__DOT__ram_mem__v2 = 0;
    CData/*0:0*/ __Vdlyvset__ram__DOT__ram_mem__v2;
    __Vdlyvset__ram__DOT__ram_mem__v2 = 0;
    SData/*11:0*/ __Vdlyvdim0__ram__DOT__ram_mem__v3;
    __Vdlyvdim0__ram__DOT__ram_mem__v3 = 0;
    IData/*31:0*/ __Vdlyvval__ram__DOT__ram_mem__v3;
    __Vdlyvval__ram__DOT__ram_mem__v3 = 0;
    CData/*0:0*/ __Vdlyvset__ram__DOT__ram_mem__v3;
    __Vdlyvset__ram__DOT__ram_mem__v3 = 0;
    SData/*11:0*/ __Vdlyvdim0__ram__DOT__ram_mem__v4;
    __Vdlyvdim0__ram__DOT__ram_mem__v4 = 0;
    IData/*31:0*/ __Vdlyvval__ram__DOT__ram_mem__v4;
    __Vdlyvval__ram__DOT__ram_mem__v4 = 0;
    CData/*0:0*/ __Vdlyvset__ram__DOT__ram_mem__v4;
    __Vdlyvset__ram__DOT__ram_mem__v4 = 0;
    SData/*11:0*/ __Vdlyvdim0__ram__DOT__ram_mem__v5;
    __Vdlyvdim0__ram__DOT__ram_mem__v5 = 0;
    IData/*31:0*/ __Vdlyvval__ram__DOT__ram_mem__v5;
    __Vdlyvval__ram__DOT__ram_mem__v5 = 0;
    CData/*0:0*/ __Vdlyvset__ram__DOT__ram_mem__v5;
    __Vdlyvset__ram__DOT__ram_mem__v5 = 0;
    // Body
    __Vdlyvset__ram__DOT__ram_mem__v0 = 0U;
    __Vdlyvset__ram__DOT__ram_mem__v1 = 0U;
    __Vdlyvset__ram__DOT__ram_mem__v2 = 0U;
    __Vdlyvset__ram__DOT__ram_mem__v3 = 0U;
    __Vdlyvset__ram__DOT__ram_mem__v4 = 0U;
    __Vdlyvset__ram__DOT__ram_mem__v5 = 0U;
    if (vlSelf->ram__02Erst) {
        vlSelf->ram__DOT____Vlvbound_h09251640__0 = 0U;
        if ((0x825U >= (0xfffU & ((IData)(0x801U) + vlSelf->ram__02Eaddr)))) {
            __Vdlyvval__ram__DOT__ram_mem__v0 = vlSelf->ram__DOT____Vlvbound_h09251640__0;
            __Vdlyvset__ram__DOT__ram_mem__v0 = 1U;
            __Vdlyvdim0__ram__DOT__ram_mem__v0 = (0xfffU 
                                                  & ((IData)(0x801U) 
                                                     + vlSelf->ram__02Eaddr));
        }
    } else if (vlSelf->ram__02Eram_signal) {
        if ((1U == (IData)(vlSelf->byte_en))) {
            vlSelf->ram__DOT____Vlvbound_h09251640__1 
                = (((0x825U >= (0xfffU & ((IData)(0x801U) 
                                          + vlSelf->ram__02Eaddr)))
                     ? (0xffffff00U & vlSelf->ram__DOT__ram_mem
                        [(0xfffU & ((IData)(0x801U) 
                                    + vlSelf->ram__02Eaddr))])
                     : 0U) | (0xffU & vlSelf->ram__02Edata_in));
            if ((0x825U >= (0xfffU & ((IData)(0x801U) 
                                      + vlSelf->ram__02Eaddr)))) {
                __Vdlyvval__ram__DOT__ram_mem__v1 = vlSelf->ram__DOT____Vlvbound_h09251640__1;
                __Vdlyvset__ram__DOT__ram_mem__v1 = 1U;
                __Vdlyvdim0__ram__DOT__ram_mem__v1 
                    = (0xfffU & ((IData)(0x801U) + vlSelf->ram__02Eaddr));
            }
        } else if ((2U == (IData)(vlSelf->byte_en))) {
            vlSelf->ram__DOT____Vlvbound_h09251640__2 
                = (((0x825U >= (0xfffU & ((IData)(0x801U) 
                                          + vlSelf->ram__02Eaddr)))
                     ? (0xffff0000U & vlSelf->ram__DOT__ram_mem
                        [(0xfffU & ((IData)(0x801U) 
                                    + vlSelf->ram__02Eaddr))])
                     : 0U) | (0xffffU & vlSelf->ram__02Edata_in));
            if ((0x825U >= (0xfffU & ((IData)(0x801U) 
                                      + vlSelf->ram__02Eaddr)))) {
                __Vdlyvval__ram__DOT__ram_mem__v2 = vlSelf->ram__DOT____Vlvbound_h09251640__2;
                __Vdlyvset__ram__DOT__ram_mem__v2 = 1U;
                __Vdlyvdim0__ram__DOT__ram_mem__v2 
                    = (0xfffU & ((IData)(0x801U) + vlSelf->ram__02Eaddr));
            }
        } else if ((4U == (IData)(vlSelf->byte_en))) {
            vlSelf->ram__DOT____Vlvbound_h09251640__3 
                = (((0x825U >= (0xfffU & ((IData)(0x801U) 
                                          + vlSelf->ram__02Eaddr)))
                     ? (0xff000000U & vlSelf->ram__DOT__ram_mem
                        [(0xfffU & ((IData)(0x801U) 
                                    + vlSelf->ram__02Eaddr))])
                     : 0U) | (0xffffffU & vlSelf->ram__02Edata_in));
            if ((0x825U >= (0xfffU & ((IData)(0x801U) 
                                      + vlSelf->ram__02Eaddr)))) {
                __Vdlyvval__ram__DOT__ram_mem__v3 = vlSelf->ram__DOT____Vlvbound_h09251640__3;
                __Vdlyvset__ram__DOT__ram_mem__v3 = 1U;
                __Vdlyvdim0__ram__DOT__ram_mem__v3 
                    = (0xfffU & ((IData)(0x801U) + vlSelf->ram__02Eaddr));
            }
        } else if ((0xfU == (IData)(vlSelf->byte_en))) {
            vlSelf->ram__DOT____Vlvbound_h09251640__4 
                = vlSelf->ram__02Edata_in;
            if ((0x825U >= (0xfffU & ((IData)(0x801U) 
                                      + vlSelf->ram__02Eaddr)))) {
                __Vdlyvval__ram__DOT__ram_mem__v4 = vlSelf->ram__DOT____Vlvbound_h09251640__4;
                __Vdlyvset__ram__DOT__ram_mem__v4 = 1U;
                __Vdlyvdim0__ram__DOT__ram_mem__v4 
                    = (0xfffU & ((IData)(0x801U) + vlSelf->ram__02Eaddr));
            }
        } else if ((0x825U >= (0xfffU & ((IData)(0x801U) 
                                         + vlSelf->ram__02Eaddr)))) {
            vlSelf->ram__DOT____Vlvbound_h09251640__5 
                = vlSelf->ram__DOT__ram_mem[(0xfffU 
                                             & ((IData)(0x801U) 
                                                + vlSelf->ram__02Eaddr))];
            __Vdlyvval__ram__DOT__ram_mem__v5 = vlSelf->ram__DOT____Vlvbound_h09251640__5;
            __Vdlyvset__ram__DOT__ram_mem__v5 = 1U;
            __Vdlyvdim0__ram__DOT__ram_mem__v5 = (0xfffU 
                                                  & ((IData)(0x801U) 
                                                     + vlSelf->ram__02Eaddr));
        } else {
            vlSelf->ram__DOT____Vlvbound_h09251640__5 = 0U;
        }
    }
    if (__Vdlyvset__ram__DOT__ram_mem__v0) {
        vlSelf->ram__DOT__ram_mem[__Vdlyvdim0__ram__DOT__ram_mem__v0] 
            = __Vdlyvval__ram__DOT__ram_mem__v0;
    }
    if (__Vdlyvset__ram__DOT__ram_mem__v1) {
        vlSelf->ram__DOT__ram_mem[__Vdlyvdim0__ram__DOT__ram_mem__v1] 
            = __Vdlyvval__ram__DOT__ram_mem__v1;
    }
    if (__Vdlyvset__ram__DOT__ram_mem__v2) {
        vlSelf->ram__DOT__ram_mem[__Vdlyvdim0__ram__DOT__ram_mem__v2] 
            = __Vdlyvval__ram__DOT__ram_mem__v2;
    }
    if (__Vdlyvset__ram__DOT__ram_mem__v3) {
        vlSelf->ram__DOT__ram_mem[__Vdlyvdim0__ram__DOT__ram_mem__v3] 
            = __Vdlyvval__ram__DOT__ram_mem__v3;
    }
    if (__Vdlyvset__ram__DOT__ram_mem__v4) {
        vlSelf->ram__DOT__ram_mem[__Vdlyvdim0__ram__DOT__ram_mem__v4] 
            = __Vdlyvval__ram__DOT__ram_mem__v4;
    }
    if (__Vdlyvset__ram__DOT__ram_mem__v5) {
        vlSelf->ram__DOT__ram_mem[__Vdlyvdim0__ram__DOT__ram_mem__v5] 
            = __Vdlyvval__ram__DOT__ram_mem__v5;
    }
    vlSelf->data_out = ((0x825U >= (0xfffU & ((IData)(0x801U) 
                                              + vlSelf->ram__02Eaddr)))
                         ? vlSelf->ram__DOT__ram_mem
                        [(0xfffU & ((IData)(0x801U) 
                                    + vlSelf->ram__02Eaddr))]
                         : 0U);
}

VL_INLINE_OPT void Valu___024root___nba_sequent__TOP__2(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___nba_sequent__TOP__2\n"); );
    // Body
    if (vlSelf->gpr__02Erst) {
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout = 0U;
        vlSelf->gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout = 0U;
    } else {
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x1fU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x1eU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x1dU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x1cU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x1bU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x1aU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x19U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x18U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x17U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x16U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x15U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x14U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x13U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x12U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x11U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0x10U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0xfU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0xeU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0xdU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0xcU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0xbU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 0xaU))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 9U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 8U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 7U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 6U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 5U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 4U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 3U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 2U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             (((IData)(1U) << (IData)(vlSelf->gpr__02Erd)) 
              >> 1U))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
        if (((0U != (IData)(vlSelf->gpr__02Erd)) & 
             ((IData)(1U) << (IData)(vlSelf->gpr__02Erd)))) {
            vlSelf->gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout 
                = vlSelf->gpr__02Edata_in;
        }
    }
    vlSelf->gpr__DOT__reg_file[0x1fU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1eU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1dU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1cU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1bU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1aU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x19U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x18U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x17U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x16U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x15U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x14U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x13U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x12U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x11U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x10U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xfU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xeU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xdU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xcU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xbU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xaU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[9U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[8U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[7U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[6U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[5U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[4U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[3U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[2U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[1U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout;
    vlSelf->gpr__02Esrc1 = vlSelf->gpr__DOT__reg_file
        [vlSelf->gpr__02Ers1];
    vlSelf->gpr__02Esrc2 = vlSelf->gpr__DOT__reg_file
        [vlSelf->gpr__02Ers2];
}

void Valu___024root___eval_nba(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_nba\n"); );
    // Body
    if (vlSelf->__VnbaTriggered.at(0U)) {
        Valu___024root___nba_sequent__TOP__0(vlSelf);
    }
    if (vlSelf->__VnbaTriggered.at(1U)) {
        Valu___024root___nba_sequent__TOP__1(vlSelf);
    }
    if (vlSelf->__VnbaTriggered.at(2U)) {
        Valu___024root___nba_sequent__TOP__2(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
    }
}

void Valu___024root___eval_triggers__ico(Valu___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Valu___024root___dump_triggers__ico(Valu___024root* vlSelf);
#endif  // VL_DEBUG
void Valu___024root___eval_triggers__act(Valu___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Valu___024root___dump_triggers__act(Valu___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Valu___024root___dump_triggers__nba(Valu___024root* vlSelf);
#endif  // VL_DEBUG

void Valu___024root___eval(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval\n"); );
    // Init
    CData/*0:0*/ __VicoContinue;
    VlTriggerVec<3> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    vlSelf->__VicoIterCount = 0U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        __VicoContinue = 0U;
        Valu___024root___eval_triggers__ico(vlSelf);
        if (vlSelf->__VicoTriggered.any()) {
            __VicoContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VicoIterCount))) {
#ifdef VL_DEBUG
                Valu___024root___dump_triggers__ico(vlSelf);
#endif
                VL_FATAL_MT("/home/long/ysyx-workbench/npc/vsrc/EXU/alu.v", 1, "", "Input combinational region did not converge.");
            }
            vlSelf->__VicoIterCount = ((IData)(1U) 
                                       + vlSelf->__VicoIterCount);
            Valu___024root___eval_ico(vlSelf);
        }
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            Valu___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Valu___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("/home/long/ysyx-workbench/npc/vsrc/EXU/alu.v", 1, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.set(vlSelf->__VactTriggered);
                Valu___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Valu___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("/home/long/ysyx-workbench/npc/vsrc/EXU/alu.v", 1, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Valu___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void Valu___024root___eval_debug_assertions(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->pc__02Eclk & 0xfeU))) {
        Verilated::overWidthError("pc.clk");}
    if (VL_UNLIKELY((vlSelf->pc__02Erst & 0xfeU))) {
        Verilated::overWidthError("pc.rst");}
    if (VL_UNLIKELY((vlSelf->jump & 0xfeU))) {
        Verilated::overWidthError("jump");}
    if (VL_UNLIKELY((vlSelf->ram__02Eclk & 0xfeU))) {
        Verilated::overWidthError("ram.clk");}
    if (VL_UNLIKELY((vlSelf->ram__02Erst & 0xfeU))) {
        Verilated::overWidthError("ram.rst");}
    if (VL_UNLIKELY((vlSelf->byte_en & 0xf0U))) {
        Verilated::overWidthError("byte_en");}
    if (VL_UNLIKELY((vlSelf->ram__02Eram_signal & 0xfeU))) {
        Verilated::overWidthError("ram.ram_signal");}
    if (VL_UNLIKELY((vlSelf->gpr__02Eclk & 0xfeU))) {
        Verilated::overWidthError("gpr.clk");}
    if (VL_UNLIKELY((vlSelf->gpr__02Erst & 0xfeU))) {
        Verilated::overWidthError("gpr.rst");}
    if (VL_UNLIKELY((vlSelf->gpr__02Ers1 & 0xe0U))) {
        Verilated::overWidthError("gpr.rs1");}
    if (VL_UNLIKELY((vlSelf->gpr__02Ers2 & 0xe0U))) {
        Verilated::overWidthError("gpr.rs2");}
    if (VL_UNLIKELY((vlSelf->gpr__02Erd & 0xe0U))) {
        Verilated::overWidthError("gpr.rd");}
    if (VL_UNLIKELY((vlSelf->MuxKey__02Ekey & 0xfeU))) {
        Verilated::overWidthError("MuxKey.key");}
    if (VL_UNLIKELY((vlSelf->MuxKey__02Elut & 0xf0U))) {
        Verilated::overWidthError("MuxKey.lut");}
    if (VL_UNLIKELY((vlSelf->MuxKeyWithDefault__02Ekey 
                     & 0xfeU))) {
        Verilated::overWidthError("MuxKeyWithDefault.key");}
    if (VL_UNLIKELY((vlSelf->default_out & 0xfeU))) {
        Verilated::overWidthError("default_out");}
    if (VL_UNLIKELY((vlSelf->MuxKeyWithDefault__02Elut 
                     & 0xf0U))) {
        Verilated::overWidthError("MuxKeyWithDefault.lut");}
}
#endif  // VL_DEBUG
