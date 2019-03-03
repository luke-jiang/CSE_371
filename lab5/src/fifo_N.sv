// N data
module fifo_N #(parameter ADDR_WIDTH = 10, DATAWIDTH = 24)
	(
	input logic clk, reset, rd, wr,
	input logic [DATAWIDTH - 1:0] w_data,
	output logic empty, full,
	output logic [DATAWIDTH - 1:0] r_data,
	);
	
	logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	logic wr_en, full_tmp;
	
	// wr_en when not full
	assign wr_en = wr & ~full_tmp;
	assign full = full_temp;
	
	fifo_ctl
	
	






endmodule

module fifo_control #(parameter ADDR_WIDTH = 10)
	(
	input logic clk, reset,
	input logic rd, wr,
	output logic empty, full,
	output logic [ADDR_WIDTH - 1:0] w_addr, r_addr
	);
	
	logic [ADDR_WIDTH - 1:0] w_ptr_logic, w_ptr_next, w_ptr_succ;
	logic [ADDR_WIDTH - 1:0] r_ptr_logic, r_ptr_next, r_ptr_succ;
	logic full_logic, empty_logic, full_next, empty_next;
	
	always_ff @(posedge clk, posedge reset)
		if(reset) begin
			w_ptr_logic <= 0;
			r_ptr_logic <= 0;
			full_logic <= 1'b0;
			empty_logic <= 1'b0;
		end else begin
			w_ptr_logic <= w_ptr_next;
			r_ptr_logic <= r_ptr_next;
			full_logic <= full_next;
			empty_logic <= empty_next;
		end
	
	always_comb begin
		w_ptr_succ = w_ptr_logic + 1;
		r_ptr_succ = r_ptr_logic + 1;
		
		w_ptr_next = w_ptr_logic;
		r_ptr_next = r_ptr_logic;
		
		full_next = full_logic;
		empty_next = empty_logic;
		
		unique case ({wr, rd})
			2'b01: // read
				if (~empty_logic) begin
					r_ptr_next = r_ptr_succ;
					full_next = 1'b0;
					if (r_ptr_succ == w_ptr_logic)
						empty_next = 1'b1;
				end		
			2'b10: // write
				if (~empty_logic) begin
					w_ptr_next = w_ptr_succ;
					empty_next = 1'b0;
					if (w_ptr_succ == r_ptr_logic)
						full_next = 1'b1;
					
				end
			
			2'b11: // read & write
				begin
					w_ptr_next = w_ptr_succ;
					r_ptr_next = r_ptr_succ;
				end
				
			default: ;
		endcase
			
	end
	
	
	// output
	assign w_addr = w_ptr_logic;
	assign r_addr = r_ptr_logic;
	assign full = full_logic;
	assign empty = empty_logic;
	
endmodule
