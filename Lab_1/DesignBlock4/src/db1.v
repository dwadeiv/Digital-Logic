module db1(
   output [7:0] LEDR,
   output [7:0] HEX0,
   output [7:0] HEX1,
   output [7:0] HEX2,
   output [7:0] HEX3,
   output [7:0] HEX4,
   output [7:0] HEX5,
   input [7:0] SW,
   input [1:0] KEY
);
    assign LEDR[0] = SW[0];
    assign LEDR[1] = SW[1];
    assign LEDR[2] = SW[2];
    assign LEDR[3] = SW[3];
    assign LEDR[4] = SW[4];
    assign LEDR[5] = SW[5];
    assign LEDR[6] = SW[6];
    assign LEDR[7] = SW[7];

    //kylebirthday = {1, 1, 0, 3, 9, 9};
    //davidbirthday = {1, 0, 1, 7, 9, 8};

    wire [4:0] w0, w1, w2, w3, w4, w5;

    assign w5 = KEY[1] ? 1 : 1;
    assign w4 = KEY[1] ? 1 : 0;
    assign w3 = KEY[1] ? 0 : 1;
    assign w2 = KEY[1] ? 3 : 7;
    assign w1 = KEY[1] ? 9 : 9;
    assign w0 = KEY[1] ? 9 : 8;

    codeconverter h0(
        .num(w0),
        .out(HEX0)
    );
        
    codeconverter h1(
        .num(w1),
        .out(HEX1)
    );

    codeconverter h2(
        .num(w2),
        .out(HEX2)
    );

    codeconverter h3(
        .num(w3),
        .out(HEX3)
    );

    codeconverter h4(
        .num(w4),
        .out(HEX4)
    );

    codeconverter h5(
        .num(w5),
        .out(HEX5)
    );
endmodule // dboutput [9:0] LEDR1