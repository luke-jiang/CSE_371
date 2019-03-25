module getMotion (
  output logic exit, enter,
  input logic a, b,
  input logic clk, reset
  );

  enum {A, B, C, D} ps, ns;

  always_comb begin
    case (ps)
      A:  if (a)        ns = B;
          else if (b)   ns = D;
          else          ns = A;
      B:  if (b)        ns = C;
          else if (~a)  ns = A;
          else          ns = B;
      C:  if (~a)       ns = D;
          else if (~b)  ns = B;
          else          ns = C;
      D:  if (~b)       ns = A;
          else if (a)   ns = C;
          else          ns = D;
    endcase
  end

  assign enter = (ps == D) & (ns == A);
  assign exit = (ps == B) & (ns == A);

  always_ff @(posedge clk) begin
    if (reset)
      ps <= A;
    else
      ps <= ns;
  end
endmodule

module getMotion_testbench ();
  logic exit, enter;
  logic a, b;
  logic clk, reset;

  getMotion dut (.exit, .enter, .a, .b, .clk, .reset);

  parameter CLOCK_PERIOD = 100;
  initial begin
    clk <= 0;
    forever #(CLOCK_PERIOD/2) clk <= ~clk;
  end

  initial begin
    reset <= 1;         @(posedge clk);
    reset <= 0;         @(posedge clk);
    // entering
    a <= 0;   b <= 0;   @(posedge clk);
    a <= 1;             @(posedge clk);
              b <= 1;   @(posedge clk);
    a <= 0;             @(posedge clk);
              b <= 0;   @(posedge clk); // enter = 1
    // exiting
              b <= 1;   @(posedge clk);
    a <= 1;             @(posedge clk);
              b <= 0;   @(posedge clk);
    a <= 0;             @(posedge clk); // exit = 1
    @(posedge clk);
    $stop();
  end
endmodule
