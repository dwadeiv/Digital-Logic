module db2(
    input [1:0] KEY,
    input [7:0] SW, 
    output [7:0] HEX0,
    output [7:0] HEX1,
    output [7:0] HEX2,
    output [7:0] HEX3,
    output [7:0] HEX4,
    output [7:0] HEX5
);
//hex4 = abs(in1)
//hex5 = sign of in1
//hex2 = abs(in2)
//hex3 = sign of in2
//hex0 = abs(in1+in2)
//hex1 = sign of in1+in2 
//if overflow hex1 = 0 hex0 = F 

wire signed [3:0] input1, input2;
reg signed [4:0] absInput1, absInput2;

assign input1 = SW[7:4];
assign input2 = SW[3:0];

always @(absInput1, absInput2)
begin
    case ((input1 >> 3) & 1)
        1:  absInput1 = ~input1 + 1; //takes twos compelemnt
        default:    absInput1 = input1; 
    endcase

    case ((input2 >> 3) & 1)
        1:  absInput2 = ~input2 + 1;
        default:    absInput2 = input2;
    endcase
end

wire [4:0] h5neg;
assign h5neg = ((input1 >> 3) & 1) ? 16 : 17;

codeconverter h5(
    .num(h5neg),
    .out(HEX5)
);

codeconverter h4(
    .num(absInput1),
    .out(HEX4)
);

wire [4:0] h3neg;
assign h3neg = ((input2 >> 3) & 1) ? 16 : 17;

codeconverter h3(
    .num(h3neg),
    .out(HEX3)
);

codeconverter h2(
    .num(absInput2),
    .out(HEX2)
);

wire signed [3:0] ans;
wire overflow;
rippleadder r(
    .sub(KEY[0]),
    .a(input1),
    .b(input2),
    .sum(ans),
    .overflow(overflow)
);

reg [3:0] absAns;
always @(ans[3:0])
begin
    case (ans[3])
        1: absAns = ~ans + 1;  
        default: absAns = ans; 
    endcase
end

wire [4:0] ansDigit1, ansDigit2;
assign ansDigit1 = (overflow) ? 0 : (ans[3]) ? 16 : 17;
assign ansDigit2 = (overflow) ? 18 : absAns;

codeconverter h1(
    .num(ansDigit1),
    .out(HEX1)
);

codeconverter h0(
    .num(ansDigit2),
    .out(HEX0)
);
endmodule // db2