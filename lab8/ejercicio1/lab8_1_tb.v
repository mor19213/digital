module testbench();
reg	clk, reset, load, enable;
reg[11:0] loadbits;
wire[11:0] count;

contador u1(clk, reset, enable, load,loadbits, count);

always
	begin
	clk <= 0; #1 clk <= 1; #1;
	end

initial begin
#1
	$display("\n contador 12 bits");
	$display("\n clk | reset | enable | load |    load     |   count");
	$monitor("%b       %b        %b       %b    %b      %b    ", clk, reset, enable, load, loadbits, count);
		reset = 1; enable = 0; load = 0; loadbits = 12'b100100000001;
	#1	reset = 0; 
	#2	enable = 1;
	#5	enable = 0;
	#5	enable = 1;
	#3	load = 1; 
	#8	load = 0;
	#9	reset = 1;
	#4	reset = 0;
	#4	loadbits = 12'b100000000000; enable = 0;
	#6	load = 1;
	#4	load = 0;
	#8	enable = 1;
	end

initial
	#80 $finish;
	initial begin
		$dumpfile("lab8_1.vcd");
		$dumpvars(0, testbench);
	end
endmodule
