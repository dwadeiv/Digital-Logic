// Correspond the day number of the year with the date
// Range is from 1 - 99 (January 1 - April 9)
// Extra credit for including leap year

module top(
    input [1:0] KEY, 
    input ADC_CLK_10,
    output [1:0] LEDR,
    output [7:0] HEX0,
    output [7:0] HEX1,
    output [7:0] HEX2,
    output [7:0] HEX4,
    output [7:0] HEX5,
    output latch_out,
    output clk,
    output [9:0] BCD_value
);

reg latch_out = 0;
/*
always @ (negedge KEY[0])
    latch_out <= ~latch_out;
*/

wire clk;
wire clk_1;
wire clk_2;
clock_divider c(
    .clk(ADC_CLK_10),
    .reset_n(latch_out),
    .slw_clk_1(clk)
    //.slw_clk_2(clk_2)
);

/*
eg freq_sel;
assign clk = freq_sel ? clk_1 : clk_2;
always @(negedge KEY[1])
    freq_sel <= ~freq_sel;
*/

assign LEDR[1] = clk;
wire [3:0] tens_data;
wire [3:0] ones_data;
counter cnt(
    .reset_n(latch_out),
    .clk(clk),
    .ones(ones_data),
    .tens(tens_data)
);

wire [9:0] BCD_value;
assign BCD_value[9:5] = tens_data ? tens_data : 5'b11111;
assign BCD_value[4:0] = ones_data;
wire [6:0] doy_binary_value;
assign doy_binary_value = (tens_data*10) + ({3'b0,ones_data});
//assign LEDR[9:3] = doy_binary_value;
reg [4:0] month_value;
reg [4:0] dom;

always @(doy_binary_value)
    if (doy_binary_value <= 31)
    begin
        month_value = 1;
        dom = doy_binary_value;
    end

    else if (doy_binary_value <= 59)
    begin
        month_value = 2;
        dom = doy_binary_value - 31;
    end

    else if (doy_binary_value <= 90)
    begin
        month_value = 3;
        dom = doy_binary_value - 59;
    end

    else
    begin
        month_value = 4;
        dom = doy_binary_value - 90;
    end

reg [4:0] dom_tens;
reg [4:0] dom_ones;

always @(dom)
    if (dom <= 9)
    begin
        dom_tens = 31;
        dom_ones = dom;
    end

    else if (dom <= 19)
    begin
        dom_tens = 1;
        dom_ones = dom - 10;
    end

    else if (dom <= 29)
    begin
        dom_tens = 2;
        dom_ones = dom - 20;
    end

    else
    begin
        dom_tens = 3;
        dom_ones = dom - 30;
    end

codeconverter h0(
    .num(dom_ones[4:0]),
    .out(HEX0)
);
    
codeconverter h1(
    .num(dom_tens[4:0]),
    .out(HEX1)
);

codeconverter h2(
    .num(month_value[4:0]),
    .out(HEX2)
);

codeconverter h4(
    .num(BCD_value[4:0]),
    .out(HEX4)
);

codeconverter h5(
    .num(BCD_value[9:5]),
    .out(HEX5)
);

endmodule




    







