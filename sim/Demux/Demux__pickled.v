//-------------------------------------------------------------------------
// Demux.v
//-------------------------------------------------------------------------
// This file is generated by PyMTL SystemVerilog translation pass.

// PyMTL VerilogPlaceholder parametricDemuxVTRL Definition
// Full name: parametricDemuxVTRL__p_nbits_2__p_noutputs_4
// At /home/jjm469/c2s2/Router/PacketRoutingInterconnect/sim/Demux/parametricDemuxRTL.py

//***********************************************************
// Pickled source file of placeholder parametricDemuxVTRL__p_nbits_2__p_noutputs_4
//***********************************************************

//-----------------------------------------------------------
// Dependency of placeholder parametricDemuxVTRL
//-----------------------------------------------------------

`ifndef PARAMETRICDEMUXVTRL
`define PARAMETRICDEMUXVTRL

// The source code below are included because they are specified
// as the v_libs Verilog placeholder option of component parametricDemuxVTRL__p_nbits_2__p_noutputs_4.

// If you get a duplicated def error from files included below, please
// make sure they are included either through the v_libs option or the
// explicit `include statement in the Verilog source code -- if they
// appear in both then they will be included twice!


// End of all v_libs files for component parametricDemuxVTRL__p_nbits_2__p_noutputs_4

`line 1 "parametricDemuxVTRL.v" 0
module parametricDemuxVTRL
#(
  //length of message
  parameter p_nbits = 1,   
  //Number of outputs
  parameter p_noutputs = 2
)
(
  input  wire [p_nbits-1:0]                  in_val,
  input  wire [$clog2(p_noutputs)-1:0]       sel,
  output wire [p_noutputs*p_nbits-1:0]       flattened_out_val
);

  // This is the normal output, but for test, all of its values concatonated into flattened_out_val
  // For actual use of module, make this an output wire
  wire [p_noutputs-1:0][p_nbits-1:0] out_val;


  genvar i;
  generate
    for (i = 0; i < p_noutputs; i = i + 1) begin : output_gen
      assign out_val[i] = (i == sel) ? in_val : {p_nbits{1'b0}};
    end
  endgenerate

  // Concatenate output values
  // REMOVE WHEN NOT TESTING AND SET OUTPUT VALUE TO OUT_VAL
  generate
    for (genvar i = 0; i < p_noutputs; i = i + 1) begin : output_gen
      assign flattened_out_val[i*p_nbits +: p_nbits] = out_val[p_noutputs - 1 - i];
    end
  endgenerate


endmodule

`endif /* PARAMETRICDEMUXVTRL */
//-----------------------------------------------------------
// Wrapper of placeholder parametricDemuxVTRL__p_nbits_2__p_noutputs_4
//-----------------------------------------------------------

`ifndef PARAMETRICDEMUXVTRL__P_NBITS_2__P_NOUTPUTS_4
`define PARAMETRICDEMUXVTRL__P_NBITS_2__P_NOUTPUTS_4

module Demux
(
  input logic reset,
  input logic clk,
  output logic [8-1:0] flattened_out_val ,
  input logic [2-1:0] in_val ,
  input logic [2-1:0] sel 
);
  parametricDemuxVTRL
  #(
    .p_nbits( 2 ),
    .p_noutputs( 4 )
  ) v
  (
    .flattened_out_val( flattened_out_val ),
    .in_val( in_val ),
    .sel( sel )
  );
endmodule

`endif /* PARAMETRICDEMUXVTRL__P_NBITS_2__P_NOUTPUTS_4 */

