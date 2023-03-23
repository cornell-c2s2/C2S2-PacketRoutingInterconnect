// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _VDEMUX__SYMS_H_
#define _VDEMUX__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "VDemux.h"

// SYMS CLASS
class VDemux__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_didInit;
    
    // SUBCELL STATE
    VDemux*                        TOPp;
    
    // CREATORS
    VDemux__Syms(VDemux* topp, const char* namep);
    ~VDemux__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
