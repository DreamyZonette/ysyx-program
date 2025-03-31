// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VReg.h for the primary calling header

#include "verilated.h"

#include "VReg___024root.h"

VL_ATTR_COLD void VReg___024root___eval_static__TOP(VReg___024root* vlSelf);

VL_ATTR_COLD void VReg___024root___eval_static(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_static\n"); );
    // Body
    VReg___024root___eval_static__TOP(vlSelf);
}

VL_ATTR_COLD void VReg___024root___eval_static__TOP(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_static__TOP\n"); );
    // Init
    IData/*31:0*/ __Vilp;
    // Body
    __Vilp = 0U;
    while ((__Vilp <= 0x3ffU)) {
        vlSelf->top__DOT__rom__DOT__rom[__Vilp] = 0U;
        __Vilp = ((IData)(1U) + __Vilp);
    }
}

VL_ATTR_COLD void VReg___024root___eval_initial(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vtrigrprev__TOP__clk = vlSelf->clk;
}

VL_ATTR_COLD void VReg___024root___eval_final(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_final\n"); );
}

VL_ATTR_COLD void VReg___024root___eval_triggers__stl(VReg___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void VReg___024root___dump_triggers__stl(VReg___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD void VReg___024root___eval_stl(VReg___024root* vlSelf);

VL_ATTR_COLD void VReg___024root___eval_settle(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_settle\n"); );
    // Init
    CData/*0:0*/ __VstlContinue;
    // Body
    vlSelf->__VstlIterCount = 0U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        __VstlContinue = 0U;
        VReg___024root___eval_triggers__stl(vlSelf);
        if (vlSelf->__VstlTriggered.any()) {
            __VstlContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VstlIterCount))) {
#ifdef VL_DEBUG
                VReg___024root___dump_triggers__stl(vlSelf);
#endif
                VL_FATAL_MT("vsrc/define.v", 40, "", "Settle region did not converge.");
            }
            vlSelf->__VstlIterCount = ((IData)(1U) 
                                       + vlSelf->__VstlIterCount);
            VReg___024root___eval_stl(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VReg___024root___dump_triggers__stl(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VstlTriggered.at(0U)) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VReg___024root___stl_sequent__TOP__0(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___stl_sequent__TOP__0\n"); );
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
    vlSelf->top__DOT__data = ((0x3ffU >= (0x7ffffffU 
                                          & (vlSelf->top__DOT__addr 
                                             - (IData)(0x4c4b400U))))
                               ? vlSelf->top__DOT__rom__DOT__rom
                              [(0x7ffffffU & (vlSelf->top__DOT__addr 
                                              - (IData)(0x4c4b400U)))]
                               : 0U);
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
    vlSelf->top__DOT__gpr__DOT__reg_file[0U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[1U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[2U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[3U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[4U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[5U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[6U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[7U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[8U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[9U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xaU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xbU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xcU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xdU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xeU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0xfU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x10U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x11U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x12U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x13U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x14U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x15U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x16U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x17U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x18U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x19U] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1aU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1bU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1cU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1dU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1eU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout;
    vlSelf->top__DOT__gpr__DOT__reg_file[0x1fU] = vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout;
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

VL_ATTR_COLD void VReg___024root___eval_stl(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___eval_stl\n"); );
    // Body
    if (vlSelf->__VstlTriggered.at(0U)) {
        VReg___024root___stl_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VReg___024root___dump_triggers__ico(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___dump_triggers__ico\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VicoTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VicoTriggered.at(0U)) {
        VL_DBG_MSGF("         'ico' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void VReg___024root___dump_triggers__act(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VactTriggered.at(0U)) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void VReg___024root___dump_triggers__nba(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VnbaTriggered.at(0U)) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VReg___024root___ctor_var_reset(VReg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VReg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VReg___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->MuxKey__02Eout = VL_RAND_RESET_I(1);
    vlSelf->MuxKey__02Ekey = VL_RAND_RESET_I(1);
    vlSelf->MuxKey__02Elut = VL_RAND_RESET_I(4);
    vlSelf->MuxKeyWithDefault__02Eout = VL_RAND_RESET_I(1);
    vlSelf->MuxKeyWithDefault__02Ekey = VL_RAND_RESET_I(1);
    vlSelf->default_out = VL_RAND_RESET_I(1);
    vlSelf->MuxKeyWithDefault__02Elut = VL_RAND_RESET_I(4);
    vlSelf->clk = VL_RAND_RESET_I(1);
    vlSelf->reset = VL_RAND_RESET_I(1);
    vlSelf->__pinNumber3 = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->MuxKey__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_I(2);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->MuxKey__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->MuxKey__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    vlSelf->MuxKey__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(1);
    vlSelf->MuxKey__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->MuxKeyWithDefault__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_I(2);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->MuxKeyWithDefault__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->MuxKeyWithDefault__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(1);
    vlSelf->MuxKeyWithDefault__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__addr = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__pc_next = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__data = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__result = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__jump_singnal = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ram_signal = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 1024; ++__Vi0) {
        vlSelf->top__DOT__rom__DOT__rom[__Vi0] = VL_RAND_RESET_I(32);
    }
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->top__DOT__gpr__DOT__reg_file[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->__Vtrigrprev__TOP__clk = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 3; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
