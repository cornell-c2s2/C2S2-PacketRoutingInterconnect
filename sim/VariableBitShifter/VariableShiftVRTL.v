module VariableShiftVRTL(
    input   logic [31:0]    data_in,
    input   logic [4:0]     shift_amt,
    output  logic [31:0]    data_out
);

    always begin
        data_out = data_in >> shift_amt;
    end

endmodule