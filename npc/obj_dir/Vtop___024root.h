// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop.h for the primary calling header

#ifndef VERILATED_VTOP___024ROOT_H_
#define VERILATED_VTOP___024ROOT_H_  // guard

#include "verilated.h"

class Vtop__Syms;

class Vtop___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(reset,0,0);
    CData/*7:0*/ top__DOT__op_ins;
    CData/*0:0*/ __Vtrigrprev__TOP__clk;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ top__DOT__addr;
    IData/*31:0*/ top__DOT__cur_data;
    IData/*31:0*/ top__DOT__src1;
    IData/*31:0*/ top__DOT__result;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout;
    IData/*31:0*/ top__DOT__ram__DOT____Vlvbound_h09251640__0;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 1024> top__DOT__rom__DOT__rom_mem;
    VlUnpacked<IData/*31:0*/, 32> top__DOT__gpr__DOT__reg_file;
    VlUnpacked<IData/*31:0*/, 2086> top__DOT__ram__DOT__ram_mem;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vtop__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop___024root(Vtop__Syms* symsp, const char* v__name);
    ~Vtop___024root();
    VL_UNCOPYABLE(Vtop___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
