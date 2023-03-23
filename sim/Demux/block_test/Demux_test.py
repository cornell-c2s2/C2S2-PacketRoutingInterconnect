
#=========================================================================
# parametricDemux_test
#=========================================================================

import pytest

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim

from Demux.parametricDemuxRTL import parametricDemuxVTRL



def test_simple( cmdline_opts ):
  dut = parametricDemuxVTRL(p_nbits=1, p_noutputs=2)

  # 1 to 2 demux with 1 bit high input. 
  # in_val = 1 and sel=1 means output port 2 gets routed 1. flattened_out_val is a concatonated binary number
  # of all the output port values. So, if port 1 is high, and port two is 0, flattened_out_val = 2 (10 in binary)
  #if port one is zero, and port two is 1, flattened_out_val = 1 (01 in binary)
  run_test_vector_sim(dut,[
    ('in_val sel flattened_out_val*'),
    [0x1, 0x1, 0x1],
    [0x1, 0x0, 0x2]
  ],cmdline_opts)

  # Same priciple as previous mux. If port 1 selected,flattened_out_val = 8 (1000 in binary)
def test_simple2( cmdline_opts ):
  dut = parametricDemuxVTRL(p_nbits=1, p_noutputs=4)

  run_test_vector_sim(dut,[
    ('in_val sel flattened_out_val*'),
    [0x1, 0x0, 0x8],
    [0x1, 0x1, 0x4], 
    [0x1, 0x2, 0x2], 
    [0x1, 0x3, 0x1]
  ],cmdline_opts)

def test_simple3( cmdline_opts ):
  dut = parametricDemuxVTRL(p_nbits=2, p_noutputs=2)

  run_test_vector_sim(dut,[
    ('in_val sel flattened_out_val*'),
    [0x3, 0x0, 0xc],
    [0x3, 0x1, 0x3],

  ],cmdline_opts)