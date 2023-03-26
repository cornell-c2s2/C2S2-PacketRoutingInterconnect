`include "muxes.v"
`include "parametricDemuxVRTL.v"

module routerVRTL
#(
  parameter p_nbits = 8,
  parameter p_noutputs = 8
)(
  input logic                                                    valid,
  // input logic  [p_noutputs-1:0]                                  ready, (the orientation below is more accurate)
  input logic [p_noutputs-1:0]                                   ready, 
  input logic  [p_nbits-1:0]                                     message_in, 
  output logic                                                  ready_out,
  output logic [p_noutputs-1:0]                                 valid_out, 
  output logic [p_nbits-$clog2(p_noutputs)-1:0] message_out [p_noutputs-1:0]
);

//WHAT COMES OUT OF DEMUX (temporary val)
logic valid_holder [p_noutputs-1:0];
logic [p_nbits-1 : p_nbits-$clog2(p_noutputs)] select;
logic [p_nbits-$clog2(p_noutputs)-1:0] cut_message;

assign select = message_in[p_nbits-1 : p_nbits-$clog2(p_noutputs)];
assign cut_message = message_in[p_nbits-$clog2(p_noutputs)-1:0];

  vc_MuxN #(                   
    .p_nbits(1),               
    .p_ninputs(p_noutputs)     
  ) mux_inst (
    .in(ready),
    .sel(select),
    .out(ready_out)
  );

  parametricDemuxVRTL #(       
    .p_nbits(1),               
    .p_noutputs(p_noutputs)     
  ) demux_inst (
    .in_val(valid),
    .sel(select),
    .out_val(valid_holder)
  );

  generate
    for ( genvar j = 0; j < p_noutputs; j = j + 1) begin : output_gen
      assign valid_out[j] = (ready_out == 1) ? valid_holder[j] : 1'b0;
    end
  endgenerate

  generate
    for ( genvar k = 0; k < p_noutputs; k = k + 1) begin : output_gen
      assign message_out[k] = cut_message;
    end
  endgenerate
endmodule
