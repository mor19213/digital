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

module flipflopD2(input wire clk, reset, enable, input wire [0:1]d, output wire [0:1]q);
	flipflopD f1(clk, reset, d[0], enable, q[0]);
	flipflopD f2(clk, reset, d[1], enable, q[1]);
endmodule

module flipflopD4(input wire clk, reset, enable, input wire [0:3]d, output wire [0:3]q);

	flipflopD ff1(clk, reset, d[0], enable, q[0]);
	flipflopD ff2(clk, reset, d[1], enable, q[1]);
	flipflopD ff3(clk, reset, d[2], enable, q[2]);
	flipflopD ff4(clk, reset, d[3], enable, q[3]);

endmodule
	