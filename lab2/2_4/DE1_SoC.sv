
`timescale 1 ps / 1 ps
module DE1_SoC (
  output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
  output logic [9:0] LEDR,
  input logic [3:0] KEY,
  input logic [9:0] SW,
  input logic CLOCK_50
  );
  
  logic [4:0] rdaddress, wraddress;
  logic [3:0] rdaddress_0, rdaddress_10, wraddress_0, wraddress_10;
  logic [3:0] data, q;
  logic wren;
  logic clk, reset;
  
  assign reset = ~KEY[0];
  assign wren = SW[9];
  assign wraddress = SW[8:4];
  assign data = SW[3:0];
  assign wraddress_0 = wraddress % 4'd10;
  assign wraddress_10 = wraddress / 4'd10;
  assign rdaddress_0 = rdaddress % 4'd10;
  assign rdaddress_10 = rdaddress / 4'd10;
  
  // clock divider
  logic [31:0] divided_clk;
  clock_divider getCLK (
	.clock(CLOCK_50), 
	.divided_clocks(divided_clk)
  );
  assign clk = divided_clk[24];
  
  
  // counter for traversing address space
  always_ff @(posedge clk) begin
    if (reset)
      rdaddress <= 5'b0;
    else
	  rdaddress <= rdaddress + 5'b1;
  end
  
  ram32x4 RAM (
    .q,
	.wraddress,
	.rdaddress,
	.clock(CLOCK_50),
	.data,
	.wren
  );
  
  
  // display current write address
  seg7 WRADDR10 (.leds(HEX5), .bcd(wraddress_10));
  seg7 WRADDR0  (.leds(HEX4), .bcd(wraddress_0));
  // display current read address
  seg7 RDADDR10 (.leds(HEX3), .bcd(rdaddress_10));
  seg7 RDADDR0  (.leds(HEX2), .bcd(rdaddress_0));
  // display current write input.
  seg7 WRDATA   (.leds(HEX1), .bcd(data));
  // display output of memory
  seg7 MEMOUT   (.leds(HEX0), .bcd(q));
  
endmodule


module DE1_SoC_testbench ();
  logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  logic [9:0] LEDR;
  logic [3:0] KEY;
  logic [9:0] SW;
  logic CLOCK_50;

  DE1_SoC dut (
    .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5,
    .LEDR, .KEY, .SW, .CLOCK_50);

  parameter CLOCK_PERIOD = 100;
  initial begin
    CLOCK_50 <= 0;
    forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
  end

  integer i;
  initial begin
	// format: [wren_addr_data]
	// HEX5:		addr10
	// HEX4:		addr0
	// HEX2:		data input
	// HEX0:		data output
	
	 @(posedge CLOCK_50);
	 SW <= 10'b1_00000_0000; @(posedge CLOCK_50);	// write 0 to address 0
	 SW <= 10'b0_00000_0000; @(posedge CLOCK_50);	// read from address 0
	 SW <= 10'b1_00010_1000; @(posedge CLOCK_50);	// write 8 to adderss 2
	 SW <= 10'b0_00000_1000; @(posedge CLOCK_50);	// read from address 2
	 SW <= 10'b0_00000_0000; @(posedge CLOCK_50);	// read from address 0
	 @(posedge CLOCK_50);
	 $stop();

  end
endmodule