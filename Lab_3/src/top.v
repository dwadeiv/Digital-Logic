module top(
    input [1:0] KEY,
    input [9:0] SW, 
    input ADC_CLK_10,
    output [9:0] LEDR,
    output [7:0] HEX0
);

parameter Idle = 3'b000;
parameter Hazard = 3'b001;
parameter Left = 3'b010;
parameter Right = 3'b011;

wire clk;
wire mem_clk;
clock_divider c(
    .clk(ADC_CLK_10),
    .reset_n(KEY[0]),
    .slw_clk_1(clk),
    .slw_clk_2(mem_clk)
);

reg [1:0] mem_counter;
always @(posedge mem_clk)
    mem_counter <= mem_counter + 1;

wire [7:0] mem;
m9k mem1({6'b0, mem_counter},mem_clk,mem);
wire hazard_mem_input = mem[0];
wire turn_signal_mem_input = mem[1];
wire side_mem_input = mem[2];

wire hazard_input;
wire turn_signal_input;
wire side_input;

assign hazard_input = SW[9] ? hazard_mem_input : SW[0];
assign turn_signal_input = SW[9] ? turn_signal_mem_input : SW[1];
assign side_input = SW[9] ? side_mem_input : KEY[1];


reg [2:0] next_state;
always @(current_state)
    begin
        case (current_state)
            Idle: 
            begin
                if (hazard_input == 1)
                    next_state = Hazard;
                else if ((turn_signal_input == 1) && (side_input == 1))
                    next_state = Left;
                else if ((turn_signal_input == 1) && (side_input == 0))
                    next_state = Right;
                else
                    next_state = Idle;
            end
            Hazard:
            begin
                if (hazard_input == 0)
                    next_state = Idle;
                else
                    next_state = Hazard;
            end
            Left:
            begin
                if (hazard_input == 1)
                    next_state = Hazard;
                else if ((turn_signal_input == 1) && (side_input == 1))
                    next_state = Left;
                else
                    next_state = Idle;
            end
            Right:
            begin
                if (hazard_input == 1)
                    next_state = Hazard;
                else if ((turn_signal_input== 1) && (side_input == 0))
                    next_state = Right;
                else 
                    next_state = Idle;
            end
        endcase
    end

reg [2:0] current_state;
always @(posedge clk or negedge KEY[0])
    if (KEY[0] == 0)
        current_state = Idle;
    else
        current_state = next_state;


reg [1:0] Q;
always @(posedge clk)
begin
    if (current_state == Idle)
        Q <= 0;
    else if (Q != 3)
        Q <= Q + 1;
    else
        Q <= 0;
end

reg [2:0] left_LED;
reg [2:0] right_LED;
assign LEDR[9:7] = left_LED;
assign LEDR[2:0] = right_LED;
always @(posedge clk or negedge KEY[0])
    begin
        case (current_state)
            Idle:
            begin
                left_LED = 0;
                right_LED = 0;
            end
            Hazard:
            begin
                left_LED = {Q[0],Q[0],Q[0]};
                right_LED = {Q[0],Q[0],Q[0]};
            end
            Left:
            begin
                right_LED = 3'b000;
                case (Q)
                    0: left_LED = 3'b000;
                    1: left_LED[0] = 3'b001;
                    2: left_LED[2:0] = 3'b011;
                    3: left_LED[2:0] = 3'b111;
                endcase
            end
            Right:
            begin
                left_LED = 3'b000;
                case (Q)
                    0: right_LED = 3'b000;
                    1: right_LED[2] = 3'b001;
                    2: right_LED[2:0] = 3'b110;
                    3: right_LED[2:0] = 3'b111;
                endcase
            end
        endcase
    end

codeconverter h0(
    .num(current_state),
    .out(HEX0)
);

endmodule 