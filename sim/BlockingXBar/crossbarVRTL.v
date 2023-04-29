`ifndef PROJECT_CROSSBAR_V
`define PROJECT_CROSSBAR_V

//Crossbar in Verilog

module crossbarVRTL
    #(
        parameter BIT_WIDTH = 32, 
        parameter N_INPUTS = 2,
        parameter N_OUTPUTS = 2,
        parameter CONTROL_BIT_WIDTH = 42,
        parameter ADDRESS_BIT_WIDTH = 4,
        parameter BLOCK_ADDRESS = 2,
        parameter WRITE_BIT_WIDTH = 1
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

        input  logic [CONTROL_BIT_WIDTH - 1:0]      in_control   ,
        input  logic                                control_val  ,
        output logic                                control_rdy  ,
        output logic [CONTROL_BIT_WIDTH - 1:0]      out_control
    );

    logic [CONTROL_BIT_WIDTH - 1:0] stored_control;
    logic [$clog2(N_INPUTS)  - 1:0] input_sel;
    logic [$clog2(N_OUTPUTS) - 1:0] output_sel;
    logic [ADDRESS_BIT_WIDTH - 1:0] block_sel;
    logic [WRITEBACK_BIT_WIDTH - 1:0] write;
    logic [BIT_WIDTH - 1:0] queue_out [N_INPUTS - 1:0];
    logic queue_send_val [N_INPUTS - 1:0];

    assign input_sel = stored_control[CONTROL_BIT_WIDTH-ADDRESS_BIT_WIDTH-WRITE_BIT_WIDTH-1 : CONTROL_BIT_WIDTH-ADDRESS_BIT_WIDTH-WRITE_BIT_WIDTH-$clog2(N_INPUTS)];
    assign output_sel = stored_control[CONTROL_BIT_WIDTH-ADDRESS_BIT_WIDTH-WRITE_BIT_WIDTH-$clog2(N_INPUTS) : CONTROL_BIT_WIDTH-ADDRESS_BIT_WIDTH-WRITE_BIT_WIDTH-$clog2(N_INPUTS)-$clog2(N_OUTPUTS)];
    assign block_sel = stored_control[CONTROL_BIT_WIDTH-1 : CONTROL_BIT_WIDTH-ADDRESS_BIT_WIDTH]
    assign write = stored_control[CONTROL_BIT_WIDTH-ADDRESS_BIT_WIDTH : CONTROL_BIT_WIDTH-ADDRESS_BIT_WIDTH-WRITE_BIT_WIDTH]

    genvar i;
    generate
        for (i = 0; i < N_INPUTS; i = i+1) begin
            vc_Queue #(
                .p_msg_nbits(BIT_WIDTH), 
                .p_num_msgs(1)
            ) queue_inst (
                .clk(clk),
                .reset(reset),
                .recv_val(recv_val[i]),
                .recv_rdy(recv_rdy[i]),
                .recv_msg(recv_msg[i]),
                .send_val(queue_send_val[i]),
                .send_rdy(1),
                .send_msg(queue_out[i]),
                .num_free_entries()
            );
        end
    endgenerate


    always @(posedge clk) begin

        if ( reset ) begin
            stored_control <= 0;
        end
        else if ( control_val && write) begin
            stored_control <= in_control;
        end
        
        if (block_sel == BLOCK_ADDRESS) begin
            out_control <= in_control;
        end
        else begin
            out_control <= 0;
        end
        
    end

    always @(*) begin

        for (integer i = 0; i < N_OUTPUTS; i = i+1) begin
            if ( (i == output_sel) && (queue_send_val[input_sel] == 1)) begin
                send_msg[i] = queue_out[input_sel];
                send_val[i] = 1;
            end
            else begin
                send_msg[i] = 0;
                send_val[i] = 0;
            end
        end

    end

    assign control_rdy = 1; // WHAT TO DO WITH CONTROL READY ???


endmodule

`endif