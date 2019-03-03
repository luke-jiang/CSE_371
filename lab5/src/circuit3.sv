module circuit3 (
  input logic read_ready, write_ready,
  input logic signed [23:0] readdata_left, readdata_right,
  input logic clk, reset,

  output logic read, write,
  output logic signed [23:0] writedata_left, writedata_right
  );
  localparam DATA_WIDTH = 24;
  localparam ADDR_WIDTH = 3;

  // state register
  enum {FILLING, FREEZE, NORMAL} ps, ns;
  always_ff @(posedge clk) begin
    if (reset)
      ps <= FILLING;
    else
      ps <= ns;
  end

  // divide input by N
  logic signed [23:0] w_data_left, w_data_right;
  //assign w_data_left = readdata_left >>> ADDR_WIDTH;
  //assign w_data_right = readdata_right >>> ADDR_WIDTH;
  always_comb begin
    if (ns == FILLING) begin
		w_data_left = 24'b0;
		w_data_right = 24'b0;
    end else begin
		w_data_left = readdata_left >>> ADDR_WIDTH;
		w_data_right = readdata_right >>> ADDR_WIDTH;
    end
  end

  logic ready;
  assign ready = read_ready & write_ready;
  // read and write output???
  assign read = ready;
  assign write = ready;

  // FIFO signals
  logic rd, wr;                                  // FIFO cntrl
  logic empty, full;                             // FIFO status
  logic signed [23:0] r_data_left, r_data_right; // FIFO output



  fifo #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) left_fifo (
    .clk, .reset,
    .rd, .wr,
    .empty, .full,
    .w_data(w_data_left),    // FIFO input
    .r_data(r_data_left)     // FIFO output
  );

  fifo #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) right_fifo (
    .clk, .reset,
    .rd, .wr,
    .empty(), .full(),
    .w_data(w_data_right),    // FIFO input
    .r_data(r_data_right)     // FIFO output
  );


  always_comb begin
    case (ps)
      FILLING: begin
        if (~full) begin
          ns = FILLING;
			 rd <= 0;
			 wr <= 1;
        end else begin
          ns = NORMAL;
			 rd <= 1;
			 wr <= 0;
		  end
      end
      FREEZE: begin
        if (~ready) begin
          ns = FREEZE;
			 rd <= 0;
			 wr <= 0;
        end else begin
          ns = NORMAL;
			 rd <= 1;
			 wr <= 1;
		  end
      end
      NORMAL: begin
		  if (~ready) begin
          ns = FREEZE;
			 rd <= 0;
			 wr <= 0;
        end else begin
          ns = NORMAL;
			 rd <= 1;
			 wr <= 1;
		  end
      end
    endcase

    //rd = (ns == NORMAL) ;  //????
    //wr = (ns == NORMAL) | (ns == FILLING);
  end

  logic signed [23:0] add_left, add_right;
  always_comb begin
    if (ns == FILLING) begin
      add_left = w_data_left;
      add_right = w_data_right;
	 end else if (ns == FREEZE) begin
		add_left = 24'b0;
		add_right = 24'b0;
    end else begin
      add_left = w_data_left - r_data_left;
      add_right = w_data_right - r_data_right;
    end
  end

  logic signed [23:0] accum_left, accum_right;
  logic signed [23:0] of_left, of_right;
  // The Accumulator register
  always_ff @(posedge clk) begin
    if (reset) begin
      accum_left <= 24'b0;
      accum_right <= 24'b0;
    end else if (~ready) begin
      accum_left <= accum_left;
      accum_right <= accum_right;
    end else begin
      accum_left <= accum_left + add_left;
      accum_right <= accum_right + add_right;
		//accum_left <= of_left;
		//accum_right <= of_right;
    end
  end

  //overflow overflow_left (.out(of_left), .a(accum_left), .b(add_left));
  //overflow overflow_right (.out(of_right), .a(accum_right), .b(add_right));

  assign writedata_left = accum_left;
  assign writedata_right = accum_right;

endmodule

module overflow (
	input logic signed [23:0] a, b,
	output logic signed [23:0] out
	);

	logic signed [23:0] add;
	assign add = a + b;

	always_comb begin
		if (add < 0 & a > 0 & b > 0)
			out = {1'b0, 23'b1};
		else if (add > 0 & a < 0 & b < 0)
			out = {1'b1, 23'b0};
		else
			out = add;
	end
endmodule

module circuit3_testbench ();
	logic read_ready, write_ready;
	logic signed [23:0] readdata_left, readdata_right;
	logic clk;
	logic reset;

	logic read, write;
	logic signed [23:0] writedata_left, writedata_right;

	circuit3 dut (.*);

	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	integer i;
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0;
		read_ready <= 1; write_ready <= 1; readdata_left <= 24'd512;
    readdata_right <= 24'd512; @(posedge clk);

		for (i = 0; i < 20; i++) begin
			if((i > 4) & (i < 7))
				read_ready <= 0;
			else if ((i > 12) & (i < 14))
				read_ready <= 0;
			else
				read_ready <= 1;
			@(posedge clk);
		end
		$stop();
	end
endmodule
