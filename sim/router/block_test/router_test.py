#=========================================================================
# router_test
#=========================================================================

import pytest

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim
from router.Router import Router



def test_one( cmdline_opts ):
  dut = Router(nbits=4, noutputs=2)
  run_test_vector_sim(dut,[
    ("istream_val istream_msg istream_rdy* ostream_val[0]* ostream_val[1]* ostream_msg[0]* ostream_msg[1]* ostream_rdy[0] ostream_rdy[1]"),
    [ 0x1,        0x1,        0x1,         0x0,            0x0,            0x0,            0x0,            0x1,         0x1], #1
    [ 0x1,        0x2,        0x1,         0x1,            0x0,            0x1,            0x1,            0x1,         0x1], #2
    [ 0x1,        0x3,        0x1,         0x1,            0x0,            0x2,            0x2,            0x1,         0x1], #3
    [ 0x1,        0x4,        0x1,         0x1,            0x0,            0x3,            0x3,            0x0,         0x0], #4
    [ 0x1,        0x4,        0x1,         0x1,            0x0,            0x3,            0x3,            0x1,         0x1], #5
    [ 0x1,        0x5,        0x1,         0x1,            0x0,            0x4,            0x4,            0x1,         0x1], #6
    [ 0x1,        0x8,        0x1,         0x1,            0x0,            0x4,            0x4,            0x1,         0x1], #7
    [ 0x1,        0x9,        0x1,         0x1,            0x0,            0x5,            0x5,            0x1,         0x1], #8
    [ 0x1,        0x0,        0x1,         0x0,            0x1,            0x8,            0x8,            0x1,         0x1], #9
  ],cmdline_opts)

# Row 1: 1 is enqueued.
# Row 2: 2 is enqueued. 1 is dequeued with high valid bit at port 0. 
# Row 3: 3 is enqueued. 2 is dequeued with high valid bit at port 0. 
# Row 4: 4 is enqueued. 3 is dequeued with high valid bit at port 0. Successful enqueue but not a sucessful dequeue
# Row 5: 4 is enqueued. 4 is dequeued with high valid bit at port 0. 
# Row 6: 5 is enqueued. 4 is dequeued with high valid bit at port 0. 
# Row 7: 8 is enqueued. 4 is dequeued with high valid bit at port 0. 
# Row 8: 9 is enqueued. 8 is dequeued with high valid bit at port 1. 
# Row 9: '?' is enqueued. 9 is dequeued with high valid bit at port 1.


#Disregard below for now...
#-------------------------------------------------------------------------------------------------------------------------------------------------


# def test_one( cmdline_opts ):
#   dut = Router(nbits=4, noutputs=2)
#   run_test_vector_sim(dut,[
#     ("istream_val istream_msg istream_rdy* ostream_val[0]* ostream_val[1]* ostream_msg[0]* ostream_msg[1]* ostream_rdy[0] ostream_rdy[1]"),
#     [ 0x1,        0x7,        0x1,         0x1,            0x0,            0x7,            0x7,            0x1,         0x0],
#     [ 0x1,        0xf,        0x1,         0x0,            0x1,            0xf,            0xf,            0x0,         0x1]
#   ],cmdline_opts)


# def test_two( cmdline_opts ):
#   dut = Router(nbits=4, noutputs=4)
#   run_test_vector_sim(dut,[
#     ("istream_val istream_msg istream_rdy* ostream_val[0]* ostream_val[1]* ostream_val[2]* ostream_val[3]* ostream_msg[0]* ostream_msg[1]* ostream_msg[2]* ostream_msg[3]* ostream_rdy[0] ostream_rdy[1] ostream_rdy[2] ostream_rdy[3]"),
#     [ 0x1,        0x2,        0x1,         0x1,            0x0,            0x0,            0x0,            0x2,            0x2,            0x2,            0x2,            0x1,           0x0,           0x0,           0x0],
#     [ 0x1,        0x6,        0x1,         0x0,            0x1,            0x0,            0x0,            0x6,            0x6,            0x6,            0x6,            0x0,           0x1,           0x0,           0x0],
#     [ 0x1,        0xa,        0x1,         0x0,            0x0,            0x1,            0x0,            0xa,            0xa,            0xa,            0xa,            0x0,           0x0,           0x1,           0x0],
#     [ 0x1,        0xf,        0x1,         0x0,            0x0,            0x0,            0x1,            0xf,            0xf,            0xf,            0xf,            0x0,           0x0,           0x0,           0x1],
#   ],cmdline_opts)


# def test_three( cmdline_opts ):
#   dut = Router(nbits=4, noutputs=2)
#   run_test_vector_sim(dut,[
#     ("istream_val istream_msg istream_rdy* ostream_val[0]* ostream_val[1]* ostream_msg[0]* ostream_msg[1]* ostream_rdy[0] ostream_rdy[1]"),
#     [ 0x1,        0x7,        0x1,         0x1,            0x0,            0x7,            0x7,            0x1,         0x1],
#     [ 0x1,        0xf,        0x1,         0x0,            0x1,            0xf,            0xf,            0x1,         0x1]
#   ],cmdline_opts)


# def test_four( cmdline_opts ):
#   dut = Router(nbits=40, noutputs=2)
#   run_test_vector_sim(dut,[
#     ("istream_val istream_msg          istream_rdy* ostream_val[0]* ostream_val[1]* ostream_msg[0]*          ostream_msg[1]*          ostream_rdy[0] ostream_rdy[1]"),
#     [ 0x1,        0x2fffffffff,        0x1,         0x1,            0x0,            0x2fffffffff,            0x2fffffffff,            0x1,           0x0],
#     [ 0x1,        0xffffffffff,        0x1,         0x0,            0x1,            0xffffffffff,            0xffffffffff,            0x0,           0x1]
#   ],cmdline_opts)

# def test_five( cmdline_opts ):
#   dut = Router(nbits=4, noutputs=2)
#   run_test_vector_sim(dut,[
#     ("istream_val istream_msg istream_rdy* ostream_val[0]* ostream_val[1]* ostream_msg[0]* ostream_msg[1]* ostream_rdy[0] ostream_rdy[1]"),
#     [ 0x1,        0x7,        0x0,         0x1,            0x0,            0x7,            0x7,            0x0,         0x0],
#   ],cmdline_opts)