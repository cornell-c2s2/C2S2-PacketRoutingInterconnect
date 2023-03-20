module parametricDemux
#(
  //length of message
  parameter p_nbits = 1,   
  parameter p_noutputs = 2
)
(
  input  wire [p_nbits-1:0]                 in,
  input  wire [$clog2(p_noutputs)-1:0]      sel,
  output wire [p_noutputs-1:0][p_nbits-1:0] out
);

  // Set all outputs to 0 (the right bit length too but not sure if this matters)
  assign out = {p_noutputs{1'b0}};
  
  // Set the selected output to the input value
  assign out[sel] = in; 

endmodule
