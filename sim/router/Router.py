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


#============================= DISREGARD BELOW =======================================

# SOURCE/STREAM ATTEMPT 1
 
# from pymtl3 import *
# from pymtl3.stdlib import stream
# from pymtl3.passes.backends.verilog import *
# import math

# class Router( VerilogPlaceholder, Component ):

#   def construct( s, nbits, noutputs ):
  
#     # Source and sink interfaces for testing
#     s.src = stream.SourceRTL( mk_bits(nbits) )
#     s.sinks = [ stream.SinkRTL( mk_bits(nbits) ) for _ in range(noutputs) ]
    
#     # Connect the source to the router input stream
#     s.istream_val = InPort(1)
#     s.istream_msg = InPort( mk_bits(nbits) )
#     s.istream_rdy = OutPort(1)
#     s.src.send //= s.istream_msg
#     s.src.ready //= s.istream_rdy
#     s.istream_val //= s.src.valid

#     # Connect the router output streams to the sinks
#     s.ostream_val = [ OutPort( mk_bits(1) ) for _ in range(noutputs) ]
#     s.ostream_msg = [ OutPort( mk_bits(nbits) ) for _ in range(noutputs) ]
#     s.ostream_rdy = [ InPort( mk_bits(1) ) for _ in range(noutputs) ]
#     for i in range(noutputs):
#       s.sinks[i].recv //= s.ostream_msg[i]
#       s.sinks[i].valid //= s.ostream_val[i]
#       s.ostream_rdy[i] //= s.sinks[i].ready

#   def line_trace( s ):
#     return f"({s.src.line_trace()}) > " + " > ".join([f"({sink.line_trace()})" for sink in s.sinks])



# SOURCE/STREAM ATTEMPT 2

# from pymtl3 import *
# from pymtl3.passes.backends.verilog import *
# from pymtl3.stdlib.stream.ifcs import IStreamIfc, OStreamIfc

# class router( VerilogPlaceholder, Component ):
#   def construct( s, nbits, noutputs ):
#     s.istream = IStreamIfc( Bits32 )
#     s.ostream = OStreamIfc( Bits16 )
