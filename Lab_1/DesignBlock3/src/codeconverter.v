module codeconverter(
   input [4:0] num,
   output reg [7:0] out
);

always @(num[4:0])
begin
   case (num)
      5'b00000: out = ~8'b00111111; //0
      5'b00001: out = ~8'b00000110; //1
      5'b00010: out = ~8'b01011011; //2 
      5'b00011: out = ~8'b01001111; //3 
      5'b00100: out = ~8'b01100110; //4
      5'b00101: out = ~8'b01101101; //5
      5'b00110: out = ~8'b01111101; //6
      5'b00111: out = ~8'b00000111; //7
      5'b01000: out = ~8'b01111111; //8
      5'b01001: out = ~8'b01100111; //9
      5'b10000: out = ~8'b01000000; //-
      5'b10001: out = ~8'b00000000; //off
      5'b10010: out = ~8'b01110001; //F
      default: out = ~8'b00000000; 
   endcase
end

endmodule // codeconverter