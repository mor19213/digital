module testbench();

reg clk, reset, enable, d1;
wire q1, qt;

fliplfopT	T1(clk, reset, enable, qt);

	always
		begin
		clk <= 0; #1 clk <=1; #1;
		end


initial begin
#1
	$display("\n flipflop t \n clk reset enable | q");
	$monitor("%b      %b     %b   | %b ", clk, reset, enable, qt);
	#1	reset = 1; enable = 0;
	#1	reset = 0;
	#2	enable = 1;	
	#8	enable = 0;
	#7	enable = 1;
	#4	reset = 1;
	#4	reset = 0;
end

initial
	#45	$finish;
	initial begin
		$dumpfile("ej2.vcd");
		$dumpvars(0, testbench);
	end
endmodule