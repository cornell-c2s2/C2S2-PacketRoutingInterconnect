module parametricDemuxVTRL
#(
  //length of message
  parameter p_nbits = 1,   
  //Number of outputs
  parameter p_noutputs = 2
)
(
  input  wire [p_nbits-1:0]                  in_val,
  input  wire [$clog2(p_noutputs)-1:0]       sel,
  output wire [p_noutputs*p_nbits-1:0]       flattened_out_val
);

  // This is the normal output, but for test, all of its values concatonated into flattened_out_val
  wire [p_noutputs-1:0][p_nbits-1:0] out_val;


  genvar i;
  generate
    for (i = 0; i < p_noutputs; i = i + 1) begin : output_gen
      assign out_val[i] = (i == sel) ? in_val : {p_nbits{1'b0}};
    end
  endgenerate

  // Concatenate output values
  generate
    for (genvar i = 0; i < p_noutputs; i = i + 1) begin : output_gen
      assign flattened_out_val[i*p_nbits +: p_nbits] = out_val[p_noutputs - 1 - i];
    end
  endgenerate


endmodule
