
`timescale 1 ps / 1 ps
module DE1_SoC (
  output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
  output logic [9:0] LEDR,
  input logic [3:0] KEY,
  input logic [9:0] SW
  );
  
  logic [4:0] address;
  logic [3:0] data, q;
  logic wren;
  
  assign wren = SW[9];				// write enable
  assign address = SW[8:4];
  assign data = SW[3:0];			// input data
			
  assign HEX1 = 7'b1111111;
  assign HEX3 = 7'b1111111;
  
  RAM32x4 RAM (
   .q,
	.address,
	.clock(KEY[0]),
	.data,
	.wren
  );
 
	logic [3:0] address_0, address_10;
	assign address_0 = address % 4'd10;
	assign address_10 = address / 4'd10;
	
	seg7 ADDR10 (.leds(HEX5), .bcd(address_10));
	seg7 ADDR0 (.leds(HEX4), .bcd(address_0));
	seg7 DATA (.leds(HEX2), .bcd(data));
	seg7 DOUT (.leds(HEX0), .bcd(q));
	
endmodule


module DE1_SoC_testbench ();
  logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  logic [9:0] LEDR;
  logic [3:0] KEY;
  logic [9:0] SW;

  DE1_SoC dut (
    .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5,
    .LEDR, .KEY, .SW);

  parameter CLOCK_PERIOD = 100;
  initial begin
    KEY[0] <= 0;
    forever #(CLOCK_PERIOD/2) KEY[0] <= ~KEY[0];
  end

  integer i;
  initial begin
	// format: [wren_addr_data]
	// HEX5:		addr10
	// HEX4:		addr0
	// HEX2:		data input
	// HEX0:		data output
	
	 @(posedge KEY[0]);
	 SW <= 10'b1_00000_0000; @(posedge KEY[0]);	// write 0 to address 0
	  @(posedge KEY[0]);
	 SW <= 10'b0_00000_0000; @(posedge KEY[0]);	// read from address 0
	  @(posedge KEY[0]);
	 SW <= 10'b1_00010_1000; @(posedge KEY[0]);	// write 8 to adderss 2
	  @(posedge KEY[0]);
	 SW <= 10'b0_00010_0000; @(posedge KEY[0]);	// read from address 2
	  @(posedge KEY[0]);
	 SW <= 10'b0_00000_0000; @(posedge KEY[0]);	// read from address 0
	 @(posedge KEY[0]);
	  @(posedge KEY[0]);
	   @(posedge KEY[0]);
	 $stop();

  end
endmodule