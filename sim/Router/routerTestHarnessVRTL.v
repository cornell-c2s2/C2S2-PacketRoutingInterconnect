`include "routerVRTL.v"

 module routerTestHarnessVRTL
#(
  parameter p_nbits = 8,
  parameter p_noutputs = 8
)(
  input wire                                                    valid,
  input wire  [p_noutputs-1:0]                                  ready,
  input wire  [p_nbits-1:0]                                     message_in, 
  output logic                                                  ready_out,
  output logic [p_noutputs-1:0]                                 valid_out,
  output wire [(p_nbits-$clog2(p_noutputs))*p_noutputs-1:0]     message_out     
);


logic [(p_nbits-$clog2(p_noutputs))-1:0]  temp_message_out  [p_noutputs-1:0];
logic [p_noutputs-1:0] temp_valid_out;

  routerVRTL #(
    .p_nbits(p_nbits),
    .p_noutputs(p_noutputs)
  ) router_inst (
    .valid(valid),
    .ready(ready),
    .message_in(message_in),
    .valid_out(temp_valid_out),
    .ready_out(ready_out),
    .message_out(temp_message_out)
  );

  generate
    for (genvar i = 0; i < p_noutputs; i = i + 1) begin : output_gen
      assign valid_out[i +: 1] = temp_valid_out[p_noutputs - 1 - i];
    end
  endgenerate

  generate
    for ( genvar l = 0; l < p_noutputs; l = l + 1) begin : output_gen
      assign message_out[l*(p_nbits-$clog2(p_noutputs)) +: p_nbits-$clog2(p_noutputs)] = temp_message_out[p_noutputs-l-1];
    end
  endgenerate

  endmodule

