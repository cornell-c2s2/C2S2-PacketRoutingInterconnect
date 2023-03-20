
module Router
#(
  parameter p_nbits = 8,
  parameter p_noutputs = 8
)(
  input wire                                                    valid,
  input wire  [p_noutputs-1:0]                                  ready,
  input wire  [p_nbits-1:0]                                     message_in, 
  output wire [p_noutputs-1:0]                                  valid_out, 
  output wire [p_noutputs-1:0][p_nbits-$clog(p_noutputs)-1:0]   message_out,
  output wire [p_noutputs-1:0]                                  ready_out
);

  wire cut_message[p_nbits-$clog(p_noutputs)-1:0];
  wire select [$clog(p_noutputs)-1:0];

  //Outline of what is happening above: 
  // -> p_nbits is the length of intial message
  // -> valid is the valid bit for the router module 
  // -> ready represents a p_noutput bit long signal that represents the ready signal from all receiving blocks
  // which can be indexed to get specific valeus. E.g. ready[0] is the ready signal from first output port
  // -> message_in represents the messsage coming into the router 
  // -> valid_out represents a p_noutput bit long signal that represents the valid signals going to the outport blocks
  // which can also be indexed
  // -> message_out represents p_noutputs, p_nbits-$clog(p_noutputs) bit log messages. E.g, if p_nbits = 16 and p_noutputs = 8, 
  // we would have 8, 13 bit messages. 
  // -> ready_out outputing ready signal from the router module
  // 
  // The wires used for internal logic

  assign select = message_in[p_nbits-1:p_nbits - $clog(p_noutputs)];   //clips off some of the MSB for select
  assign cut_message = message_in[p_nbits-$clog(p_noutputs)-1:0];      //puts shortened signal into a wire 

  vc_MuxN #(                   // mux selecting the ready bit for the selected port
    .p_nbits(1),               // number of bits for each input and output (always one for router)
    .p_ninputs(p_noutputs)     // number of inputs (depends on number of outputs for router)
  ) mux_inst (
    .in(ready),
    .sel(select),
    .out(ready_out)
  );

  if(ready_out[select]) begin   //checking if the ready bit for selected port is high
    parametricDemux #(
      .p_nbits(1),               
      .p_noutputs(p_noutputs)     
    ) demux_inst (
      .in(valid),
      .sel(select),
      .out(valid_out)
    );

    assign message_out = {p_noutputs{cut_message}}; //In theory, this line assigns all output ports the spliced message
  end

endmodule