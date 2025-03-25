`timescale 1ns/1ps

module freqDivider_Tb;
	
	reg clk_in, rstn;
	wire clk_out;
	
	// Instantiate the frequency divider
	freqDivider #(.N(16)) dut (
		.clk_in(clk_in),
		.clk_out(clk_out),
		.rstn(rstn)
	);
	
	// Generate clock signal
	always #5 clk_in = ~clk_in; // 10 ns clock period (100 MHz)
	
	// Test sequence
	initial begin
		$dumpfile("freqDivider.vcd");
      $dumpvars(0, freqDivider_Tb);
		
		clk_in = 0;
      rstn = 0;
		#10 rstn = 1; // Release reset
		#500 $finish; // Stop simulation after 500 ns
	end
	
	// Monitor outputs
    initial begin
        $monitor("Time = %0t, clk_in = %b, clk_out = %b", $time, clk_in, clk_out);
    end
	 
endmodule