module clock_divider(
    input clk,
    input reset_n,
    output reg slw_clk_1,
    output reg slw_clk_2
);

reg [23:0] divider_1;
reg [23:0] divider_2;
parameter divby_1 = 10;
parameter divby_2 = 2;

always @(posedge clk or negedge reset_n)
begin
    if (reset_n == 0)
        divider_1 <= 0;
    else if (divider_1 == divby_1)
        begin
            slw_clk_1 <= ~slw_clk_1;
            divider_1 <= 0;
        end
    else
        divider_1 <= divider_1 + 1;
end

always @(posedge clk or negedge reset_n)
begin
    if (reset_n == 0)
        divider_2 <= 0;
    else if (divider_2 == divby_2)
        begin
            slw_clk_2 <= ~slw_clk_2;
            divider_2 <= 0;
        end
    else
        divider_2 <= divider_2 + 1;
end

endmodule