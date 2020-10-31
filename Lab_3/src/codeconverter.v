module codeconverter(
   input [2:0] num,
   output reg [7:0] out
);

always @(num[2:0])
begin
   case (num)
      3'b000: out = ~8'b00111111; //0
      3'b001: out = ~8'b00000110; //1
      3'b010: out = ~8'b01011011; //2 
      3'b011: out = ~8'b01001111; //3 
      3'b111: out = ~8'b00000000; //off
      default: out = ~8'b00000000; 
   endcase
end

endmodule // codeconverter