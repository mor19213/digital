module testbench();

reg clk, reset, enable, d1;
wire q1, qt;
reg 	[0:1]d2;
wire	[0:1]q2;
reg		[0:3]d4;
wire	[0:3]q4;

flipflopD	f1(clk, reset, d1, enable, q1);
flipflopD2	f2(clk, reset, enable, d2, q2);
flipflopD4	f4(clk, reset, enable, d4, q4);

	always
		begin
		clk <= 0; #1 clk <=1; #1;
		end

initial begin
#1
	$display("\n flipflop d");
	$display("clk reset enable  d1 | q1");
	$monitor("%b     %b     %b     %b  |  %b", clk, reset, enable, d1, q1);
	#1	reset = 1;	d1 = 0;
	#1	reset = 0;
	#1	enable = 0;	d1 = 1;
	#2	enable = 1;	
	#2	d1 = 0;
end

initial begin
#10
	$display("\n flipflop d \n 2 bits");
	$display("clk reset enable   d2 | q2");
	$monitor("%b     %b     %b     %b  |  %b", clk, reset, enable, d2, q2);
	#1	reset = 1;	d2 = 2'b01; enable = 0;
	#1	reset = 0;
	#1	enable = 0;	d2 = 2'b11;
	#2	enable = 1;
	#3	d2 = 2'b00;	
end

initial begin
#24
	$display("\n flipflop d \n 4 bits");
	$display("clk reset enable    d4 | q4");
	$monitor("%b     %b     %b     %b  |  %b", clk, reset, enable, d4, q4);
	#1	reset = 1;	d4 = 4'b1010;
	#1	reset = 0;
	#1	enable = 0;	d4 = 4'b1111;
	#2	enable = 1;	
	#3	enable = 0;
	#2	d4 = 4'b0001;
	#3	enable = 1;
	#4	d4 = 4'b0110;
end


initial
	#45	$finish;
	initial begin
		$dumpfile("ej1.vcd");
		$dumpvars(0, testbench);
	end
endmodule