`timescale 1 ns / 100 ps
module tb();

reg [1:0] KEY;
reg [7:0] SW; 
wire [7:0] HEX0;
wire [7:0] HEX1;
wire [7:0] HEX2;
wire [7:0] HEX3;
wire [7:0] HEX4;
wire [7:0] HEX5;


db2 DUT(
    .KEY(KEY),    
    .SW(SW),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5)
);

initial
begin
    $dumpfile("out.vcd"); 
    $dumpvars;
    $display($time, "<< Starting Simulation >>");
    KEY = 2'b11;
    SW = 8'b00010001;
    #10 $display("<< Simulation ended >>");
    $finish;
end 

initial
begin
    $monitor($time, "KEY = %b, SW = %b, HEX0 = %b, HEX1 = %b, HEX2 = %b, HEX3 = %b, HEX4 = %b, HEX5 = %b", KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
end

endmodule