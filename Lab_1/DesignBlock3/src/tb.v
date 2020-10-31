`timescale 1ns / 100 ps
module tb();

reg [9:0] SW; 
wire [9:0] LEDR; 
wire [7:0] HEX0;
wire [7:0] HEX1;
wire [7:0] HEX4;
wire [7:0] HEX5;

db3 DUT(
    .SW(SW),
    .LEDR(LEDR),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX4(HEX4),
    .HEX5(HEX5)
);

initial
begin
    $dumpfile("out.vcd"); 
    $dumpvars;
    $display($time, "<< Starting Simulation >>");
    SW = 10'b1110111011;
    #10 $display("<< Simulation ended >>");
    $finish;
end 

initial
begin
    $monitor($time, "SW=%b, LEDR=%b, HEX0=%b, HEX1=%b, HEX4=%b, HEX5=%b", SW, LEDR, HEX0, HEX1, HEX4, HEX5);
end

endmodule