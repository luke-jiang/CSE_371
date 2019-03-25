// CSE 371
// Lab 1
// Luke Jiang
// 18/01/2018

// Implement a counter in range [0, 25]

module counter25 (
  output logic [4:0] out,
  input logic inc, dec,
  input logic clk, reset
  );

  always_ff @(posedge clk) begin
    if (reset)
      out <= 5'b0;
    else if (inc & (out < 5'd25))
      out <= out + 5'b1;
    else if (dec & (out > 5'b0))
      out <= out - 5'b1;
  end

endmodule

module counter25_testbench ();
  logic [4:0] out;
  logic inc, dec;
  logic clk, reset;

  counter25 dut (.out, .inc, .dec, .clk, .reset);

  parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

  integer i;
  initial begin
    reset <= 1; @(posedge clk);
    reset <= 0; @(posedge clk);
    inc <= 1;
    for (i = 1; i <= 26; i++) begin
      // inc 26 cc, should stop at 25
      @(posedge clk);
    end
    inc <= 0; dec <= 1;
    for (i = 1; i <= 26; i++) begin
      // dec 26 cc, should stop at 0
      @(posedge clk);
    end
	 @(posedge clk);
    inc <= 1; @(posedge clk);
    @(posedge clk);
    $stop();
  end
endmodule
