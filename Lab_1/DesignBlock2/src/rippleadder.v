module rippleadder(
    input sub,
    input [3:0] a,
    input [3:0] b,
    output [3:0] sum,
    output reg overflow
);

wire carry1;
fulladder a0(
    .a(a[0]),
    .b(b[0] ^ ~sub),
    .c(~sub),
    .sum(sum[0]),
    .carry(carry1)
);

wire carry2;
fulladder a1(
    .a(a[1]),
    .b(b[1] ^ ~sub),
    .c(carry1),
    .sum(sum[1]),
    .carry(carry2)
);

wire carry3;
fulladder a2(
    .a(a[2]),
    .b(b[2] ^ ~sub),
    .c(carry2),
    .sum(sum[2]),
    .carry(carry3)
);

wire carry4;
fulladder a3(
    .a(a[3]),
    .b(b[3] ^ ~sub),
    .c(carry3),
    .sum(sum[3]),
    .carry(carry4)
);

always @(a[3:0], b[3:0], sum[3:0])
begin
    case (sub)
        // 1:  overflow = (a[3] & b[3] & ~sum[3]) ? 1 : 0; 
        // default:    overflow = ((a[3] ^ b[3]) & ~(b[3] ^ sum[3])) ? 1 : 0;
        1: overflow = (~(a[3] ^ b[3]) & (a[3] ^ sum[3])) ? 1 : 0;
        default: overflow = (a[3] ^ b[3]) & ~(b[3] ^ sum[3]) ? 1 : 0;
    endcase
end

endmodule // rippleadder