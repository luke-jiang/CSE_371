// CSE 371
// Lab 4 Part 2
// Jie Deng, Luke Jiang
// 21/02/2019

// instantiate searcher. Set up connections for display signals.

module DE1_SoC (
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	output logic [9:0] LEDR,
	input logic [3:0] KEY,
	input logic [9:0] SW,
	input logic CLOCK_50
	);

	logic found, done;
	logic [4:0] addr;
	logic [7:0] target;

	logic clk, reset, start;

	assign target = SW[7:0];
	assign start = SW[9];
	assign reset = ~KEY[0];
	assign clk = CLOCK_50;

	assign LEDR[9] = found;

	logic [3:0] b0, b1;
	assign b0 = addr % 5'd16;
	assign b1 = addr / 5'd16;

	seg7 bit0 (HEX0, b0);
	seg7 bit1 (HEX1, b1);
	searcher Searcher (.*);
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

	end
endmodule
