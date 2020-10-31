module testbench();

reg c;
reg [0:3]a;
wire [0:3]y;

tristate_buffer bt(c, a, y);

initial begin
#1
	$display("\n buffer triestado \n c   a   |  y");
	$monitor("%b  %b | %b  ", c, a, y);
	#1	c = 0; a = 4'b0000;
	#2	c = 1;
	#4	a = 4'b1111;
	#3	a = 4'b0101;
	#2	a = 4'b1100;
	#1	c = 0;
	#2	a = 4'b1010;
end

initial
	#45	$finish;
	initial begin
		$dumpfile("ej4.vcd");
		$dumpvars(0, testbench);
	end
endmodule