// lab 9

// ejercicio 01
module flipflopD(input wire CLK, reset, D, enable, output reg Q);

always @ (posedge CLK, posedge reset, enable) begin
	if (reset) begin
		Q <= 1'b0;
	end
	else if (enable) begin
		Q <= D;
	end
end
endmodule
	
// ejercicio 02
// flipflop tipo T

module fliplfopT(input wire clk, reset, enable, output wire q);
wire d;
	assign d = ~q;

	flipflopD f1(clk, reset, d, enable, q);
endmodule
