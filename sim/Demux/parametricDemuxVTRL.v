// module parametricDemuxVTRL
// #(
//   //length of message
//   parameter p_nbits = 1,   
//   parameter p_noutputs = 2
// )
// (
//   input  wire [p_nbits-1:0]                  in_val,
//   input  wire [$clog2(p_noutputs)-1:0]       sel,
//   //output  wire [p_noutputs-1:0][p_nbits-1:0] out_val
//   output wire [p_noutputs*p_nbits-1:0] flattened_out_val
// );

//   // for sake of testing 
//   wire [p_noutputs-1:0][p_nbits-1:0] out_val;

//   // Set all outputs to 0 (the right bit length too but not sure if this matters)
//   assign out_val = {p_noutputs{1'b0}};
  
//   // Set the selected output to the input value
//   assign out_val[sel] = in_val; 

//   assign flattened_out_val = {out_val};

// endmodule


module parametricDemuxVTRL
#(
  //length of message
  parameter p_nbits = 1,   
  parameter p_noutputs = 2
)
(
  input  wire [p_nbits-1:0]                  in_val,
  input  wire [$clog2(p_noutputs)-1:0]       sel,
  output wire [p_noutputs*p_nbits-1:0]       flattened_out_val
);

  // For sake of testing 
  wire [p_noutputs-1:0][p_nbits-1:0] out_val;

  // Set selected output to input value
  assign out_val[sel] = in_val; 

  // Set non-selected outputs to 0
  genvar i;
  generate
    for (i = 0; i < p_noutputs; i = i + 1) begin : output_gen
      assign out_val[i] = (i == sel) ? in_val : {p_nbits{1'b0}};
    end
  endgenerate

  // Concatenate output values
  // assign flattened_out_val = {out_val};
  generate
    for (genvar i = 0; i < p_noutputs; i = i + 1) begin : output_gen
      assign flattened_out_val[i*p_nbits +: p_nbits] = out_val[p_noutputs - 1 - i];
    end
  endgenerate


endmodule
