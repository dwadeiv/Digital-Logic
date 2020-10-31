module db4(
   output [9:0] LEDR,
   output [7:0] HEX0,
   output [7:0] HEX1,
   output [7:0] HEX2,
   output [7:0] HEX3,
   output [7:0] HEX4,
   output [7:0] HEX5,
   input [9:0] SW,
   input [1:0] KEY
);
//00: db1
//01: db2
//1x: db3 + switches
wire [7:0] LEDR_1, HEX0_1, HEX1_1, HEX2_1, HEX3_1, HEX4_1, HEX5_1;
db1 part1(
    .KEY(KEY),
    .SW(SW[7:0]),
    .LEDR(LEDR_1),
    .HEX0(HEX0_1),
    .HEX1(HEX1_1),
    .HEX2(HEX2_1),
    .HEX3(HEX3_1),
    .HEX4(HEX4_1),
    .HEX5(HEX5_1)
);

wire [7:0] HEX0_2, HEX1_2, HEX2_2, HEX3_2, HEX4_2, HEX5_2;
db2 part2(
    .KEY(KEY),
    .SW(SW[7:0]),
    .HEX0(HEX0_2),
    .HEX1(HEX1_2),
    .HEX2(HEX2_2),
    .HEX3(HEX3_2),
    .HEX4(HEX4_2),
    .HEX5(HEX5_2)
);

wire [7:0] LEDR_3, HEX0_3, HEX1_3, HEX4_3, HEX5_3;
db3 part3(
    .SW(SW),
    .LEDR(LEDR_3),
    .HEX0(HEX0_3),
    .HEX1(HEX1_3),
    .HEX4(HEX4_3),
    .HEX5(HEX5_3)
);
//00: db1
//01: db2
//1x: db3 + switches

assign LEDR = (SW[9:8] == 2'b00) ? LEDR_1 : (SW[9] == 1) ? LEDR_3 : 0;
assign HEX0 = (SW[9:8] == 2'b00) ? HEX0_1 : (SW[9:8] == 2'b01) ? HEX0_2 : (SW[9] == 1) ? HEX0_3 : 0;
assign HEX1 = (SW[9:8] == 2'b00) ? HEX1_1 : (SW[9:8] == 2'b01) ? HEX1_2 : (SW[9] == 1) ? HEX1_3 : 8'b11111111;
assign HEX2 = (SW[9:8] == 2'b00) ? HEX2_1 : (SW[9:8] == 2'b01) ? HEX2_2 : 8'b11111111;
assign HEX3 = (SW[9:8] == 2'b00) ? HEX3_1 : (SW[9:8] == 2'b01) ? HEX3_2 : 8'b11111111;
assign HEX4 = (SW[9:8] == 2'b00) ? HEX4_1 : (SW[9:8] == 2'b01) ? HEX4_2 : (SW[9] == 1) ? HEX4_3 : 8'b11111111;
assign HEX5 = (SW[9:8] == 2'b00) ? HEX5_1 : (SW[9:8] == 2'b01) ? HEX5_2 : (SW[9] == 1) ? HEX5_3 : 8'b11111111;



endmodule // db4