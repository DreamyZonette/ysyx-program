// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary model header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef VERILATED_VALU_H_
#define VERILATED_VALU_H_  // guard

#include "verilated.h"

class Valu__Syms;
class Valu___024root;
class VerilatedVcdC;

// This class is the main interface to the Verilated model
class Valu VL_NOT_FINAL : public VerilatedModel {
  private:
    // Symbol table holding complete model state (owned by this class)
    Valu__Syms* const vlSymsp;

  public:

    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(&pc__02Eclk,0,0);
    VL_IN8(&ram__02Eclk,0,0);
    VL_IN8(&gpr__02Eclk,0,0);
    VL_IN8(&op_ins,7,0);
    VL_OUT8(&alu__02Eram_signal,0,0);
    VL_OUT8(&jump_signal,0,0);
    VL_OUT8(&decoder__02Erd,4,0);
    VL_OUT8(&decoder__02Ers1,4,0);
    VL_OUT8(&decoder__02Ers2,4,0);
    VL_OUT8(&instruction,7,0);
    VL_IN8(&pc__02Erst,0,0);
    VL_IN8(&jump,0,0);
    VL_IN8(&ram__02Erst,0,0);
    VL_IN8(&byte_en,3,0);
    VL_IN8(&ram__02Eram_signal,0,0);
    VL_IN8(&gpr__02Erst,0,0);
    VL_IN8(&gpr__02Ers1,4,0);
    VL_IN8(&gpr__02Ers2,4,0);
    VL_IN8(&gpr__02Erd,4,0);
    VL_OUT8(&MuxKey__02Eout,0,0);
    VL_IN8(&MuxKey__02Ekey,0,0);
    VL_IN8(&MuxKey__02Elut,3,0);
    VL_OUT8(&MuxKeyWithDefault__02Eout,0,0);
    VL_IN8(&MuxKeyWithDefault__02Ekey,0,0);
    VL_IN8(&default_out,0,0);
    VL_IN8(&MuxKeyWithDefault__02Elut,3,0);
    VL_IN(&alu__02Esrc1,31,0);
    VL_IN(&alu__02Esrc2,31,0);
    VL_IN(&alu__02Eimm,31,0);
    VL_IN(&ram_data,31,0);
    VL_OUT(&alu__02Eout,31,0);
    VL_OUT(&pc_next,31,0);
    VL_IN(&ins,31,0);
    VL_OUT(&decoder__02Eimm,31,0);
    VL_IN(&din,31,0);
    VL_OUT(&dout,31,0);
    VL_IN(&rom__02Eaddr,31,0);
    VL_OUT(&data,31,0);
    VL_IN(&ram__02Edata_in,31,0);
    VL_IN(&ram__02Eaddr,31,0);
    VL_OUT(&data_out,31,0);
    VL_IN(&gpr__02Edata_in,31,0);
    VL_OUT(&gpr__02Esrc1,31,0);
    VL_OUT(&gpr__02Esrc2,31,0);

    // CELLS
    // Public to allow access to /* verilator public */ items.
    // Otherwise the application code can consider these internals.

    // Root instance pointer to allow access to model internals,
    // including inlined /* verilator public_flat_* */ items.
    Valu___024root* const rootp;

    // CONSTRUCTORS
    /// Construct the model; called by application code
    /// If contextp is null, then the model will use the default global context
    /// If name is "", then makes a wrapper with a
    /// single model invisible with respect to DPI scope names.
    explicit Valu(VerilatedContext* contextp, const char* name = "TOP");
    explicit Valu(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    virtual ~Valu();
  private:
    VL_UNCOPYABLE(Valu);  ///< Copying not allowed

  public:
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    /// Are there scheduled events to handle?
    bool eventsPending();
    /// Returns time at next time slot. Aborts if !eventsPending()
    uint64_t nextTimeSlot();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options = 0);
    /// Retrieve name of this model instance (as passed to constructor).
    const char* name() const;

    // Abstract methods from VerilatedModel
    const char* hierName() const override final;
    const char* modelName() const override final;
    unsigned threads() const override final;
    std::unique_ptr<VerilatedTraceConfig> traceConfig() const override final;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
