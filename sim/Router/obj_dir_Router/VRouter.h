// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _VROUTER_H_
#define _VROUTER_H_  // guard

#include "verilated.h"

//==========

class VRouter__Syms;

//----------

VL_MODULE(VRouter) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(reset,0,0);
    VL_IN8(clk,0,0);
    VL_IN8(message_in,3,0);
    VL_OUT8(message_out,5,0);
    VL_IN8(ready,1,0);
    VL_OUT8(ready_out,0,0);
    VL_IN8(valid,0,0);
    VL_OUT8(valid_out,1,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    CData/*1:0*/ Router__DOT__v__DOT__temp_valid_out;
    CData/*2:0*/ Router__DOT__v__DOT__temp_message_out[2];
    CData/*0:0*/ Router__DOT__v__DOT__router_inst__DOT__valid_holder[2];
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    CData/*2:0*/ Router__DOT__v__DOT____Vcellout__router_inst__message_out[2];
    CData/*0:0*/ Router__DOT__v__DOT__router_inst__DOT____Vcellout__demux_inst__out_val[2];
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    VRouter__Syms* __VlSymsp;  // Symbol table
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(VRouter);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    VRouter(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~VRouter();
    
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
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(VRouter__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(VRouter__Syms* symsp, bool first);
  private:
    static QData _change_request(VRouter__Syms* __restrict vlSymsp);
    static QData _change_request_1(VRouter__Syms* __restrict vlSymsp);
  public:
    static void _combo__TOP__1(VRouter__Syms* __restrict vlSymsp);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(VRouter__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif  // VL_DEBUG
  public:
    static void _eval_initial(VRouter__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(VRouter__Syms* __restrict vlSymsp) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
