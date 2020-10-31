module db3(
   input [9:0] SW,
   output [9:0] LEDR,
   output [7:0] HEX0,
   output [7:0] HEX1,
   output [7:0] HEX4,
   output [7:0] HEX5
);
//sw 7-4: input 1
//sw 3-0: input 2
//sw 9-8: 10 = unsigned 11 = signed
//led2 when equal
//led1 when in1 > in2
//Led0 when in1 < in2
//hex5 and 4 for in2
//hex1 and 0 for in1
wire [3:0] input1, input2;
assign input1 = SW[7:4];
assign input2 = SW[3:0];

wire isTwos;
assign isTwos = (SW[9:8] == 2'b11) ? 1 : 0;

wire [4:0] in1Sign, in2Sign;
assign in1Sign = (isTwos & input1[3]) ? 16 : 17;
assign in2Sign = (isTwos & input2[3]) ? 16 : 17;

codeconverter h5(
    .num(in1Sign),
    .out(HEX5)
);

codeconverter h1(
    .num(in2Sign),
    .out(HEX1)
);

wire signed [4:0] sIn1, sIn2;
assign sIn1 = (isTwos & input1[3]) ? ~(input1 | 5'b10000) + 1 : input1;
assign sIn2 = (isTwos & input2[3]) ? ~(input2 | 5'b10000) + 1 : input2;
codeconverter h4(
    .num(sIn1),
    .out(HEX4)
);

codeconverter h0(
    .num(sIn2),
    .out(HEX0)
);

//led2 when equal
//led1 when in1 > in2
//Led0 when in1 < in2

assign LEDR[0] = ((isTwos & (sIn2 > sIn1)) | ~isTwos & (input2 > input1)) ? 1:0;
assign LEDR[1] = (sIn2 == sIn1) ? 1:0;
assign LEDR[2] = ((isTwos & (sIn2 < sIn1)) | ~isTwos & (input2 < input1)) ? 1:0;

endmodule //db3