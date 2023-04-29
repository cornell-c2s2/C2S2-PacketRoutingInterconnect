`ifndef CONFIG_REG_V
`define CONFIG_REG_V
module ConfigRegVRTL
#(
  // Parameters
  parameter ADDR_SIZE    = 4,
  parameter PAYLOAD_SIZE = 8,
  parameter CONFIG_ADDR  = 4'b0000
)(
  // I/O
  input logic clk,
  input logic reset,
  input logic recv_val,
	output logic recv_rdy,
	output logic send_val,
	input logic send_rdy,
  input logic [ADDR_SIZE + PAYLOAD_SIZE:0] recv_msg,
  output logic [ADDR_SIZE + PAYLOAD_SIZE:0] send_msg
);

  // Local Variables
  logic [ADDR_SIZE - 1:0] addr;
  logic write;
  logic success;
  logic [PAYLOAD_SIZE - 1:0] payload;
  logic [ADDR_SIZE + PAYLOAD_SIZE:0] msg;


  // Register
  always @(posedge clk) begin
    if (reset) begin
      recv_rdy <= 1;
      send_val <= 0;
      msg <= '0;
    end
    else if(recv_val && recv_rdy) begin
      msg <= {addr, success, payload};
      recv_rdy <= 0;
      send_val <= 1;
    end
    else if(send_val && send_rdy) begin
      send_msg <= msg;
      recv_rdy <= 1;
      send_val <= 0;
    end
    else begin
      send_msg <= send_msg;
      recv_rdy <= recv_rdy;
      send_val <= send_val;
    end
  end

  // Control
  always @(*) begin
    if(recv_msg[ADDR_SIZE + PAYLOAD_SIZE: PAYLOAD_SIZE + 1] 
       == CONFIG_ADDR && recv_msg[PAYLOAD_SIZE]) begin
      addr = recv_msg[ADDR_SIZE + PAYLOAD_SIZE: PAYLOAD_SIZE + 1];
      success = 1'b1;
      payload = recv_msg[PAYLOAD_SIZE - 1:0]; 
    end
    else begin
      addr = '0;
      success = 1'b0;
      payload = '0; end
  end
endmodule
`endif