`include "ConfigRegVRTL.v"

// iverilog -g2012 -o ConfigRegVRTLTest ConfigRegVRTLTest.v

module top;

  parameter ADDR_SIZE = 4;
  parameter PAYLOAD_SIZE = 8;

  logic clk = 1;
  always #5 clk = ~clk;

  logic reset;
  logic [ADDR_SIZE + PAYLOAD_SIZE:0] recv_msg;
  logic [ADDR_SIZE + PAYLOAD_SIZE:0] send_msg;

  ConfigRegVRTL #(.ADDR_SIZE(ADDR_SIZE), .PAYLOAD_SIZE(PAYLOAD_SIZE)) config_reg
  (
    .clk(clk),
    .reset(reset),
    .recv_val(1'b1),
    .send_rdy(1'b1),
    .recv_msg(recv_msg),
    .send_msg(send_msg)
  );

  initial begin
    $dumpfile("ConfigRegVRTLTest.vcd");
    $dumpvars;
  
  reset = 1'b1;
  recv_msg = 13'b0000111111111;
  #11;      
  $display( "TEST 1 (reset): recv_msg = %b,  send_msg= %b"
  , recv_msg, send_msg);
  $display("");

  reset = 1'b0;
  recv_msg = 13'b0000101010101;
  #10;
  $display( "TEST 2 (addr matches, write): recv_msg = %b,  send_msg= %b"
  , recv_msg, send_msg);
  $display("");

  reset = 1'b0;
  recv_msg = 13'b0000001010101;
  #10;
  $display( "TEST 3 (addr matches, no write): recv_msg = %b,  send_msg= %b"
  , recv_msg, send_msg);
  $display("");  

  reset = 1'b0;
  recv_msg = 13'b0101101010101;
  #10;
  $display( "TEST 4 (addr doesn't match, write): recv_msg = %b,  send_msg= %b"
  , recv_msg, send_msg);
  $display("");

  
  reset = 1'b0;
  recv_msg = 13'b0101001010101;
  #10;
  $display( "TEST 5 (addr doesn't match, no write): recv_msg = %b,  send_msg= %b"
  , recv_msg, send_msg);
  $display("");


  recv_msg = 13'b0000101010101;
  #10;
  $display( "TEST 6 (addr matches, write): recv_msg = %b,  send_msg= %b"
  , recv_msg, send_msg);

  recv_msg = 13'b0000101010101;
  #10;
  $display( "TEST 7 (addr matches, write): recv_msg = %b,  send_msg= %b"
  , recv_msg, send_msg);


  $finish;
  end

endmodule