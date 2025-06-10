// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Valu.h for the primary calling header

#ifndef VERILATED_VALU___024ROOT_H_
#define VERILATED_VALU___024ROOT_H_  // guard

#include "verilated.h"

class Valu__Syms;

class Valu___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        VL_IN8(pc__02Eclk,0,0);
        VL_IN8(ram__02Eclk,0,0);
        VL_IN8(gpr__02Eclk,0,0);
        VL_IN8(op_ins,7,0);
        VL_OUT8(alu__02Eram_signal,0,0);
        VL_OUT8(jump_signal,0,0);
        VL_OUT8(decoder__02Erd,4,0);
        VL_OUT8(decoder__02Ers1,4,0);
        VL_OUT8(decoder__02Ers2,4,0);
        VL_OUT8(instruction,7,0);
        VL_IN8(pc__02Erst,0,0);
        VL_IN8(jump,0,0);
        VL_IN8(ram__02Erst,0,0);
        VL_IN8(byte_en,3,0);
        VL_IN8(ram__02Eram_signal,0,0);
        VL_IN8(gpr__02Erst,0,0);
        VL_IN8(gpr__02Ers1,4,0);
        VL_IN8(gpr__02Ers2,4,0);
        VL_IN8(gpr__02Erd,4,0);
        VL_OUT8(MuxKey__02Eout,0,0);
        VL_IN8(MuxKey__02Ekey,0,0);
        VL_IN8(MuxKey__02Elut,3,0);
        VL_OUT8(MuxKeyWithDefault__02Eout,0,0);
        VL_IN8(MuxKeyWithDefault__02Ekey,0,0);
        VL_IN8(default_out,0,0);
        VL_IN8(MuxKeyWithDefault__02Elut,3,0);
        CData/*0:0*/ MuxKey__DOT__i0__DOT__lut_out;
        CData/*0:0*/ MuxKey__DOT__i0__DOT__hit;
        CData/*0:0*/ MuxKeyWithDefault__DOT__i0__DOT__lut_out;
        CData/*0:0*/ MuxKeyWithDefault__DOT__i0__DOT__hit;
        CData/*0:0*/ __Vtrigrprev__TOP__pc__02Eclk;
        CData/*0:0*/ __Vtrigrprev__TOP__ram__02Eclk;
        CData/*0:0*/ __Vtrigrprev__TOP__gpr__02Eclk;
        CData/*0:0*/ __VactContinue;
        VL_IN(alu__02Esrc1,31,0);
        VL_IN(alu__02Esrc2,31,0);
        VL_IN(alu__02Eimm,31,0);
        VL_IN(ram_data,31,0);
        VL_OUT(alu__02Eout,31,0);
        VL_OUT(pc_next,31,0);
        VL_IN(ins,31,0);
        VL_OUT(decoder__02Eimm,31,0);
        VL_IN(din,31,0);
        VL_OUT(dout,31,0);
        VL_IN(rom__02Eaddr,31,0);
        VL_OUT(data,31,0);
        VL_IN(ram__02Edata_in,31,0);
        VL_IN(ram__02Eaddr,31,0);
        VL_OUT(data_out,31,0);
        VL_IN(gpr__02Edata_in,31,0);
        VL_OUT(gpr__02Esrc1,31,0);
        VL_OUT(gpr__02Esrc2,31,0);
        IData/*31:0*/ ram__DOT____Vlvbound_h09251640__0;
        IData/*31:0*/ ram__DOT____Vlvbound_h09251640__1;
        IData/*31:0*/ ram__DOT____Vlvbound_h09251640__2;
        IData/*31:0*/ ram__DOT____Vlvbound_h09251640__3;
        IData/*31:0*/ ram__DOT____Vlvbound_h09251640__4;
        IData/*31:0*/ ram__DOT____Vlvbound_h09251640__5;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__0__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__1__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__2__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__3__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__4__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__5__KET____DOT__r0__dout;
    };
    struct {
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__6__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__7__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__8__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__9__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__10__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__11__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__12__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__13__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__14__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__15__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__16__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__17__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__18__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__19__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__20__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__21__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__22__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__23__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__24__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__25__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__26__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__27__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__28__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__29__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__30__KET____DOT__r0__dout;
        IData/*31:0*/ gpr__DOT____Vcellout__genblk1__BRA__31__KET____DOT__r0__dout;
        IData/*31:0*/ __VstlIterCount;
        IData/*31:0*/ __VicoIterCount;
        IData/*31:0*/ __VactIterCount;
        VlUnpacked<IData/*31:0*/, 1024> rom__DOT__rom_mem;
        VlUnpacked<IData/*31:0*/, 2086> ram__DOT__ram_mem;
        VlUnpacked<IData/*31:0*/, 32> gpr__DOT__reg_file;
        VlUnpacked<CData/*1:0*/, 2> MuxKey__DOT__i0__DOT__pair_list;
        VlUnpacked<CData/*0:0*/, 2> MuxKey__DOT__i0__DOT__key_list;
        VlUnpacked<CData/*0:0*/, 2> MuxKey__DOT__i0__DOT__data_list;
        VlUnpacked<CData/*1:0*/, 2> MuxKeyWithDefault__DOT__i0__DOT__pair_list;
        VlUnpacked<CData/*0:0*/, 2> MuxKeyWithDefault__DOT__i0__DOT__key_list;
        VlUnpacked<CData/*0:0*/, 2> MuxKeyWithDefault__DOT__i0__DOT__data_list;
        VlUnpacked<CData/*0:0*/, 3> __Vm_traceActivity;
    };
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<3> __VactTriggered;
    VlTriggerVec<3> __VnbaTriggered;

    // INTERNAL VARIABLES
    Valu__Syms* const vlSymsp;

    // CONSTRUCTORS
    Valu___024root(Valu__Syms* symsp, const char* v__name);
    ~Valu___024root();
    VL_UNCOPYABLE(Valu___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
