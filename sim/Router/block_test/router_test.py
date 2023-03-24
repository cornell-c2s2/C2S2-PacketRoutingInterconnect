#=========================================================================
# router_test
#=========================================================================

import pytest

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim

from Router.routerRTL import routerVRTL

def test_simple( cmdline_opts ):
  dut = routerVRTL(p_nbits=4, p_noutputs=2)

  run_test_vector_sim(dut,[
    ('valid ready message_in valid_out* ready_out* message_out*'),
    [0x1, 0x1, 0x7, 0x1, 0x1, 0x3f],
    [0x1, 0x2, 0xf, 0x2, 0x1, 0x3f],
    [0x1, 0x0, 0xf, 0x0, 0x0, 0x3f],
  ],cmdline_opts)

  
def test_simple2( cmdline_opts ):
  dut = routerVRTL(p_nbits=4, p_noutputs=4)

  run_test_vector_sim(dut,[
    ('valid ready message_in valid_out* ready_out* message_out*'),
    [0x1, 0x1, 0x2, 0x1, 0x1, 0xaa],
    [0x1, 0x2, 0x6, 0x2, 0x1, 0xaa],
    [0x1, 0x4, 0x8, 0x4, 0x1, 0x00],
    [0x1, 0x8, 0xf, 0x8, 0x1, 0xff],
    [0x1, 0x0, 0x8, 0x0, 0x0, 0x0],
  ],cmdline_opts)
