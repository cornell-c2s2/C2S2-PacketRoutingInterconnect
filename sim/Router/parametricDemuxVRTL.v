module parametricDemuxVRTL
#(
  //length of message
  parameter p_nbits = 1,   
  //Number of outputs
  parameter p_noutputs = 2
)
(
  input  wire [p_nbits-1:0]                  in_val,
  input  wire [$clog2(p_noutputs)-1:0]       sel,
  output wire [p_noutputs-1:0][p_nbits-1:0]  out_val
);

  // This is the normal output, but for test, all of its values concatonated into flattened_out_val
  // For actual use of module, make this an output wire

  genvar i;
  generate
    for (i = 0; i < p_noutputs; i = i + 1) begin : output_gen
      assign out_val[i] = (i == sel) ? in_val : {p_nbits{1'b0}};
    end
  endgenerate



endmodule
