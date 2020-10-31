`timescale 1 ns / 100 ps
module tb();

reg clock, reset_n;
wire [9:0] BCD_value;
wire latch_out;

top DUT(
    .BCD_value(BCD_value),
    .latch_out(latch_out),
    .ADC_CLK_10(clock)
);
/*
always 
    #10 clock = ~clock;
*/
initial 
begin
    $dumpfile("out.vcd"); 
    $dumpvars;
    $display($time, "<< Starting Simulation >>");
    clock = 0;
    reset_n = 0;
    #50 reset_n = 1;
    #250 $display($time, "<< Simulation Complete >>");
    $finish;
end 

endmodule