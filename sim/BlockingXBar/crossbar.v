`ifndef PROJECT_CROSSBAR_V
`define PROJECT_CROSSBAR_V

`include "muxes.v"

//Crossbar in Verilog

module crossbarVRTL(
    #(
        parameter BIT_WIDTH = 32, 
        parameter N_INPUTS = 2,
        parameter N_OUTPUTS = 2
    )

    (
        input  logic [BIT_WIDTH - 1:0] recv_msg [N_INPUTS - 1:0] ,
        input  logic                   recv_val [N_INPUTS - 1:0] ,
        output logic                   recv_rdy [N_INPUTS - 1:0] ,

        output logic [BIT_WIDTH - 1:0] send_msg [N_OUTPUTS - 1:0],
        output logic                   send_val [N_OUTPUTS - 1:0],
        input  logic                   send_rdy [N_OUTPUTS - 1:0],

        input  logic                   reset                     ,
        input  logic                   clk                       ,

        input  logic [41:0]            control                   ,

        input  logic [BIT_WIDTH - 1:0] in       [N_INPUTS - 1:0] ,
        output logic [BIT_WIDTH - 1:0] out      [N_OUTPUTS - 1:0],
    );

    logic [$clog2(N_INPUTS) - 1:0] muxsel = control[41 : 42-$clog2(N_INPUTS)];
    logic [$clog2(N_OUTPUTS) - 1:0] decsel = control[42-$clog2(N_INPUTS) : 42-$clog2(N_INPUTS)-$clog2(N_OUTPUTS)];

    logic [BIT_WIDTH - 1:0] mid; 

    always @(*) begin
        for (int i = 0; i < N_OUTPUTS; i++) begin
            out[i] = 0;
        end
    end

    vc_MuxN #(N_INPUTS) input_mux (.in(in), .sel(muxsel), .out(out[decsel]));

    vc_MuxN #(N_INPUTS) valid_mux (.in(recv_rdy), .sel(muxsel), .out(send_val[decsel]));

endmodule

`endif