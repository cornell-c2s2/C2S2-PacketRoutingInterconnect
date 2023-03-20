`ifndef PROJECT_CROSSBAR_V
`define PROJECT_CROSSBAR_V

`include "muxes.v"

//Crossbar in Verilog

module crossbarVRTL(
    #(
        parameter BIT_WIDTH = 32, 
        parameter N_INPUTS = 2,
        parameter N_OUTPUTS = 2,
        parameter CONTROL_BIT_WIDTH = 42
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

        input  logic [CONTROL_BIT_WIDTH - 1:0]      control          ,
        input  logic                   control_val               ,
        output logic                   control_rdy               ,
    );

    logic [CONTROL_BIT_WIDTH - 1:0] stored_control;

    always @(*) begin
        if ( control_val ) begin
            stored_control = control;
            control_rdy = control_val;
        end
    end

    logic [$clog2(N_INPUTS) - 1:0] muxsel = stored_control[41 : 42-$clog2(N_INPUTS)];
    logic [$clog2(N_OUTPUTS) - 1:0] decsel = stored_control[42-$clog2(N_INPUTS) : 42-$clog2(N_INPUTS)-$clog2(N_OUTPUTS)];


    always @(*) begin
        for (int i = 0; i < N_OUTPUTS; i++) begin
            if ( i == decsel ) begin
                send_msg[i] = recv_msg[muxsel];
                send_val[i] = recv_val[muxsel];
            end
            else begin
                send_msg[i] = 0;
                send_val[i] = 0;
            end
        end

        for (int j = 0; i < N_INPUTS; j++) begin
            if (j == muxsel) begin
                recv_rdy[j] = send_rdy[decsel]; 
            end
            else begin
                recv_rdy[j] = 0;
            end
        end
    end

endmodule

`endif