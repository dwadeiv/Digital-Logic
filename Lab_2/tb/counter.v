module counter(
    input reset_n,
    input clk,
    output reg [3:0] ones,
    output reg [3:0] tens
);

//Gives 1s for counter
always @(posedge clk or negedge reset_n)
begin
    if (reset_n == 0)
        ones <= 1;
    else if (ones != 9)
        ones <= ones + 1;
    else
        ones <= 0;
end

//Gives 10s for counter
always @(posedge clk or negedge reset_n)
begin
    if (reset_n ==  0)
        tens <= 0;
    else if (tens != 9 && ones == 9)
        tens <= tens + 1;
    else if (tens == 9 && ones == 9)
        tens <= 0;
end

endmodule