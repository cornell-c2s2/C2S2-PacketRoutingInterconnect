#====================================================================================
# Choose PyMTL or Verilog version
#====================================================================================

rtl_language = 'verilog'

# This is the PyMTL wrapper for the corresponding Verilog RTL model CrossbarVRTL.

from pymtl3 import *
from pymtl3.stdlib import stream
from pymtl3.passes.backends.verilog import *


class CrossbarVRTL( VerilogPlaceholder, Component ):

  # Constructor

  def construct( s, BIT_WIDTH = 32, N_INPUTS = 2, N_OUTPUTS = 2, ADDRESS_BIT_WIDTH = 4, BLOCK_ADDRESS = 2 ):

    # If translated into Verilog, we use the explicit name

    s.set_metadata( VerilogTranslationPass.explicit_module_name, 'Crossbar' )

    # Interface
    s.recv      = [ stream.ifcs.RecvIfcRTL( mk_bits(BIT_WIDTH) ) for _ in range(N_INPUTS) ] 
    s.send      = [ stream.ifcs.SendIfcRTL( mk_bits(BIT_WIDTH) ) for _ in range(N_OUTPUTS)]
    s.ctrl      =   stream.ifcs.RecvIfcRTL( mk_bits(BIT_WIDTH) ) 

import sys
if hasattr( sys, '_called_from_test' ):
  if sys._pymtl_rtl_override:
    rtl_language = sys._pymtl_rtl_override
elif rtl_language == 'verilog':
  crossbar = CrossbarVRTL
else:
  raise Exception("Invalid RTL language!")

