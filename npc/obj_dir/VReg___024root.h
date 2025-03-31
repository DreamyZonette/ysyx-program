// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VReg.h for the primary calling header

#ifndef VERILATED_VREG___024ROOT_H_
#define VERILATED_VREG___024ROOT_H_  // guard

#include "verilated.h"

class VReg__Syms;

class VReg___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        VL_IN8(clk,0,0);
        VL_OUT8(MuxKey__02Eout,0,0);
        VL_IN8(MuxKey__02Ekey,0,0);
        VL_IN8(MuxKey__02Elut,3,0);
        VL_OUT8(MuxKeyWithDefault__02Eout,0,0);
        VL_IN8(MuxKeyWithDefault__02Ekey,0,0);
        VL_IN8(default_out,0,0);
        VL_IN8(MuxKeyWithDefault__02Elut,3,0);
        VL_IN8(reset,0,0);
        VL_IN8(__pinNumber3,0,0);
        CData/*0:0*/ MuxKey__DOT__i0__DOT__lut_out;
        CData/*0:0*/ MuxKey__DOT__i0__DOT__hit;
        CData/*0:0*/ MuxKeyWithDefault__DOT__i0__DOT__lut_out;
        CData/*0:0*/ MuxKeyWithDefault__DOT__i0__DOT__hit;
        CData/*0:0*/ top__DOT__jump_singnal;
        CData/*0:0*/ top__DOT__ram_signal;
        CData/*0:0*/ __Vtrigrprev__TOP__clk;
        CData/*0:0*/ __VactContinue;
        IData/*31:0*/ top__DOT__addr;
        IData/*31:0*/ top__DOT__pc_next;
        IData/*31:0*/ top__DOT__data;
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
        IData/*31:0*/ __VstlIterCount;
        IData/*31:0*/ __VicoIterCount;
        IData/*31:0*/ __VactIterCount;
        VlUnpacked<CData/*1:0*/, 2> MuxKey__DOT__i0__DOT__pair_list;
        VlUnpacked<CData/*0:0*/, 2> MuxKey__DOT__i0__DOT__key_list;
        VlUnpacked<CData/*0:0*/, 2> MuxKey__DOT__i0__DOT__data_list;
        VlUnpacked<CData/*1:0*/, 2> MuxKeyWithDefault__DOT__i0__DOT__pair_list;
        VlUnpacked<CData/*0:0*/, 2> MuxKeyWithDefault__DOT__i0__DOT__key_list;
        VlUnpacked<CData/*0:0*/, 2> MuxKeyWithDefault__DOT__i0__DOT__data_list;
        VlUnpacked<IData/*31:0*/, 1024> top__DOT__rom__DOT__rom;
    };
    struct {
        VlUnpacked<IData/*31:0*/, 32> top__DOT__gpr__DOT__reg_file;
        VlUnpacked<CData/*0:0*/, 3> __Vm_traceActivity;
    };
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    VReg__Syms* const vlSymsp;

    // CONSTRUCTORS
    VReg___024root(VReg__Syms* symsp, const char* v__name);
    ~VReg___024root();
    VL_UNCOPYABLE(VReg___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
