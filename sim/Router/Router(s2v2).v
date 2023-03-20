
module Router 
	#(
	parameter p_nbits = 0;
	parameter p_noutputs = 0;
	)

	(
	input wire valid;
	input wire [p_noutputs - 1:0] ready;
	input wire [p_nbits - 1:0] message_in;
	output wire [p_noutputs - 1:0] valid_out;
	output wire [(p_noutputs * (p_nbits - $clog(p_noutputs))) - 1:0] message_out;
	output wire [p_noutputs - 1:0] ready_out;
	);

	wire [(p_nbits - $clog(p_noutputs)) - 1:0] cut_message;
	wire [$clog(p_noutputs) - 1:0] select;

	assign select = message_in[p_nbits - 1:p_nbits - $clog(p_noutputs)];
	assign cut_message = message_in[(p_nbits - $clog(p_noutputs)) - 1:0];

	parametricMux #(
		.p_nbits(1),
		.p_ninputs(p_noutputs)
	) mux_inst(
		.in(ready),
		.sel(select),
		.out(ready_out)
	);
	generate
		if (ready_out[select]) begin : genblk1
			parametricDemux #(
				.p_nbits(1),
				.p_noutputs(p_noutputs)
			) demux_inst(
				.in(valid),
				.sel(select),
				.out(valid_out)
			);
			assign message_out = {p_noutputs {cut_message}};
		end
	endgenerate
endmodule
