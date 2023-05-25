module ParametricMux
#(
  parameter nbits = 1,
  parameter ninputs = 2
)(
  input  logic               [nbits-1:0]   in   [0:ninputs-1], 
  input  logic     [$clog2(ninputs)-1:0]   sel,
  output logic               [nbits-1:0]   out
);

  assign out = in[sel];

endmodule

