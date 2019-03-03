// CSE 371
// Lab 4 Part 1
// Jie Deng, Luke Jiang
// 21/02/2019

// Implement the bit-counting ASM described in the spec.
// Count how many ones in an n-bit input A.

module bitcounter (
  output logic [3:0] result,
  output logic done,
  input logic [7:0] A,
  input logic clk, reset, start
  );

  logic [7:0] Ar;
  logic incr_result, rshift_A, init_result, init_A;
  bitcounter_controller C (.*);
  bitcounter_datapath D (.*);

endmodule

module bitcounter_controller (
  output logic incr_result, rshift_A, init_result, init_A, done,
  input logic start, clk, reset,
  input logic [7:0] Ar
  );

  enum {S1, S2, S3} ps, ns;

  always_comb begin
  	case (ps)
      S1: ns = start ? S2 : S1;
      S2: ns = (Ar == 0) ? S3 : S2;
      S3: ns = start ? S3 : S1;
  	endcase
  end

  always_comb begin
    incr_result = (ps == S2) & (ns == S2) & (Ar[0] == 1);
    init_A = (ps == S1) & (~start);
    rshift_A = (ps == S2);
    done = (ps == S3);
    init_result = (ps == S1);
  end

  always_ff @(posedge clk) begin
    if (reset)
      ps <= S1;
    else
      ps <= ns;
  end
endmodule

module bitcounter_datapath (
  output logic [7:0] Ar,
  output logic [3:0] result,
  input logic incr_result, rshift_A, init_result, init_A, done,
  input logic [7:0] A,
  input logic clk
  );

  always_ff @(posedge clk) begin
    if (incr_result)
      result <= result + 4'd1;
    if (rshift_A)
      Ar <= Ar >> 8'b1;
    if (init_A)
      Ar <= A;
    if (init_result)
      result <= 0;
  end
endmodule

module bitcounter_testbench ();
  logic [3:0] result;
  logic [7:0] A;
  logic clk, reset, start, done;

  bitcounter dut (.*);

  parameter CLOCK_PERIOD = 100;
  initial begin
    clk <= 0;
    forever #(CLOCK_PERIOD/2) clk <= ~clk;
  end

  initial begin
    reset <= 1; @(posedge clk);
    reset <= 0; start <= 0; A <= 8'b1010_1010; @(posedge clk);
    start <= 1; @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    $stop();
  end
endmodule
