// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VRouter.h for the primary calling header

#include "VRouter.h"
#include "VRouter__Syms.h"

//==========

VL_CTOR_IMP(VRouter) {
    VRouter__Syms* __restrict vlSymsp = __VlSymsp = new VRouter__Syms(this, name());
    VRouter* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void VRouter::__Vconfigure(VRouter__Syms* vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
    if (false && this->__VlSymsp) {}  // Prevent unused
    Verilated::timeunit(-12);
    Verilated::timeprecision(-12);
}

VRouter::~VRouter() {
    VL_DO_CLEAR(delete __VlSymsp, __VlSymsp = NULL);
}

void VRouter::_eval_initial(VRouter__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRouter::_eval_initial\n"); );
    VRouter* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void VRouter::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRouter::final\n"); );
    // Variables
    VRouter__Syms* __restrict vlSymsp = this->__VlSymsp;
    VRouter* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void VRouter::_eval_settle(VRouter__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRouter::_eval_settle\n"); );
    VRouter* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_combo__TOP__1(vlSymsp);
}

void VRouter::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRouter::_ctor_var_reset\n"); );
    // Body
    reset = VL_RAND_RESET_I(1);
    clk = VL_RAND_RESET_I(1);
    message_in = VL_RAND_RESET_I(4);
    message_out = VL_RAND_RESET_I(6);
    ready = VL_RAND_RESET_I(2);
    ready_out = VL_RAND_RESET_I(1);
    valid = VL_RAND_RESET_I(1);
    valid_out = VL_RAND_RESET_I(2);
    { int __Vi0=0; for (; __Vi0<2; ++__Vi0) {
            Router__DOT__v__DOT__temp_message_out[__Vi0] = VL_RAND_RESET_I(3);
    }}
    Router__DOT__v__DOT__temp_valid_out = VL_RAND_RESET_I(2);
    { int __Vi0=0; for (; __Vi0<2; ++__Vi0) {
            Router__DOT__v__DOT____Vcellout__router_inst__message_out[__Vi0] = VL_RAND_RESET_I(3);
    }}
    { int __Vi0=0; for (; __Vi0<2; ++__Vi0) {
            Router__DOT__v__DOT__router_inst__DOT__valid_holder[__Vi0] = VL_RAND_RESET_I(1);
    }}
    { int __Vi0=0; for (; __Vi0<2; ++__Vi0) {
            Router__DOT__v__DOT__router_inst__DOT____Vcellout__demux_inst__out_val[__Vi0] = VL_RAND_RESET_I(1);
    }}
}
