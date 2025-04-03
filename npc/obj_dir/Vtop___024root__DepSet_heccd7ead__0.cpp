// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop___024root.h"

void Vtop___024root___eval_act(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_act\n"); );
}

void Vtop___024root____Vdpiimwrap_top__DOT__dpi_ebreak_TOP();

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__0(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__0\n"); );
    // Init
    IData/*31:0*/ __Vdly__top__DOT__addr;
    __Vdly__top__DOT__addr = 0;
    SData/*11:0*/ __Vdlyvdim0__top__DOT__ram__DOT__ram_mem__v0;
    __Vdlyvdim0__top__DOT__ram__DOT__ram_mem__v0 = 0;
    IData/*31:0*/ __Vdlyvval__top__DOT__ram__DOT__ram_mem__v0;
    __Vdlyvval__top__DOT__ram__DOT__ram_mem__v0 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__ram__DOT__ram_mem__v0;
    __Vdlyvset__top__DOT__ram__DOT__ram_mem__v0 = 0;
    // Body
    __Vdly__top__DOT__addr = vlSelf->top__DOT__addr;
    __Vdlyvset__top__DOT__ram__DOT__ram_mem__v0 = 0U;
    if ((0x100073U == vlSelf->top__DOT__cur_data)) {
        Vtop___024root____Vdpiimwrap_top__DOT__dpi_ebreak_TOP();
    }
    if (vlSelf->reset) {
        __Vdly__top__DOT__addr = 0x80000000U;
        vlSelf->top__DOT__ram__DOT____Vlvbound_h09251640__0 = 0U;
        if ((0x825U >= (0xfffU & ((IData)(0x801U) + vlSelf->top__DOT__addr)))) {
            __Vdlyvval__top__DOT__ram__DOT__ram_mem__v0 
                = vlSelf->top__DOT__ram__DOT____Vlvbound_h09251640__0;
            __Vdlyvset__top__DOT__ram__DOT__ram_mem__v0 = 1U;
            __Vdlyvdim0__top__DOT__ram__DOT__ram_mem__v0 
                = (0xfffU & ((IData)(0x801U) + vlSelf->top__DOT__addr));
        }
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
        __Vdly__top__DOT__addr = ((IData)(4U) + vlSelf->top__DOT__addr);
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x1fU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x1eU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x1dU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x1cU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x1bU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x1aU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x19U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x18U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x17U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x16U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x15U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x14U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x13U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x12U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x11U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0x10U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0xfU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0xeU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0xdU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0xcU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0xbU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 0xaU))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 9U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 8U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 7U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 6U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 5U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 4U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 3U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 2U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & (((IData)(1U) 
                                           << (0x1fU 
                                               & (vlSelf->top__DOT__cur_data 
                                                  >> 7U))) 
                                          >> 1U))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
        if (((0U != (0x1fU & (vlSelf->top__DOT__cur_data 
                              >> 7U))) & ((IData)(1U) 
                                          << (0x1fU 
                                              & (vlSelf->top__DOT__cur_data 
                                                 >> 7U))))) {
            vlSelf->top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout 
                = vlSelf->top__DOT__result;
        }
    }
    if (__Vdlyvset__top__DOT__ram__DOT__ram_mem__v0) {
        vlSelf->top__DOT__ram__DOT__ram_mem[__Vdlyvdim0__top__DOT__ram__DOT__ram_mem__v0] 
            = __Vdlyvval__top__DOT__ram__DOT__ram_mem__v0;
    }
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
    vlSelf->top__DOT__cur_data = vlSelf->top__DOT__rom__DOT__rom_mem
        [(0x3ffU & ((vlSelf->top__DOT__addr - (IData)(0x80000000U)) 
                    >> 2U))];
    vlSelf->top__DOT__addr = __Vdly__top__DOT__addr;
    vlSelf->top__DOT__op_ins = ((0x13U == (0x7fU & vlSelf->top__DOT__cur_data))
                                 ? ((0U == (7U & (vlSelf->top__DOT__cur_data 
                                                  >> 0xcU)))
                                     ? 1U : ((2U == 
                                              (7U & 
                                               (vlSelf->top__DOT__cur_data 
                                                >> 0xcU)))
                                              ? 2U : 
                                             ((3U == 
                                               (7U 
                                                & (vlSelf->top__DOT__cur_data 
                                                   >> 0xcU)))
                                               ? 3U
                                               : ((4U 
                                                   == 
                                                   (7U 
                                                    & (vlSelf->top__DOT__cur_data 
                                                       >> 0xcU)))
                                                   ? 4U
                                                   : 
                                                  ((6U 
                                                    == 
                                                    (7U 
                                                     & (vlSelf->top__DOT__cur_data 
                                                        >> 0xcU)))
                                                    ? 5U
                                                    : 
                                                   ((7U 
                                                     == 
                                                     (7U 
                                                      & (vlSelf->top__DOT__cur_data 
                                                         >> 0xcU)))
                                                     ? 6U
                                                     : 0U))))))
                                 : 0U);
    vlSelf->top__DOT__src1 = vlSelf->top__DOT__gpr__DOT__reg_file
        [(0x1fU & (vlSelf->top__DOT__cur_data >> 0xfU))];
    vlSelf->top__DOT__result = ((1U == (IData)(vlSelf->top__DOT__op_ins))
                                 ? (vlSelf->top__DOT__src1 
                                    + ((0x13U == (0x7fU 
                                                  & vlSelf->top__DOT__cur_data))
                                        ? (((- (IData)(
                                                       (vlSelf->top__DOT__cur_data 
                                                        >> 0x1fU))) 
                                            << 0xcU) 
                                           | (vlSelf->top__DOT__cur_data 
                                              >> 0x14U))
                                        : 0U)) : ((2U 
                                                   == (IData)(vlSelf->top__DOT__op_ins))
                                                   ? 
                                                  (vlSelf->top__DOT__src1 
                                                   + 
                                                   vlSelf->top__DOT__gpr__DOT__reg_file
                                                   [
                                                   (0x1fU 
                                                    & (vlSelf->top__DOT__cur_data 
                                                       >> 0x14U))])
                                                   : 
                                                  ((3U 
                                                    == (IData)(vlSelf->top__DOT__op_ins))
                                                    ? 
                                                   ((0x825U 
                                                     >= 
                                                     (0xfffU 
                                                      & ((IData)(0x801U) 
                                                         + vlSelf->top__DOT__addr)))
                                                     ? 
                                                    vlSelf->top__DOT__ram__DOT__ram_mem
                                                    [
                                                    (0xfffU 
                                                     & ((IData)(0x801U) 
                                                        + vlSelf->top__DOT__addr))]
                                                     : 0U)
                                                    : 0U)));
}

void Vtop___024root___eval_nba(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_nba\n"); );
    // Body
    if (vlSelf->__VnbaTriggered.at(0U)) {
        Vtop___024root___nba_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
}

void Vtop___024root___eval_triggers__act(Vtop___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__act(Vtop___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__nba(Vtop___024root* vlSelf);
#endif  // VL_DEBUG

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            Vtop___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Vtop___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("vsrc/top.v", 1, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.set(vlSelf->__VactTriggered);
                Vtop___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Vtop___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("vsrc/top.v", 1, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Vtop___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void Vtop___024root___eval_debug_assertions(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
}
#endif  // VL_DEBUG
