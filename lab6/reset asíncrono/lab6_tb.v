// ejercicio 05
// flip flop D

module testbench();
reg CLK, reset; 
reg [3:0]D;
wire [3:0]Q;

initial begin
	CLK = 0;

	forever #1 CLK = ~CLK;
end


flipflop1 U1(CLK,reset,D,Q);

initial begin
#1
$display("\n");
$display("R  CLK    D      Q");
$monitor("%b   %b   %b   %b", reset, CLK, D, Q);
		reset=0; D=0000;
	#1 	D=0101;
	#1	D=1100;
	#2	D=0101;
	#1	D=1111; reset=1;
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