// flip flop con set síncrono

module testbench();
reg CLK, reset, set; 
reg [3:0]D;
wire [3:0]Q;

initial begin
	CLK = 0;

	forever #1 CLK = ~CLK;
end

flipflop2 U2(CLK,reset,set,D,Q);

initial begin
#1
$display("\n");
$display("R  S    CLK    D      Q");
$monitor("%b   %b   %b   %b     %b", reset, set, CLK, D, Q);
		D=0000; reset = 1; set = 0;
	#1 	D=0101; reset = 0;
	#1	D=1100;
	#2	D=0101;	set = 1; 
	#1	D=1111; reset=1; set = 0;
	#1	D=0110;
	#1	D=1110;
	#1	D=1111; reset=0;
	#2	D=0111;
	#1	D=1010;
end

initial
	#25 $finish;

	initial begin
		$dumpfile("lab6.vcd");
		$dumpvars(0, testbench);
	end


endmodule