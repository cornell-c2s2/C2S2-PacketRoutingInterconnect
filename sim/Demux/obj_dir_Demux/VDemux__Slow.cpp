// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VDemux.h for the primary calling header

#include "VDemux.h"
#include "VDemux__Syms.h"

//==========

VL_CTOR_IMP(VDemux) {
    VDemux__Syms* __restrict vlSymsp = __VlSymsp = new VDemux__Syms(this, name());
    VDemux* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void VDemux::__Vconfigure(VDemux__Syms* vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
    if (false && this->__VlSymsp) {}  // Prevent unused
    Verilated::timeunit(-12);
    Verilated::timeprecision(-12);
}

VDemux::~VDemux() {
    VL_DO_CLEAR(delete __VlSymsp, __VlSymsp = NULL);
}

void VDemux::_eval_initial(VDemux__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VDemux::_eval_initial\n"); );
    VDemux* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void VDemux::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VDemux::final\n"); );
    // Variables
    VDemux__Syms* __restrict vlSymsp = this->__VlSymsp;
    VDemux* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void VDemux::_eval_settle(VDemux__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VDemux::_eval_settle\n"); );
    VDemux* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_combo__TOP__1(vlSymsp);
}

void VDemux::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VDemux::_ctor_var_reset\n"); );
    // Body
    reset = VL_RAND_RESET_I(1);
    clk = VL_RAND_RESET_I(1);
    flattened_out_val = VL_RAND_RESET_I(4);
    in_val = VL_RAND_RESET_I(2);
    sel = VL_RAND_RESET_I(1);
    Demux__DOT__v__DOT__out_val = VL_RAND_RESET_I(4);
}
