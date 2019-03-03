
`timescale 1 ps / 1 ps
module DE1_SoC (
  output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
  output logic [9:0] LEDR,
  input logic [3:0] KEY,
  input logic [9:0] SW,
  input logic   CLOCK_50
  );
  
  logic [4:0] address;
  logic [3:0] data, q;
  logic wren;
  
  assign  LEDR[3:0] = q;			// output of ram
  assign address = SW[4:0];
  assign data = SW[8:5];			// input data
  assign wren = SW[9];				// write enable
  
  ram32x4 RAM (
   .q,
	.address,
	.clock(CLOCK_50),
	.data,
	.wren
  ); 
endmodule


module DE1_SoC_testbench ();
  logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  logic [9:0] LEDR;
  logic [3:0] KEY;
  logic [9:0] SW;
  logic   clk;

  DE1_SoC dut (
    .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5,
    .LEDR, .KEY, .SW, .CLOCK_50(clk)
  );

  parameter CLOCK_PERIOD = 100;
  initial begin
    clk <= 0;
    forever #(CLOCK_PERIOD/2) clk <= ~clk;
  end

  integer i;
  initial begin
	// format: [wren_data_addr]
	 @(posedge clk);
	 SW <= 10'b1_0000_00000; @(posedge clk);
	 SW <= 10'b1_1111_00010; @(posedge clk);
	 SW <= 10'b0_0000_00001; @(posedge clk);
	 @(posedge clk);
	 @(posedge clk);
	 $stop();

  end
endmodule