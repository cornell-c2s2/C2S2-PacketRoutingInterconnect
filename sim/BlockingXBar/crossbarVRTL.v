`ifndef PROJECT_CROSSBAR_V
`define PROJECT_CROSSBAR_V

//Crossbar in Verilog

module crossbarVRTL
    #(
        parameter BIT_WIDTH = 32, 
        parameter N_INPUTS = 2,
        parameter N_OUTPUTS = 2,
        parameter CONTROL_BIT_WIDTH = 42
    )
    (
        input  logic [BIT_WIDTH - 1:0] recv_msg [0:N_INPUTS - 1] ,
        input  logic                   recv_val [0:N_INPUTS - 1] ,
        output logic                   recv_rdy [0:N_INPUTS - 1] ,

        output logic [BIT_WIDTH - 1:0] send_msg [0:N_OUTPUTS - 1],
        output logic                   send_val [0:N_OUTPUTS - 1],
        input  logic                   send_rdy [0:N_OUTPUTS - 1],

        input  logic                   reset                     ,
        input  logic                   clk                       ,

        input  logic [CONTROL_BIT_WIDTH - 1:0]      control      ,
        input  logic                   control_val               ,
        output logic                   control_rdy               
    );

    logic [CONTROL_BIT_WIDTH - 1:0] stored_control;

    always @(posedge clk) begin

        if ( reset ) begin
            stored_control <= 0;
        end
        else if ( control_val ) begin
            stored_control <= control;
        end
    end

    assign control_rdy = 1;

    logic [$clog2(N_INPUTS)  - 1:0] input_sel;
    logic [N_OUTPUTS - 1:0] output_sel;

    assign input_sel = stored_control[CONTROL_BIT_WIDTH - 1: CONTROL_BIT_WIDTH-$clog2(N_INPUTS)];

    assign output_sel = stored_control[CONTROL_BIT_WIDTH - $clog2(N_INPUTS) : CONTROL_BIT_WIDTH-$clog2(N_INPUTS)-$clog2(N_OUTPUTS)];

    always @(*) begin
        for (integer i = 0; i < N_OUTPUTS; i = i+1) begin
            if ( (i == output_sel)) begin
                send_msg[i] = recv_msg[input_sel];
                send_val[i] = recv_val[input_sel];
            end
            else begin
                send_msg[i] = 0;
                send_val[i] = 0;
            end
        end

        for (integer j = 0; j < N_INPUTS; j = j+1) begin
            if (j == input_sel) begin
                recv_rdy[j] = send_rdy[output_sel]; 
            end
            else begin
                recv_rdy[j] = 0;
            end
        end
    end
    
endmodule

`endif