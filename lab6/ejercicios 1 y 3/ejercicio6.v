// ejercicio 05
// flip flop D

module flipflop1(input CLK,reset, input D, output reg Q);

always @ (posedge CLK, posedge reset) begin
	if(reset) begin
		Q <= 0;
	end
	else	
		Q <= D;
end

endmodule

module	ej1(input wire  A, B, CLK, reset, output Y);
	wire sE1, sE0;
	wire E1, E0;

	not(nE1, E1);
	not(nE0, E0);

	assign sE1 = E0 & B + E1 & A & B;
	assign sE0 = nE1 & nE0 & A;
	assign Y = E1 & A & B;

	flipflop1 	U1(CLK, reset, sE1, E1);
	flipflop1	U2(CLK, reset, sE0, E0);

endmodule

module	ej3(input wire  P, CLK, reset, output wire Y2, Y1, Y0);
	wire sE2, sE1, sE0;
	wire E2, E1, E0;

	not(nE2, E2);
	not(nE1, E1);
	not(nE0, E0);
	not(nP, P);


	assign sE2 = (nE2 & E1 & E0 & P) | (nE2 & nE1 & nE0 & nP) | (E2 & nE1 & E0) | (E2 & nE0 & P) | (E2 & E1  & nP);
	assign sE1 = (nE1 & E0 & P) | (E1 & nE0 & P) | (E1 & E0 & nP) | (nE1 + nE0 + nP);
	assign sE0 = nE0;
 	
 	assign Y0 = E1 ^ E0;
 	assign Y1 = E1 ^ E2;
 	assign Y2 = E2;


	flipflop1 	F1(CLK, reset, sE2, E2);
	flipflop1	F2(CLK, reset, sE1, E1);
	flipflop1	F3(CLK, reset, sE0, E0);

endmodule
