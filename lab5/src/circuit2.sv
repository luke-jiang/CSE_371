// CSE 371
// Lab 5 Part 2
// Jie Deng, Luke Jiang
// 28/02/2019

// Implement task 2 filter.


module circuit2 (
	input logic read_ready, write_ready,
	input logic [23:0] readdata_left, readdata_right,
	input logic clk,

	output logic read, write,
	output logic [23:0] writedata_left, writedata_right
	);

	logic signed[23:0] data_left, data_right;
	logic signed[23:0] data_left1, data_right1;
	logic signed[23:0] data_left2, data_right2;
	logic signed[23:0] data_left3, data_right3;
	logic signed[23:0] data_left4, data_right4;
	logic signed[23:0] data_left5, data_right5;
	logic signed[23:0] data_left6, data_right6;
	logic signed[23:0] data_left7, data_right7;

	always_ff @(posedge clk) begin
		if (read_ready) begin
			data_left <= readdata_left;
			data_right <= readdata_right;
			read <= 1;
		end

		if (read)
			read <= 0;

		if (write_ready) begin
			writedata_left <= (data_left >>> 3) + (data_left1 >>> 3) +
					(data_left2 >>> 3) +(data_left3 >>> 3) +(data_left4 >>> 3) +
					(data_left5 >>> 3) +(data_left6 >>> 3) +(data_left7 >>> 3);
			writedata_right <= (data_right >>> 3) + (data_right1 >>> 3) +
					(data_right2 >>> 3) +(data_right3 >>> 3) +(data_right4 >>> 3) +
					(data_right5 >>> 3) +(data_right6 >>> 3) +(data_right7 >>> 3);
			write <= 1;
		end

		if (write)
			write <= 0;
	end

	always_ff @(posedge clk) begin
		data_left1 <= data_left;
		data_right1 <= data_right;

		data_left2 <= data_left1;
		data_right2 <= data_right1;

		data_left3 <= data_left2;
		data_right3 <= data_right2;

		data_left4 <= data_left3;
		data_right4 <= data_right3;

		data_left5 <= data_left4;
		data_right5 <=data_right4;

		data_left6 <= data_left5;
		data_right6 <= data_right5;

		data_left7 <= data_left6;
		data_right7 <= data_right6;
	end

endmodule

module circuit2_testbench ();
	logic read_ready, write_ready;
	logic [23:0] readdata_left, readdata_right;
	logic clk;

	logic read, write;
	logic [23:0] writedata_left, writedata_right;

	circuit2 dut (.*);

	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		read_ready <= 1; readdata_left <= 24'd0; readdata_right <= 24'd1; @(posedge clk);
		read_ready <= 0; @(posedge clk);
		@(posedge clk);
		write_ready <= 1; @(posedge clk);
		write_ready <= 0; @(posedge clk);
		@(posedge clk);

		$stop();
	end
endmodule
