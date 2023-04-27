`include "../../../PacketRoutingInterconnect/sim/router/ParametricMux.v"
`include "../../../PacketRoutingInterconnect/sim/router/ParametricDemux.v"
`include "../../../PacketRoutingInterconnect/sim/router/queues.v"

module Router
#(
  parameter nbits = 32,
  parameter noutputs = 8
)
(
  input clk,
  input reset,

  // In stream
  input  logic                                    istream_val,
  input  logic                      [nbits-1:0]   istream_msg,
  output logic                                    istream_rdy,

  // Out stream
  output logic                                    ostream_val   [0:noutputs-1], 
  output logic                      [nbits-1:0]   ostream_msg   [0:noutputs-1],
  input  logic                                    ostream_rdy   [0:noutputs-1]   
);

  logic                   [$clog2(noutputs)-1:0]  select;
  logic                              [nbits-1:0]  payload_msg;
  logic                                           payload_val;
  logic                                           payload_rdy;
  
  assign select =                                 payload_msg  [nbits-1 : nbits-$clog2(noutputs)];  

  vc_Queue #(
  .p_msg_nbits (nbits),
  .p_num_msgs  (3)
  )
  queue_inst
  (
  .clk                          (clk),
  .reset                        (reset), 
  .recv_val                     (istream_val), 
  .recv_rdy                     (istream_rdy),
  .recv_msg                     (istream_msg),
  .send_val                     (payload_val),
  .send_rdy                     (payload_rdy),
  .send_msg                     (payload_msg),
  .num_free_entries             ()
  );

  // Ready bit
  ParametricMux #(                   
    .nbits                      (1),               
    .ninputs                    (noutputs)     
  ) 
  mux_inst 
  (
    .in                         (ostream_rdy),
    .sel                        (select),
    .out                        (payload_rdy)
  );

  // Valid bit
  ParametricDemux #(       
    .nbits                      (1),               
    .noutputs                   (noutputs)     
  ) 
  demux_inst 
  (
    .in                         (payload_val),
    .sel                        (select),
    .out                        (ostream_val)
  );

  generate
    for ( genvar i = 0; i < noutputs; i = i + 1) begin : output_gen
      assign ostream_msg[i] = payload_msg;
    end
  endgenerate
endmodule

//  seperate inputs/outputs into stream    DONE 
//  get rid of conditional for valid bit   DONE
//  fix mux                                DONE
//  used unpacked arrays                   DONE
//  try source/stream testing   
//  get rid of harness                     DONE
//  fix test cases to not need harness     DONE

// add queue                               DONE
// stop clipping of bits                   DONE
// add to confluence