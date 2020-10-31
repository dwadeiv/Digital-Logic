module fulladder(
    input a,
    input b,
    input c,
    output sum,
    output carry
);

assign sum = (a ^ b) ^ c;
assign carry = (a & b) | (c & (a ^ b));

endmodule // fulladder