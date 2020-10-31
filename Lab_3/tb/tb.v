`timescale 1 ns / 100 ps
module tb();

reg clk = 0;
reg [1:0] key;
reg [9:0] sw;
wire [7:0] hex0;
wire [9:0] led;

always
    #1 clk = ~clk;


top DUT(
    .ADC_CLK_10(clk),
    .KEY(key),
    .SW(sw),
	.LEDR(led),
    .HEX0(hex0)
);

initial
begin
    $dumpfile("out.vcd");
    $dumpvars;
    $display($time, "<<starting>>");
    key = 2'b11;
    sw = 10'b0000000000;
    #500 sw[0] = 1;
    #500 sw[0] = 0;
    key[1] = 0;
    #50 key[1] = 1;
    #500 sw[1] = 1;
    #500 key[1] = 0;
    #50 key[1] = 0;
    #500 sw[1] = 1;
    #500 key[0] = 0;
    #50 key[0] = 1;
    #500 key[0] = 0;
    #50 key[0] = 1;
    #500$display("<<ending>>");
    $finish;
end

initial
begin
    $monitor($time, "clk = %b, key = %b, sw = %b, hex0 = %b, led = %b", clk, key, sw, hex0, led);
end

endmodule