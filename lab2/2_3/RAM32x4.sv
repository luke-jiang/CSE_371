module RAM32x4 (
	output logic [3:0] q,
	input logic [3:0] data,
	input logic [4:0] address,
	input logic clock, wren
);

	logic [3:0] memory_array [31:0];
	
	logic [4:0] address1;
	logic [3:0] data1;
	logic wren1;
	
	always_ff @(posedge clock) begin
		address1 <= address;
		data1 <= data;
		wren1 <= wren;
	end
	
	always_comb begin
		if (wren1) begin
			memory_array[address1] = data1;
			q = data1;
		end else begin
			q = memory_array[address1];
		end
			
	end
endmodule

module RAM32x4_testbench ();
	logic [3:0] q;
	logic [3:0] data;
	logic [4:0] address;
	logic clock, wren;
	
	RAM32x4 dut (.q, .data, .address, .clock, .wren);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
	 clock <= 0;
	 forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end	
	
	initial begin
		@(posedge clock);
		wren <= 1; data <= 4'd0; address <= 5'd0; @(posedge clock);
		wren <= 1; data <= 4'd1; address <= 5'd1; @(posedge clock);
		wren <= 0; 					 address <= 5'd0; @(posedge clock);
										 address <= 5'd1; @(posedge clock);
		@(posedge clock);
		$stop();
	end
endmodule
		