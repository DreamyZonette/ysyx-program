// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Valu.h for the primary calling header

#include "verilated.h"

#include "Valu___024root.h"

VL_ATTR_COLD void Valu___024root___eval_static__TOP(Valu___024root* vlSelf);

VL_ATTR_COLD void Valu___024root___eval_static(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_static\n"); );
    // Body
    Valu___024root___eval_static__TOP(vlSelf);
}

VL_ATTR_COLD void Valu___024root___eval_static__TOP(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_static__TOP\n"); );
    // Init
    IData/*31:0*/ __Vilp;
    // Body
    __Vilp = 0U;
    while ((__Vilp <= 0x825U)) {
        vlSelf->ram__DOT__ram_mem[__Vilp] = 0U;
        __Vilp = ((IData)(1U) + __Vilp);
    }
}

VL_ATTR_COLD void Valu___024root___eval_initial__TOP(Valu___024root* vlSelf);

VL_ATTR_COLD void Valu___024root___eval_initial(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_initial\n"); );
    // Body
    Valu___024root___eval_initial__TOP(vlSelf);
    vlSelf->__Vtrigrprev__TOP__pc__02Eclk = vlSelf->pc__02Eclk;
    vlSelf->__Vtrigrprev__TOP__ram__02Eclk = vlSelf->ram__02Eclk;
    vlSelf->__Vtrigrprev__TOP__gpr__02Eclk = vlSelf->gpr__02Eclk;
}

VL_ATTR_COLD void Valu___024root___eval_initial__TOP(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_initial__TOP\n"); );
    // Body
    vlSelf->alu__02Eram_signal = 0U;
    vlSelf->jump_signal = 0U;
    vlSelf->pc_next = 0U;
    vlSelf->rom__DOT__rom_mem[0U] = 0x500093U;
    vlSelf->rom__DOT__rom_mem[1U] = 0xffd08113U;
    vlSelf->rom__DOT__rom_mem[2U] = 0x18193U;
    vlSelf->rom__DOT__rom_mem[3U] = 0x7ff20213U;
    vlSelf->rom__DOT__rom_mem[4U] = 0x80028293U;
    vlSelf->rom__DOT__rom_mem[5U] = 0x100073U;
}

VL_ATTR_COLD void Valu___024root___eval_final(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_final\n"); );
}

VL_ATTR_COLD void Valu___024root___eval_triggers__stl(Valu___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Valu___024root___dump_triggers__stl(Valu___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD void Valu___024root___eval_stl(Valu___024root* vlSelf);

VL_ATTR_COLD void Valu___024root___eval_settle(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_settle\n"); );
    // Init
    CData/*0:0*/ __VstlContinue;
    // Body
    vlSelf->__VstlIterCount = 0U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        __VstlContinue = 0U;
        Valu___024root___eval_triggers__stl(vlSelf);
        if (vlSelf->__VstlTriggered.any()) {
            __VstlContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VstlIterCount))) {
#ifdef VL_DEBUG
                Valu___024root___dump_triggers__stl(vlSelf);
#endif
                VL_FATAL_MT("/home/long/ysyx-workbench/npc/vsrc/EXU/alu.v", 1, "", "Settle region did not converge.");
            }
            vlSelf->__VstlIterCount = ((IData)(1U) 
                                       + vlSelf->__VstlIterCount);
            Valu___024root___eval_stl(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Valu___024root___dump_triggers__stl(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VstlTriggered.at(0U)) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Valu___024root___stl_sequent__TOP__0(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___stl_sequent__TOP__0\n"); );
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
    vlSelf->gpr__DOT__reg_file[0U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[1U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[2U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[3U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[4U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[5U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[6U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[7U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[8U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[9U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xaU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xbU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xcU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xdU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xeU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0xfU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x10U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x11U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x12U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x13U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x14U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x15U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x16U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x17U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x18U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x19U] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1aU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1bU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1cU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1dU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1eU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout;
    vlSelf->gpr__DOT__reg_file[0x1fU] = vlSelf->gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout;
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
    vlSelf->gpr__02Esrc1 = vlSelf->gpr__DOT__reg_file
        [vlSelf->gpr__02Ers1];
    vlSelf->gpr__02Esrc2 = vlSelf->gpr__DOT__reg_file
        [vlSelf->gpr__02Ers2];
}

VL_ATTR_COLD void Valu___024root___eval_stl(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___eval_stl\n"); );
    // Body
    if (vlSelf->__VstlTriggered.at(0U)) {
        Valu___024root___stl_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Valu___024root___dump_triggers__ico(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___dump_triggers__ico\n"); );
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
VL_ATTR_COLD void Valu___024root___dump_triggers__act(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VactTriggered.at(0U)) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge pc.clk)\n");
    }
    if (vlSelf->__VactTriggered.at(1U)) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @(posedge ram.clk)\n");
    }
    if (vlSelf->__VactTriggered.at(2U)) {
        VL_DBG_MSGF("         'act' region trigger index 2 is active: @(posedge gpr.clk)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Valu___024root___dump_triggers__nba(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VnbaTriggered.at(0U)) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge pc.clk)\n");
    }
    if (vlSelf->__VnbaTriggered.at(1U)) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @(posedge ram.clk)\n");
    }
    if (vlSelf->__VnbaTriggered.at(2U)) {
        VL_DBG_MSGF("         'nba' region trigger index 2 is active: @(posedge gpr.clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Valu___024root___ctor_var_reset(Valu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->alu__02Esrc1 = VL_RAND_RESET_I(32);
    vlSelf->alu__02Esrc2 = VL_RAND_RESET_I(32);
    vlSelf->alu__02Eimm = VL_RAND_RESET_I(32);
    vlSelf->ram_data = VL_RAND_RESET_I(32);
    vlSelf->op_ins = VL_RAND_RESET_I(8);
    vlSelf->alu__02Eout = VL_RAND_RESET_I(32);
    vlSelf->alu__02Eram_signal = VL_RAND_RESET_I(1);
    vlSelf->jump_signal = VL_RAND_RESET_I(1);
    vlSelf->pc_next = VL_RAND_RESET_I(32);
    vlSelf->ins = VL_RAND_RESET_I(32);
    vlSelf->decoder__02Erd = VL_RAND_RESET_I(5);
    vlSelf->decoder__02Ers1 = VL_RAND_RESET_I(5);
    vlSelf->decoder__02Ers2 = VL_RAND_RESET_I(5);
    vlSelf->decoder__02Eimm = VL_RAND_RESET_I(32);
    vlSelf->instruction = VL_RAND_RESET_I(8);
    vlSelf->pc__02Eclk = VL_RAND_RESET_I(1);
    vlSelf->pc__02Erst = VL_RAND_RESET_I(1);
    vlSelf->din = VL_RAND_RESET_I(32);
    vlSelf->dout = VL_RAND_RESET_I(32);
    vlSelf->jump = VL_RAND_RESET_I(1);
    vlSelf->rom__02Eaddr = VL_RAND_RESET_I(32);
    vlSelf->data = VL_RAND_RESET_I(32);
    vlSelf->ram__02Eclk = VL_RAND_RESET_I(1);
    vlSelf->ram__02Erst = VL_RAND_RESET_I(1);
    vlSelf->ram__02Edata_in = VL_RAND_RESET_I(32);
    vlSelf->ram__02Eaddr = VL_RAND_RESET_I(32);
    vlSelf->byte_en = VL_RAND_RESET_I(4);
    vlSelf->data_out = VL_RAND_RESET_I(32);
    vlSelf->ram__02Eram_signal = VL_RAND_RESET_I(1);
    vlSelf->gpr__02Eclk = VL_RAND_RESET_I(1);
    vlSelf->gpr__02Erst = VL_RAND_RESET_I(1);
    vlSelf->gpr__02Ers1 = VL_RAND_RESET_I(5);
    vlSelf->gpr__02Ers2 = VL_RAND_RESET_I(5);
    vlSelf->gpr__02Erd = VL_RAND_RESET_I(5);
    vlSelf->gpr__02Edata_in = VL_RAND_RESET_I(32);
    vlSelf->gpr__02Esrc1 = VL_RAND_RESET_I(32);
    vlSelf->gpr__02Esrc2 = VL_RAND_RESET_I(32);
    vlSelf->MuxKey__02Eout = VL_RAND_RESET_I(1);
    vlSelf->MuxKey__02Ekey = VL_RAND_RESET_I(1);
    vlSelf->MuxKey__02Elut = VL_RAND_RESET_I(4);
    vlSelf->MuxKeyWithDefault__02Eout = VL_RAND_RESET_I(1);
    vlSelf->MuxKeyWithDefault__02Ekey = VL_RAND_RESET_I(1);
    vlSelf->default_out = VL_RAND_RESET_I(1);
    vlSelf->MuxKeyWithDefault__02Elut = VL_RAND_RESET_I(4);
    for (int __Vi0 = 0; __Vi0 < 1024; ++__Vi0) {
        vlSelf->rom__DOT__rom_mem[__Vi0] = VL_RAND_RESET_I(32);
    }
    for (int __Vi0 = 0; __Vi0 < 2086; ++__Vi0) {
        vlSelf->ram__DOT__ram_mem[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->ram__DOT____Vlvbound_h09251640__0 = VL_RAND_RESET_I(32);
    vlSelf->ram__DOT____Vlvbound_h09251640__1 = VL_RAND_RESET_I(32);
    vlSelf->ram__DOT____Vlvbound_h09251640__2 = VL_RAND_RESET_I(32);
    vlSelf->ram__DOT____Vlvbound_h09251640__3 = VL_RAND_RESET_I(32);
    vlSelf->ram__DOT____Vlvbound_h09251640__4 = VL_RAND_RESET_I(32);
    vlSelf->ram__DOT____Vlvbound_h09251640__5 = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->gpr__DOT__reg_file[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
    vlSelf->gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout = VL_RAND_RESET_I(32);
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
    vlSelf->__Vtrigrprev__TOP__pc__02Eclk = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigrprev__TOP__ram__02Eclk = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigrprev__TOP__gpr__02Eclk = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 3; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
