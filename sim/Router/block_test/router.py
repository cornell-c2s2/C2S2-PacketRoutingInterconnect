
#=========================================================================
# Crossbar_test
#=========================================================================

import pytest

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim

from crossbar.crossbarRTL import crossbarVRTL



def test_simple( cmdline_opts):
  run_test_vector_sim(crossbarVRTL(),[
    ('a     b*'),
    [0x00, '?' ],
    [0x00, 0x01],
    [0x00, 0x01],
  ],cmdline_opts)

def test_counting( cmdline_opts):
  run_test_vector_sim(crossbarVRTL(),[
    ('a     b*'),
    [0x00, '?' ],
    [0x01, 0x01],
    [0x02, 0x02],
  ],cmdline_opts)
  


#Add more tests here :)