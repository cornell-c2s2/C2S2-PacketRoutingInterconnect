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
  //input logic recv_val,
	//output logic recv_rdy,
	//output logic send_val,
	//input logic send_rdy,
  input logic [ADDR_SIZE + PAYLOAD_SIZE:0] rec_msg,
  output logic [ADDR_SIZE + PAYLOAD_SIZE:0] send_msg
);

  // Local Variables
  logic [ADDR_SIZE - 1:0] addr;
  logic write;
  logic success;
  logic [PAYLOAD_SIZE - 1:0] payload;

  // Register
  always @(posedge clk) begin
    if (reset) begin
      //recv_rdy <= 1;
      //send_val <= 0;
      send_msg <= '0;
    end
    else begin
      send_msg <= {addr, success, payload};
      //recv_rdy <= 0;
      //send_val <= 0;
    end
  end

  // Control
  always @(*) begin
    if(rec_msg[ADDR_SIZE + PAYLOAD_SIZE: PAYLOAD_SIZE + 1] 
       == CONFIG_ADDR && rec_msg[PAYLOAD_SIZE]) begin
      addr = rec_msg[ADDR_SIZE + PAYLOAD_SIZE: PAYLOAD_SIZE + 1];
      success = 1'b1;
      payload = rec_msg[PAYLOAD_SIZE - 1:0]; 
    end
    else begin
      addr = '0;
      success = 1'b0;
      payload = '0; end
  end
endmodule
`endif