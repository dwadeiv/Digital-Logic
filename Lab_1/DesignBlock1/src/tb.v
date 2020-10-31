`timescale 1 ns / 100 ps
module tb();

// reg [1:0] KEY;
// reg [7:0] SW; 
// wire [9:0] LEDR; 
// wire [7:0] HEX0;
// wire [7:0] HEX1;
// wire [7:0] HEX2;
// wire [7:0] HEX3;
// wire [7:0] HEX4;
// wire [7:0] HEX5;
reg KEY0, KEY1;

initial
begin
    $dumpfile("out.vcd"); 
    $dumpvars;
    $display($time, "<< Starting Simulation >>");
    KEY0 = 1;
    KEY1 = 1;
    #10 KEY0 = 0;
    #20 KEY1 = 0;
    #10 $display("<< Simulation ended >>");
    $finish;
end 

initial
begin
    $monitor($time, "KEY0 = %b, KEY1 = %b", KEY0, KEY1);
end

endmodule