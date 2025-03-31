// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VReg.h for the primary calling header

#include "verilated.h"

#include "VReg___024root.h"

VL_INLINE_OPT void VReg___024root___ico_sequent__TOP__0(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___ico_sequent__TOP__0\n"); );
    // Body
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

void VReg___024root___eval_ico(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_ico\n"); );
    // Body
    if (vlSelf->__VicoTriggered.at(0U)) {
        VReg___024root___ico_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
}

void VReg___024root___eval_act(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_act\n"); );
}

VL_INLINE_OPT void VReg___024root___nba_sequent__TOP__0(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___nba_sequent__TOP__0\n"); );
    // Body
    if (vlSelf->reset) {
        vlSelf->top__DOT__addr = 0x80000000U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout = 0U;
        vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout = 0U;
    } else {
        vlSelf->top__DOT__addr = ((IData)(vlSelf->top__DOT__jump_singnal)
                                   ? vlSelf->top__DOT__pc_next
                                   : ((IData)(4U) + vlSelf->top__DOT__addr));
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x1fU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x1eU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x1dU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x1cU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x1bU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x1aU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x19U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x18U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x17U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x16U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x15U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x14U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x13U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x12U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x11U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0x10U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0xfU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0xeU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0xdU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0xcU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0xbU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 0xaU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 9U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 8U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 7U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 6U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 5U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 4U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 3U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 2U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__data 
                                                  >> 7U))) 
                                          >> 1U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__data 
                              >> 7U))) & ((IData)(1U) 
                                          << (0x1fU 
                                              & (vlSelf->top__DOT__data 
                                                 >> 7U))))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
    }
    vlSelf->top__DOT__data = ((0x3ffU >= (0x7ffffffU 
                                          & (vlSelf->top__DOT__addr 
                                             - (IData)(0x4c4b400U))))
                               ? vlSelf->top__DOT__rom__DOT__rom
                              [(0x7ffffffU & (vlSelf->top__DOT__addr 
                                              - (IData)(0x4c4b400U)))]
                               : 0U);
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1fU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1eU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1dU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1cU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1bU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1aU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x19U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x18U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x17U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x16U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x15U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x14U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x13U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x12U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x11U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x10U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xfU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xeU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xdU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xcU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xbU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xaU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[9U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[8U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[7U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[6U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[5U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[4U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[3U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[2U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[1U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout;
    vlSelf->top__DOT__result = ((0U == ((0x13U == (0x7fU 
                                                   & vlSelf->top__DOT__data))
                                         ? ((0U == 
                                             (7U & 
                                              (vlSelf->top__DOT__data 
                                               >> 0xcU)))
                                             ? 1U : 
                                            ((2U == 
                                              (7U & 
                                               (vlSelf->top__DOT__data 
                                                >> 0xcU)))
                                              ? 2U : 
                                             ((3U == 
                                               (7U 
                                                & (vlSelf->top__DOT__data 
                                                   >> 0xcU)))
                                               ? 3U
                                               : ((4U 
                                                   == 
                                                   (7U 
                                                    & (vlSelf->top__DOT__data 
                                                       >> 0xcU)))
                                                   ? 4U
                                                   : 
                                                  ((6U 
                                                    == 
                                                    (7U 
                                                     & (vlSelf->top__DOT__data 
                                                        >> 0xcU)))
                                                    ? 5U
                                                    : 
                                                   ((7U 
                                                     == 
                                                     (7U 
                                                      & (vlSelf->top__DOT__data 
                                                         >> 0xcU)))
                                                     ? 6U
                                                     : 0U))))))
                                         : 0U)) ? (
                                                   vlSelf->top__DOT__gpr__DOT__reg_file
                                                   [
                                                   (0x1fU 
                                                    & (vlSelf->top__DOT__data 
                                                       >> 0xfU))] 
                                                   + 
                                                   ((0x13U 
                                                     == 
                                                     (0x7fU 
                                                      & vlSelf->top__DOT__data))
                                                     ? 
                                                    (((- (IData)(
                                                                 (vlSelf->top__DOT__data 
                                                                  >> 0x1fU))) 
                                                      << 0xcU) 
                                                     | (vlSelf->top__DOT__data 
                                                        >> 0x14U))
                                                     : 0U))
                                 : 0U);
}

void VReg___024root___eval_nba(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_nba\n"); );
    // Body
    if (vlSelf->__VnbaTriggered.at(0U)) {
        VReg___024root___nba_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
    }
}

void VReg___024root___eval_triggers__ico(VReg___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void VReg___024root___dump_triggers__ico(VReg___024root* vlSelf);
#endif  // VL_DEBUG
void VReg___024root___eval_triggers__act(VReg___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void VReg___024root___dump_triggers__act(VReg___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void VReg___024root___dump_triggers__nba(VReg___024root* vlSelf);
#endif  // VL_DEBUG

void VReg___024root___eval(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval\n"); );
    // Init
    CData/*0:0*/ __VicoContinue;
    VlTriggerVec<1> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    vlSelf->__VicoIterCount = 0U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        __VicoContinue = 0U;
        VReg___024root___eval_triggers__ico(vlSelf);
        if (vlSelf->__VicoTriggered.any()) {
            __VicoContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VicoIterCount))) {
#ifdef VL_DEBUG
                VReg___024root___dump_triggers__ico(vlSelf);
#endif
                VL_FATAL_MT("vsrc/define.v", 40, "", "Input combinational region did not converge.");
            }
            vlSelf->__VicoIterCount = ((IData)(1U) 
                                       + vlSelf->__VicoIterCount);
            VReg___024root___eval_ico(vlSelf);
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
            VReg___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    VReg___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("vsrc/define.v", 40, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.set(vlSelf->__VactTriggered);
                VReg___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                VReg___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("vsrc/define.v", 40, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            VReg___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void VReg___024root___eval_debug_assertions(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_debug_assertions\n"); );
    // Body
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
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((vlSelf->__pinNumber3 & 0xfeU))) {
        Verilated::overWidthError("__pinNumber3");}
}
#endif  // VL_DEBUG
