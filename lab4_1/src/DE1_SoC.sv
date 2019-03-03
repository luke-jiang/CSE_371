// CSE 371
// Lab 4 Part 1
// Jie Deng, Luke Jiang
// 21/02/2019

// Instantiant bitcounter
// display bitcounter result at HEX0
// use LEDR[9] as done signal
// use switches as input

module DE1_SoC (
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	output logic [9:0] LEDR,
	input logic [3:0] KEY,
	input logic [9:0] SW,
	input logic CLOCK_50
	);

	logic [3:0] result;
	logic done, start;

	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

	assign start = SW[9];
	assign reset = ~KEY[0];
	assign LEDR[9] = done;

	// clock divider
	// Fast clock may cause metastability issue
  logic [31:0] divided_clk;
  logic clk;
  clock_divider getCLK (
		.clock(CLOCK_50),
		.divided_clocks(divided_clk)
  );
  assign clk = divided_clk[24];

	bitcounter BC (.result, .done, .A(SW[7:0]), .clk, .reset, .start);

	seg7 result_dispay (.leds(HEX0), .bcd(result));

endmodule

module DE1_SoC_testbench ();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;

	DE1_SoC dut (.*);

	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	initial begin
			SW <= 10'b0000000000; KEY[0] <= 0; @(posedge CLOCK_50);
			KEY[0] <= 1; @(posedge CLOCK_50);
			@(posedge CLOCK_50);
			SW <= 10'b0000000111; @(posedge CLOCK_50);
			SW[9] <= 1; @(posedge CLOCK_50);
			@(posedge CLOCK_50);
			@(posedge CLOCK_50);
			@(posedge CLOCK_50);
			@(posedge CLOCK_50);
			@(posedge CLOCK_50);
			@(posedge CLOCK_50);
			$stop();
	end
endmodule
