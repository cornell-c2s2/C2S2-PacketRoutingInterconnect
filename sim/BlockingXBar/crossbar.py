# This is the PyMTL wrapper for the corresponding Verilog RTL model crossbarVRTL.

from pymtl3 import *
from pymtl3.stdlib import stream
from pymtl3.passes.backends.verilog import *


class crossbarVRTL( VerilogPlaceholder, Component ):

  # Constructor

  def construct( s ):
    # If translated into Verilog, we use the explicit name

    s.set_metadata( VerilogTranslationPass.explicit_module_name, 'crossbar' )

    # Interface
    s.a = InPort(32)
    s.b = OutPort(32)


crossbar = crossbarVRTL
