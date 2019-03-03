module seg7 (leds, bcd);
	output logic  [6:0] leds;
	input  logic  [3:0] bcd;
	always_comb begin
		case (bcd)
		//          Light: 6543210
			4'b0000: leds = 7'b1000000; // 0
			4'b0001: leds = 7'b1111001; // 1
			4'b0010: leds = 7'b0100100; // 2
			4'b0011: leds = 7'b0110000; // 3
			4'b0100: leds = 7'b0011001; // 4
			4'b0101: leds = 7'b0010010; // 5
			4'b0110: leds = 7'b0000010; // 6
			4'b0111: leds = 7'b1111000; // 7
			4'b1000: leds = 7'b0000000; // 8
			4'b1001: leds = 7'b0010000; // 9
			4'b1010: leds = 7'b0001000; // a
			4'b1011: leds = 7'b0000011; // b
			4'b1100: leds = 7'b1000110; // c
			4'b1101: leds = 7'b0100001; // d
			4'b1110: leds = 7'b0000110; // e
			4'b1111: leds = 7'b0001110; // f
			default: leds = 7'bX;
		endcase
	end
endmodule

module seg7_testbench ();
  logic  [6:0] leds;
  logic  [3:0] bcd;
  
  seg7 dut (.leds, .bcd);
  
  integer i;
  initial begin
	for (i = 0; i < 10; i++) begin
		bcd = i; #10;
	end
  end
endmodule