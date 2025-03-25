/*
-----------------------------------------------------------------------------------------------------------------
Module: Frequency Divider
Author: Arman Shaikh
Date: 25-03-2025
Description: This module implements a frequency divider using D flip-flops.
             It takes an input clock (clk_in) and divides its frequency by
             a factor of 'N' (parameterized). The output clock (clk_out)
             toggles at 1/N of the input frequency.
				 
Parameters:
	- N: Frequency Division Factor
	
Function:
	- clogb2: Computes the minimum number of flip-flops required by doing log to the base 2 computation. Can use
				 the inbuilt function $clogb2.

References:
	-

-----------------------------------------------------------------------------------------------------------------
*/

module freqDivider #(parameter N = 8) (
	output clk_out, // Output clock with divided frequency
	input clk_in, // Input clock
	input rstn // Active-low reset
);
	
	// Compute the number of flip-flops required for division
	parameter M = clogb2(N);
	genvar j;
	
	// Intermediate signals for the D flip-flop outputs
	wire [0:M-1]qb;
	wire [0:M-1]c;
		
	// Generate block to instantiate M D flip-flops
	generate 
		for (j = 0; j < M; j = j + 1) begin : my_freq_divider
			if (j==0)
				d_ff stage0(.Q(c[j]), .clk(clk_in), .q(qb[j]), .Qb(qb[j]), .rstn(rstn));
			else
				d_ff stage1(.Q(c[j]), .clk(c[j-1]), .q(qb[j]), .Qb(qb[j]), .rstn(rstn));
		end
	endgenerate
	
	// Assign the final divided clock output
	assign clk_out = c[M-1];
	
	// Function to compute log2(N) for determining the number of flip-flops
	function integer clogb2;
		input [31:0] value;
		integer i;
		begin
			clogb2 = 0;
			for(i = 0; 2**i < value; i = i + 1)
				clogb2 = i + 1;
		end
	endfunction
	
endmodule