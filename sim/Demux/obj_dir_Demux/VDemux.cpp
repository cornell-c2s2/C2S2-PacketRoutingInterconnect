// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VDemux.h for the primary calling header

#include "VDemux.h"
#include "VDemux__Syms.h"

//==========

void VDemux::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VDemux::eval\n"); );
    VDemux__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    VDemux* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
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
            VL_FATAL_MT("parametricDemuxVTRL.v", 45, "",
                "Verilated model didn't converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

void VDemux::_eval_initial_loop(VDemux__Syms* __restrict vlSymsp) {
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
            VL_FATAL_MT("parametricDemuxVTRL.v", 45, "",
                "Verilated model didn't DC converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

VL_INLINE_OPT void VDemux::_combo__TOP__1(VDemux__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VDemux::_combo__TOP__1\n"); );
    VDemux* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->Demux__DOT__v__DOT__out_val = ((0xfcU & (IData)(vlTOPp->Demux__DOT__v__DOT__out_val)) 
                                           | ((0U == (IData)(vlTOPp->sel))
                                               ? (IData)(vlTOPp->in_val)
                                               : 0U));
    vlTOPp->Demux__DOT__v__DOT__out_val = ((0xf3U & (IData)(vlTOPp->Demux__DOT__v__DOT__out_val)) 
                                           | (((1U 
                                                == (IData)(vlTOPp->sel))
                                                ? (IData)(vlTOPp->in_val)
                                                : 0U) 
                                              << 2U));
    vlTOPp->Demux__DOT__v__DOT__out_val = ((0xcfU & (IData)(vlTOPp->Demux__DOT__v__DOT__out_val)) 
                                           | (((2U 
                                                == (IData)(vlTOPp->sel))
                                                ? (IData)(vlTOPp->in_val)
                                                : 0U) 
                                              << 4U));
    vlTOPp->Demux__DOT__v__DOT__out_val = ((0x3fU & (IData)(vlTOPp->Demux__DOT__v__DOT__out_val)) 
                                           | (((3U 
                                                == (IData)(vlTOPp->sel))
                                                ? (IData)(vlTOPp->in_val)
                                                : 0U) 
                                              << 6U));
    vlTOPp->flattened_out_val = ((0xfcU & (IData)(vlTOPp->flattened_out_val)) 
                                 | (3U & ((IData)(vlTOPp->Demux__DOT__v__DOT__out_val) 
                                          >> 6U)));
    vlTOPp->flattened_out_val = ((0xf3U & (IData)(vlTOPp->flattened_out_val)) 
                                 | (0xcU & ((IData)(vlTOPp->Demux__DOT__v__DOT__out_val) 
                                            >> 2U)));
    vlTOPp->flattened_out_val = ((0xcfU & (IData)(vlTOPp->flattened_out_val)) 
                                 | (0x30U & ((IData)(vlTOPp->Demux__DOT__v__DOT__out_val) 
                                             << 2U)));
    vlTOPp->flattened_out_val = ((0x3fU & (IData)(vlTOPp->flattened_out_val)) 
                                 | (0xc0U & ((IData)(vlTOPp->Demux__DOT__v__DOT__out_val) 
                                             << 6U)));
}

void VDemux::_eval(VDemux__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VDemux::_eval\n"); );
    VDemux* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_combo__TOP__1(vlSymsp);
}

VL_INLINE_OPT QData VDemux::_change_request(VDemux__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VDemux::_change_request\n"); );
    VDemux* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    return (vlTOPp->_change_request_1(vlSymsp));
}

VL_INLINE_OPT QData VDemux::_change_request_1(VDemux__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VDemux::_change_request_1\n"); );
    VDemux* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void VDemux::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VDemux::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((in_val & 0xfcU))) {
        Verilated::overWidthError("in_val");}
    if (VL_UNLIKELY((sel & 0xfcU))) {
        Verilated::overWidthError("sel");}
}
#endif  // VL_DEBUG
