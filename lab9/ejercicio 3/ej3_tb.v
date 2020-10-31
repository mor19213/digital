module testbench();

reg clk, reset, enable, d1, j, k;
wire	q;

flipflopjk	ft(clk, reset, enable, j, k, q);

	always
		begin
		clk <= 0; #1 clk <=1; #1;
		end

initial begin
#1
	$display("\n flipflop jk \n clk reset enable j  k | q");
	$monitor("%b     %b     %b    %b  %b | %b", clk, reset, enable, j, k, q);
	#1	reset = 1;	j = 0; k = 0; enable = 0;
	#1	reset = 0;
	#2	enable = 1;	
	#4	j = 1;
	#4	j = 0; k = 0;
	#4	k = 1; j = 1;
	#8	j = 0; k = 0;
	#4	reset = 1;
	#2	reset = 0;
	#2	j = 0; k = 1;
end

initial
	#45	$finish;
	initial begin
		$dumpfile("ej3.vcd");
		$dumpvars(0, testbench);
	end
endmodule