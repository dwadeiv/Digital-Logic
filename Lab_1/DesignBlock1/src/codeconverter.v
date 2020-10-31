module codeconverter(
   input [4:0] num,
   output reg [7:0] out
);

always @(num[4:0])
begin
   case (num)
      8'b0001: out = ~8'b00000110; 
      8'b0010: out = ~8'b01011011; 
      8'b0011: out = ~8'b01001111; 
      8'b0100: out = ~8'b01100110; 
      8'b0101: out = ~8'b01101101; 
      8'b0110: out = ~8'b01111101; 
      8'b0111: out = ~8'b00000111; 
      8'b1000: out = ~8'b01111111; 
      8'b1001: out = ~8'b01100111; 
      default: out = ~8'b00111111; 
   endcase
end

endmodule // codeconverter