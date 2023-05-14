#=========================================================================
# Crossbar_test
#=========================================================================

import pytest

from pymtl3 import *
from pymtl3.stdlib import stream
from pymtl3.stdlib.test_utils import mk_test_case_table, run_sim
from BlockingXBar.CrossbarRTL import CrossbarVRTL
from pymtl3.passes.backends.verilog import *

#------------------------------------------------------------------------------------------
# TestHarness
#------------------------------------------------------------------------------------------

class TestHarness( Component ):

  def construct( s, crossbar, BIT_WIDTH = 32, N_INPUTS = 2, N_OUTPUTS = 2, ADDRESS_BIT_WIDTH = 4, BLOCK_ADDRESS = 2 ):

    # Instantiate models
    s.src1      = stream.SourceRTL( mk_bits(BIT_WIDTH) ) 
    s.src2      = stream.SourceRTL( mk_bits(BIT_WIDTH) ) 
    s.sink1     = stream.SinkRTL  ( mk_bits(BIT_WIDTH) ) 
    s.sink2     = stream.SinkRTL  ( mk_bits(BIT_WIDTH) ) 
    s.ctrl_src  = stream.SourceRTL( mk_bits(BIT_WIDTH) ) 
    s.crossbar  = crossbar

    # Connect
    s.src1.send         //= s.crossbar.recv[0]
    s.src2.send         //= s.crossbar.recv[1]
    s.ctrl_src.send     //= s.crossbar.ctrl
    s.crossbar.send[0]  //= s.sink1.recv
    s.crossbar.send[1]  //= s.sink2.recv
    

  def done ( s ):
    return s.src1.done() and s.src2.done() and s.sink1.done() and s.sink2.done() and s.ctrl_src.done()
  
  def line_trace ( s ):
    return s.ctrl_src.line_trace() + " > " + s.src1.line_trace() + " > " + s.src2.line_trace() + " > " + s.crossbar.line_trace() + " > " + s.sink1.line_trace() + " > " + s.sink2.line_trace()

#-------------------------------------------------------------------------------------
# Test Case Table
#------------------------------------------------------------------------------------

def zero_zero ():
  return [ [ 0x28000000], 
           [ 0x00000001 ], [ 0x00000002 ],
           [ 0x00000001 ], [            ] ]

def zero_one ():
  return [ [ 0x2A000000], 
           [ 0x00000001 ], [ 0x00000002 ],
           [            ], [ 0x00000001 ] ]
  
def one_zero ():
  return [ [ 0x2C000000], 
           [ 0x00000001 ], [ 0x00000002 ],
           [ 0x00000002 ], [            ] ]

def one_one ():
  return [ [ 0x2E000000], 
           [ 0x00000001 ], [ 0x00000002 ],
           [            ], [ 0x00000002 ] ]

def no_write ():
  return [ [ 0x26000000], 
           [ 0x00000001 ], [ 0x00000002 ],
           [ 0x00000001 ], [            ] ]

test_case_table = mk_test_case_table([
  (                     "msgs               control_delay  src_delay  sink_delay  BIT_WIDTH  N_INPUTS  N_OUTPUTS  ADDRESS_BIT_WDITH  BLOCK_ADDRESS"),
  [ "zero_zero",        zero_zero,          4,             4,         4,          32,        2,        2,         4,                 2             ],
  [ "zero_one",         zero_one,           4,             4,         4,          32,        2,        2,         4,                 2             ],
  [ "one_zero",         one_zero,           4,             4,         4,          32,        2,        2,         4,                 2             ],
  [ "one_one",          one_one,            4,             4,         4,          32,        2,        2,         4,                 2             ],
  [ "no_write",         no_write,           4,             4,         4,          32,        2,        2,         4,                 2             ],
])


def package( array, bitwidth ):
  input = Bits(1)
  bit_convert = mk_bits(bitwidth)
  output = input
  for i in range(len(array)):
    output = concat( bit_convert(array[i]), output )
  return output

#-------------------------------------------------------------------------
# TestHarness
#-------------------------------------------------------------------------

@pytest.mark.parametrize( **test_case_table )
def test( test_params, cmdline_opts ):

  th = TestHarness( CrossbarVRTL(test_params.BIT_WIDTH, test_params.N_INPUTS, test_params.N_OUTPUTS, test_params.ADDRESS_BIT_WDITH, test_params.BLOCK_ADDRESS), 
                                            test_params.BIT_WIDTH, test_params.N_INPUTS, test_params.N_OUTPUTS, test_params.ADDRESS_BIT_WDITH, test_params.BLOCK_ADDRESS)

  msgs = test_params.msgs()
  
  th.set_param("top.ctrl_src.construct",
    msgs=msgs[0],
    initial_delay=test_params.control_delay+3,
    interval_delay=test_params.control_delay )

  th.set_param("top.src1.construct",
    msgs=msgs[1],
    initial_delay=test_params.src_delay+5,
    interval_delay=test_params.src_delay )
  
  th.set_param("top.src2.construct",
    msgs=msgs[2],
    initial_delay=test_params.src_delay+5,
    interval_delay=test_params.src_delay )

  th.set_param("top.sink1.construct",
    msgs=msgs[3],
    initial_delay=test_params.sink_delay+7,
    interval_delay=test_params.sink_delay )

  th.set_param("top.sink2.construct",
    msgs=msgs[4],
    initial_delay=test_params.sink_delay+7,
    interval_delay=test_params.sink_delay )
  
  run_sim( th, cmdline_opts, duts=['crossbar'] )


'''
import pytest

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim


from BlockingXBar.crossbarRTL import crossbarVRTL

# Basic Test
def test_one ( cmdline_opts ): 
  
  run_test_vector_sim ( crossbarVRTL( BIT_WIDTH = 32, N_INPUTS = 2, N_OUTPUTS = 2, CONTROL_BIT_WIDTH = 42), [
    ('recv_msg[0]  recv_val[0]  recv_rdy[0]*  recv_msg[1]  recv_val[1]  recv_rdy[1]*  send_msg[0]  send_val[0]*  send_rdy[0]  send_msg[1]  send_val[1]*  send_rdy[1]  control  control_val control_rdy*'),
    [0xFFFFFFFFFFFFFFFF, 0x3,     0x2,      0xFFFFFFFF00000000, 0x2,      0x3,     0x10000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFF, 0x3,     0x2,      0x00000000FFFFFFFF, 0x1,      0x3,     0x20000000000, 0x1,        0x1],
    [0xFFFFFFFFAAAAAAAA, 0x3,     0x1,      0xAAAAAAAA00000000, 0x2,      0x3,     0x30000000000, 0x1,        0x1],
    [0xAAAAAAAABBBBBBBB, 0x3,     0x1,      0x00000000BBBBBBBB, 0x1,      0x3,     0x00000000000, 0x1,        0x1],
    [0xAAAAAAAAAAAAAAAA, 0x3,     0x2,      0xAAAAAAAA00000000, 0x2,      0x3,     0x00000000000, 0x1,        0x1],
  ],cmdline_opts)


# Smaller BIT_WIDTH
def test_two ( cmdline_opts ): 
  dut = crossbarTestHarnessVRTL( BIT_WIDTH = 8, N_INPUTS = 2, N_OUTPUTS = 2, CONTROL_BIT_WIDTH = 42)

  run_test_vector_sim ( dut, [
    ('recv_msg           recv_val recv_rdy* send_msg*           send_val* send_rdy control        control_val control_rdy*'),
    [0xABFF,             0x3,     0x2,      0xAB00,             0x2,      0x3,     0x10000000000, 0x1,        0x1],
    [0x0FFF,             0x3,     0x2,      0x000F,             0x1,      0x3,     0x20000000000, 0x1,        0x1],
    [0x00AF,             0x3,     0x1,      0xAF00,             0x2,      0x3,     0x30000000000, 0x1,        0x1],
    [0xB00F,             0x3,     0x1,      0x000F,             0x1,      0x3,     0x00000000000, 0x1,        0x1],
    [0xFA00,             0x3,     0x2,      0xFA00,             0x2,      0x3,     0x00000000000, 0x1,        0x1],
  ],cmdline_opts)


# Smaller CONTROL_BIT_WIDTH
def test_three ( cmdline_opts ): 
  dut = crossbarTestHarnessVRTL( BIT_WIDTH = 32, N_INPUTS = 2, N_OUTPUTS = 2, CONTROL_BIT_WIDTH = 10)

  run_test_vector_sim ( dut, [
    ('recv_msg           recv_val recv_rdy* send_msg*           send_val* send_rdy control        control_val control_rdy*'),
    [0xFFFFFFFFFFFFFFFF, 0x3,     0x2,      0xFFFFFFFF00000000, 0x2,      0x3,     0x100,         0x1,        0x1],
    [0xFFFFFFFFFFFFFFFF, 0x3,     0x2,      0x00000000FFFFFFFF, 0x1,      0x3,     0x200,         0x1,        0x1],
    [0xFFFFFFFFAAAAAAAA, 0x3,     0x1,      0xAAAAAAAA00000000, 0x2,      0x3,     0x300,         0x1,        0x1],
    [0xAAAAAAAABBBBBBBB, 0x3,     0x1,      0x00000000BBBBBBBB, 0x1,      0x3,     0x000,         0x1,        0x1],
    [0xAAAAAAAAAAAAAAAA, 0x3,     0x2,      0xAAAAAAAA00000000, 0x2,      0x3,     0x000,         0x1,        0x1],
  ],cmdline_opts)


# 4 in, 4 out
def test_four ( cmdline_opts ): 
  dut = crossbarTestHarnessVRTL( BIT_WIDTH = 32, N_INPUTS = 4, N_OUTPUTS = 4, CONTROL_BIT_WIDTH = 42)

  run_test_vector_sim ( dut, [
    ('recv_msg                           recv_val recv_rdy* send_msg*                           send_val* send_rdy control        control_val control_rdy*'),
    [0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 0xF,     0x8,      0xFFFFFFFF000000000000000000000000, 0x8,      0xF,     0x04000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 0xF,     0x8,      0x00000000FFFFFFFF0000000000000000, 0x4,      0xF,     0x08000000000, 0x1,        0x1],
    [0xFFFFFFFFAAAAAAAAFFFFFFFFBBBBBBBB, 0xF,     0x8,      0x0000000000000000FFFFFFFF00000000, 0x2,      0xF,     0x0C000000000, 0x1,        0x1],
    [0xAAAAAAAABBBBBBBBFFFFFFFFBBBBBBBB, 0xF,     0x8,      0x000000000000000000000000AAAAAAAA, 0x1,      0xF,     0x10000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFBBBBBBBB, 0xF,     0x4,      0xFFFFFFFF000000000000000000000000, 0x8,      0xF,     0x14000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFBBBBBBBB, 0xF,     0x4,      0x00000000FFFFFFFF0000000000000000, 0x4,      0xF,     0x18000000000, 0x1,        0x1],
    [0xFFFFFFFFAAAAAAAAFFFFFFFFBBBBBBBB, 0xF,     0x4,      0x0000000000000000AAAAAAAA00000000, 0x2,      0xF,     0x1C000000000, 0x1,        0x1],
    [0xAAAAAAAABBBBBBBBFFFFFFFFBBBBBBBB, 0xF,     0x4,      0x000000000000000000000000BBBBBBBB, 0x1,      0xF,     0x20000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFBBBBBBBB, 0xF,     0x2,      0xFFFFFFFF000000000000000000000000, 0x8,      0xF,     0x24000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFBBBBBBBB, 0xF,     0x2,      0x00000000FFFFFFFF0000000000000000, 0x4,      0xF,     0x28000000000, 0x1,        0x1],
    [0xFFFFFFFFAAAAAAAAFFFFFFFFBBBBBBBB, 0xF,     0x2,      0x0000000000000000FFFFFFFF00000000, 0x2,      0xF,     0x2C000000000, 0x1,        0x1],
    [0xAAAAAAAABBBBBBBBFFFFFFFFBBBBBBBB, 0xF,     0x2,      0x000000000000000000000000FFFFFFFF, 0x1,      0xF,     0x30000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFBBBBBBBB, 0xF,     0x1,      0xBBBBBBBB000000000000000000000000, 0x8,      0xF,     0x34000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFBBBBBBBB, 0xF,     0x1,      0x00000000BBBBBBBB0000000000000000, 0x4,      0xF,     0x38000000000, 0x1,        0x1],
    [0xFFFFFFFFAAAAAAAAFFFFFFFFAAAAAAAA, 0xF,     0x1,      0x0000000000000000AAAAAAAA00000000, 0x2,      0xF,     0x3C000000000, 0x1,        0x1],
    [0xAAAAAAAABBBBBBBBFFFFFFFFCCCCCCCC, 0xF,     0x1,      0x000000000000000000000000CCCCCCCC, 0x1,      0xF,     0x00000000000, 0x1,        0x1],
  ],cmdline_opts)


# 4 in, 2 out
def test_five ( cmdline_opts ): 
  dut = crossbarTestHarnessVRTL( BIT_WIDTH = 32, N_INPUTS = 4, N_OUTPUTS = 2, CONTROL_BIT_WIDTH = 42)

  run_test_vector_sim ( dut, [
    ('recv_msg                           recv_val recv_rdy* send_msg*           send_val* send_rdy control        control_val control_rdy*'),
    [0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 0xF,     0x8,      0xFFFFFFFF00000000, 0x2,      0x3,     0x08000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 0xF,     0x8,      0x00000000FFFFFFFF, 0x1,      0x3,     0x10000000000, 0x1,        0x1],
    [0xFFFFFFFFAAAAAAAAFFFFFFFFBBBBBBBB, 0xF,     0x4,      0xAAAAAAAA00000000, 0x2,      0x3,     0x18000000000, 0x1,        0x1],
    [0xAAAAAAAABBBBBBBBFFFFFFFFBBBBBBBB, 0xF,     0x4,      0x00000000BBBBBBBB, 0x1,      0x3,     0x20000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFBBBBBBBB, 0xF,     0x2,      0xFFFFFFFF00000000, 0x2,      0x3,     0x28000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFFFFFFFFFFBBBBBBBB, 0xF,     0x2,      0x00000000FFFFFFFF, 0x1,      0x3,     0x30000000000, 0x1,        0x1],
    [0xFFFFFFFFAAAAAAAAFFFFFFFFBBBBBBBB, 0xF,     0x1,      0xBBBBBBBB00000000, 0x2,      0x3,     0x38000000000, 0x1,        0x1],
    [0xAAAAAAAABBBBBBBBFFFFFFFFBBBBBBBB, 0xF,     0x1,      0x00000000BBBBBBBB, 0x1,      0x3,     0x00000000000, 0x1,        0x1],
  ],cmdline_opts)

# No recv_val is 1
def test_seven ( cmdline_opts ): 
  dut = crossbarTestHarnessVRTL( BIT_WIDTH = 32, N_INPUTS = 2, N_OUTPUTS = 2, CONTROL_BIT_WIDTH = 42)

  run_test_vector_sim ( dut, [
    ('recv_msg           recv_val recv_rdy* send_msg*           send_val* send_rdy control        control_val control_rdy*'),
    [0xFFFFFFFFFFFFFFFF, 0x0,     0x2,      0xFFFFFFFF00000000, 0x0,      0x3,     0x10000000000, 0x1,        0x1],
    [0xFFFFFFFFFFFFFFFF, 0x0,     0x2,      0x00000000FFFFFFFF, 0x0,      0x3,     0x20000000000, 0x1,        0x1],
    [0xFFFFFFFFAAAAAAAA, 0x0,     0x1,      0xAAAAAAAA00000000, 0x0,      0x3,     0x30000000000, 0x1,        0x1],
    [0xAAAAAAAABBBBBBBB, 0x0,     0x1,      0x00000000BBBBBBBB, 0x0,      0x3,     0x00000000000, 0x1,        0x1],
    [0xAAAAAAAAAAAAAAAA, 0x0,     0x2,      0xAAAAAAAA00000000, 0x0,      0x3,     0x00000000000, 0x1,        0x1],
  ],cmdline_opts)
'''