module testbench();
reg CLK, reset;
reg A, B, P; 

	always
		begin
		CLK <= 0; reset <=0; #1 CLK<=1; #1;
		end

ej1 U1(A, B, CLK, reset, Y);
ej3 U2(P, CLK, reset, Y2, Y1, Y0);

initial begin
#1
$display("\n");
$display("CLK R | A  B  | Y");
$monitor("%b  %b  | %b  %b  | %b", CLK, reset, A, B, Y);
		A=0; B=0;
	#1	A=0; B=1;
	#1	A=1; B=0;
	#1	A=1; B=1;
	#1	A=0; B=0;
	#1	A=0; B=1;
	#1	A=1; B=0;
	#1	A=1; B=1;


end

initial begin
#10
$display("\n");
$display("C R | P |   Y  ");
$monitor("%b %b | %b | %b %b %b", CLK, reset, P, Y2, Y1, Y0);
		reset=1; P = 1;
	#8	P=1; reset=0;
	#8	P=0;


end

initial
	#45 $finish;

	initial begin
		$dumpfile("lab6.vcd");
		$dumpvars(0, testbench);
	end

endmodule