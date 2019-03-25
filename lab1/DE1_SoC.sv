// CSE 371
// Lab 1
// Luke Jiang
// 18/01/2018

// Top module of the parking lot system.

module DE1_SoC (
  // for 7seg display
  output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
  // LEDR not used
  output logic [9:0] LEDR,
  // drive 2 off-board LEDs
  output logic [35:0] GPIO_0,
  // input pushbuttons
  input logic [3:0] KEY,
  // input switches, only SW[0] is used for reset
  input logic [9:0] SW,
  input logic   CLOCK_50
  );

  logic a, b;                           // sensors as pushbutton inputs
  logic exit, enter;                    // exit and enter signals
  logic [4:0] counter_out;              // current car count
  logic [3:0] digit0, digit1;           // digits of current car count
  logic [6:0] digit0_led, digit1_led;   // seg7 output of the two digits
  logic clk, reset;

  // LEDR not used
  assign LEDR = 10'b0;

  // set up reset signal
  assign reset = SW[0];

  // set up clock divider
  // logic [31:0] clk; //???
  // parameter whichClock = 15;
  // clock_divider cdiv (.reset(), .clock(CLOCK_50), .divided_clocks(clk));
  assign clk = CLOCK_50;

  // set sensor a as key1 and sensor b as key0
  assign a = ~KEY[1];
  assign b = ~KEY[0];

  // set off-board LED by GPIO_0
  assign GPIO_0 = {34'b0, b, a};

  getMotion GETMOTION (
    .exit, .enter,
    .a, .b,
    .clk, .reset
  );

  counter25 COUNTER25 (
    .out(counter_out),
    .inc(enter), .dec(exit),
    .clk, .reset
  );

  seg7 SEG7_0 (.leds(digit0_led), .bcd(digit0));
  seg7 SEG7_1 (.leds(digit1_led), .bcd(digit1));

  always_comb begin
    digit0 = counter_out % 4'd10;
    digit1 = counter_out / 4'd10;
    if (counter_out == 5'b0) begin
      HEX5 = 7'b0000110; // e
      HEX4 = 7'b0001001; // m
      HEX3 = 7'b0001100; // p
      HEX2 = 7'b1110011; // t
      HEX1 = 7'b0010001; // y
      HEX0 = digit0_led; // 0
    end else if (counter_out < 5'd25) begin
      HEX5 = 7'b1111111;
      HEX4 = 7'b1111111;
      HEX3 = 7'b1111111;
      HEX2 = 7'b1111111;
      HEX1 = digit1_led;
      HEX0 = digit0_led;
    end else begin
      HEX5 = 7'b0001110; // f
      HEX4 = 7'b1000001; // u
      HEX3 = 7'b1000111; // l
      HEX2 = 7'b1000111; // l
      HEX1 = digit1_led;
      HEX0 = digit0_led;
    end
  end
endmodule

module clock_divider (reset, clock, divided_clocks);
	input logic clock, reset;
	output logic [31:0] divided_clocks;

	always_ff @(posedge clock) begin
		if (reset) begin
			divided_clocks <=0;
		end else begin
			divided_clocks <= divided_clocks + 1;
		end
	end
endmodule

module DE1_SoC_testbench ();
  logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  logic [9:0] LEDR;
  logic [35:0] GPIO_0;
  logic [3:0] KEY;
  logic [9:0] SW;
  logic   clk;

  DE1_SoC dut (
    .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5,
    .LEDR, .GPIO_0, .KEY, .SW, .CLOCK_50(clk)
  );

  parameter CLOCK_PERIOD = 100;
  initial begin
    clk <= 0;
    forever #(CLOCK_PERIOD/2) clk <= ~clk;
  end

  integer i;
  initial begin
    // reset
    SW[0] <= 1; @(posedge clk);
    SW[0] <= 0; @(posedge clk);
    // initially both sensor is off
    KEY[1] <= 1; KEY[0] <= 1; @(posedge clk);
    // input entering sensor pattern 26 times
    for (i = 1; i <= 26; i++) begin
      KEY[1] <= 0; @(posedge clk);
      KEY[0] <= 0; @(posedge clk);
      KEY[1] <= 1; @(posedge clk);
      KEY[0] <= 1; @(posedge clk);
    end
    @(posedge clk);
    $stop();
  end
endmodule
