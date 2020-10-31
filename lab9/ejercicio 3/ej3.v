// lab 9

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

// ejercicio 03
// flipflop tipo jk
module	flipflopjk(input wire clk, reset, enable, j, k, output wire q);
wire d, nq, nk, and1, and2;

not	(nq, q);
not (nk, k);
and (and1, nq, j);
and (and2, nk, q);
or	(d, and1, and2);

	

	flipflopD f1(clk, reset, d, enable, q);

endmodule
