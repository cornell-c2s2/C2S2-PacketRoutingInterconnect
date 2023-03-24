// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VRouter.h for the primary calling header

#include "VRouter.h"
#include "VRouter__Syms.h"

//==========

void VRouter::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VRouter::eval\n"); );
    VRouter__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    VRouter* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("routerVRTL.v", 57, "",
                "Verilated model didn't converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

void VRouter::_eval_initial_loop(VRouter__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        _eval_settle(vlSymsp);
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("routerVRTL.v", 57, "",
                "Verilated model didn't DC converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

VL_INLINE_OPT void VRouter::_combo__TOP__1(VRouter__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRouter::_combo__TOP__1\n"); );
    VRouter* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->message_out = (0xffU & ((0xc0U & ((IData)(vlTOPp->message_in) 
                                              << 6U)) 
                                    | ((0x30U & ((IData)(vlTOPp->message_in) 
                                                 << 4U)) 
                                       | ((0xcU & ((IData)(vlTOPp->message_in) 
                                                   << 2U)) 
                                          | (3U & (IData)(vlTOPp->message_in))))));
    vlTOPp->ready_out = (1U & ((IData)(vlTOPp->ready) 
                               >> (3U & ((IData)(vlTOPp->message_in) 
                                         >> 2U))));
    vlTOPp->Router__DOT__v__DOT____Vcellout__demux_inst__out_val 
        = ((0xeU & (IData)(vlTOPp->Router__DOT__v__DOT____Vcellout__demux_inst__out_val)) 
           | ((0U == (3U & ((IData)(vlTOPp->message_in) 
                            >> 2U))) & (IData)(vlTOPp->valid)));
    vlTOPp->Router__DOT__v__DOT____Vcellout__demux_inst__out_val 
        = ((0xdU & (IData)(vlTOPp->Router__DOT__v__DOT____Vcellout__demux_inst__out_val)) 
           | (((1U == (3U & ((IData)(vlTOPp->message_in) 
                             >> 2U))) & (IData)(vlTOPp->valid)) 
              << 1U));
    vlTOPp->Router__DOT__v__DOT____Vcellout__demux_inst__out_val 
        = ((0xbU & (IData)(vlTOPp->Router__DOT__v__DOT____Vcellout__demux_inst__out_val)) 
           | (((2U == (3U & ((IData)(vlTOPp->message_in) 
                             >> 2U))) & (IData)(vlTOPp->valid)) 
              << 2U));
    vlTOPp->Router__DOT__v__DOT____Vcellout__demux_inst__out_val 
        = ((7U & (IData)(vlTOPp->Router__DOT__v__DOT____Vcellout__demux_inst__out_val)) 
           | (((3U == (3U & ((IData)(vlTOPp->message_in) 
                             >> 2U))) & (IData)(vlTOPp->valid)) 
              << 3U));
    vlTOPp->valid_out = ((1U & ((IData)(vlTOPp->ready) 
                                >> (3U & ((IData)(vlTOPp->message_in) 
                                          >> 2U))))
                          ? (0xfU & (IData)(vlTOPp->Router__DOT__v__DOT____Vcellout__demux_inst__out_val))
                          : 0U);
}

void VRouter::_eval(VRouter__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRouter::_eval\n"); );
    VRouter* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_combo__TOP__1(vlSymsp);
}

VL_INLINE_OPT QData VRouter::_change_request(VRouter__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRouter::_change_request\n"); );
    VRouter* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    return (vlTOPp->_change_request_1(vlSymsp));
}

VL_INLINE_OPT QData VRouter::_change_request_1(VRouter__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRouter::_change_request_1\n"); );
    VRouter* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void VRouter::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRouter::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((message_in & 0xf0U))) {
        Verilated::overWidthError("message_in");}
    if (VL_UNLIKELY((ready & 0xf0U))) {
        Verilated::overWidthError("ready");}
    if (VL_UNLIKELY((valid & 0xfeU))) {
        Verilated::overWidthError("valid");}
}
#endif  // VL_DEBUG
