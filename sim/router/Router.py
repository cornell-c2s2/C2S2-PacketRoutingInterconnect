# This is the PyMTL wrapper for the corresponding Verilog RTL model router.

from pymtl3 import *
from pymtl3.stdlib import stream
from pymtl3.passes.backends.verilog import *
import math


class Router( VerilogPlaceholder, Component ):

  # Constructor
    def construct( s, nbits, noutputs):

      s.istream_val = InPort(1)
      s.istream_msg = InPort( mk_bits(nbits) )
      s.istream_rdy = OutPort(1)

      s.ostream_val = [ OutPort( mk_bits(1) ) for _ in range(noutputs) ]
      s.ostream_msg = [ OutPort( mk_bits(nbits) ) for _ in range(noutputs) ]
      s.ostream_rdy = [ InPort( mk_bits(1) ) for _ in range(noutputs) ]
