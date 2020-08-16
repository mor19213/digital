// modulos lab 5
// MUX 2:1

module	mux2(input wire D0, D1, S, output Y);
	assign Y =(S == 0)?	D0 : D1;

endmodule


module t1m2(input wire [1:0]b, input wire S, output wire y);

	wire D0, D1;
	assign D0 = b[0]^b[1];
	assign D1 = ~(b[0]^b[1]);
	mux2 M21(D0, D1, S, y);

endmodule

module t2m2(input wire [1:0]b, input wire S, output wire y);
	wire D0, D1;
	assign D0 = ~b[1];
	assign D1 = (b[0]^b[1]);
	mux2 M21(D0, D1, S, y);

endmodule

// MUX 4:1

module	mux4a1(input wire D0, D1, D2, D3, input wire[1:0]S, output wire y);
	
	wire y1, y2;
	mux2 U0(D0, D1, S[0], y1);
	mux2 U1(D2, D3, S[0], y2);
	
	mux2 U2(y1, y2, S[1], y);

endmodule

module t1m4(input wire c, input wire[1:0]S, output wire y);
	
	wire D0, D1, D2, D3;
	assign D0 = c;
	assign D1 = ~c;
	assign D2 = ~c;
	assign D3 = c;
	
	mux4a1 M4(D0, D1, D2, D3, S, y);

endmodule

module t2m4(input wire c, input wire[1:0]S, output wire y);
	
	wire D0, D1, D2, D3;
	assign D0 = ~c;
	assign D1 = 0;
	assign D2 = c;
	assign D3 = ~c;
	
	mux4a1 M4(D0, D1, D2, D3, S, y);

endmodule

module mux8a1(input wire D0, D1, D2, D3, D4, D5, D6, D7, input wire[2:0]S, output wire y);

	wire y1, y2;
	mux4a1 U1(D0, D1, D2, D3, S[2:1], y1);
	mux4a1 U2(D4, D5, D6, D7, S[2:1], y2);
	mux2 U3(y1, y2, S[0], y);

endmodule

module t1m8(input wire[2:0]S, output wire y);
	
	wire D0, D1, D2, D3, D4, D5, D6, D7;
	assign D0 = 0;
	assign D1 = 1;
	assign D2 = 1;
	assign D3 = 0;
	assign D4 = 1;
	assign D5 = 0;
	assign D6 = 0;
	assign D7 = 1;
	
	mux8a1 M8(D0, D1, D2, D3, D4, D5, D6, D7, S, y);

endmodule

module t2m8(input wire[2:0]S, output wire y);

	wire D0, D1, D2, D3, D4, D5, D6, D7;
	assign D0 = 1;  // 0
	assign D1 = 0;	// 2
	assign D2 = 1;	// 4
	assign D3 = 1;	// 6
	assign D4 = 1;	// 1
	assign D5 = 0;	// 3
	assign D6 = 1;	// 4
	assign D7 = 0;	// 7
	
	mux8a1 M9(D0, D1, D2, D3, D4, D5, D6, D7, S, y);

endmodule
