module VariableShiftVRTL
#(
  // Parameters
  parameter ADDR_SIZE    = 4,
  parameter PAYLOAD_SIZE = 8,
  parameter CONFIG_ADDR  = 4'b0000
)(
    input                                         clk;
    input                                         reset;
    input   logic [ADDR_SIZE + PAYLOAD_SIZE:0]    queue_out_msg,
    input   logic [4:0]                           ctrl,
    output  logic [ADDR_SIZE + PAYLOAD_SIZE:0]    send_msg
);

    always (@posedge clk) begin
        send_msg = queue_out_msg << ctrl;
    end

endmodule
