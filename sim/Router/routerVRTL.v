`include "muxes.v"
`include "parametricDemuxVRTL.v"

module routerVRTL
#(
  parameter p_nbits = 8,
  parameter p_noutputs = 8
)(
  input wire                                                    valid,
  input wire  [p_noutputs-1:0]                                  ready,
  input wire  [p_nbits-1:0]                                     message_in, 
  output wire [p_noutputs-1:0][p_nbits-1:0]                     valid_out, 
  output wire                                                   ready_out,
  //[p_noutputs-1:0] output wire [p_nbits-$clog(p_noutputs)-1:0]  message_out,
  output wire [(p_nbits-$clog2(p_noutputs))*p_noutputs-1:0]     message_out                
);

wire [p_nbits-1 : p_nbits-$clog2(p_noutputs)] select;
wire [p_nbits-$clog2(p_noutputs)-1:0] cut_message;
wire [p_noutputs-1:0][p_nbits-1:0] valid_holder;


assign select = message_in[p_nbits-1 : p_nbits-$clog2(p_noutputs)];
assign cut_message = message_in[p_nbits-$clog2(p_noutputs)-1:0];

  vc_MuxN #(                   // mux selecting the ready bit for the selected port
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

  assign valid_out = ((ready[select]==1)) ? valid_holder : 1'b0;
  assign message_out = {p_noutputs{cut_message}};

endmodule
