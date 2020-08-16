module	gatelevel1(input wire A, B, C, output wire Y1, Y2);
// Y1 = A'B'+ AB' + AC
	
	wire w1, w2, w3, nota, notb, notc;
	not (nota, A);
	not (notb, B);
	not (notc, C);
	and (w1, nota, notc);
	and (w2, A, notb);
	and (w3, A, C);
	or (Y1, w1, w2, w3);

// Y2 = B'
	not (Y2, B);

endmodule

module gatelevel2(input wire A, B, C, D, output wire Y1, Y2);

// Y = AB'CD' + A'B'C'D' + ABC'D' + A'BC'D + AB'C'D +A'B'CD + ABCD + A'BCD'
	wire w1, w2, w3, w4, w5, w6, w7, w8, v1, v2, v3, NOTA, NOTB, NOTC, NOTD;
	not (NOTA, A);
	not (NOTB, B);
	not (NOTC, C);
	not (NOTD, D);
	and (w1, A, NOTB, C, NOTD);
	and (w2, NOTA, NOTB, NOTC, NOTD);
	and (w3, A, B, NOTC, NOTD);
	and (w4, NOTA, B, NOTC, D);
	and (w5, A, NOTB, NOTC, D);
	and (w6, NOTA, NOTB, C, D);
	and (w7, A, B, C, D);
	and (w8, NOTA, B, C, NOTD);
	or (Y1, w1, w2,w3,w4, w5, w6,w7, w8);

// Y = AD' + AC +AB
	and (v1, A, NOTD);
	and (v2, A, C);
	and (v3, A, B);
	or (Y2, v1, v2, v3);

endmodule

module operadores1(input wire A, B, C, D, output wire Y1, Y2);
	
	assign 	Y1 = (A & ~C) | (~B & ~C & ~D) | (A & ~B) | (A & 
	~D); 
	assign 	Y2 = B | (A & D) | (~C & D);
	
endmodule


module operadores2(input wire A, B, C, output wire Y1, Y2);
	assign 	Y1 = (~B | C);
	assign 	Y2 = B | (~A & ~C);
endmodule

module 	gatelevel5(input wire A, B, C, output wire Y);
	wire w1, w2, NOTB;
	not (NOTB, B);
	and (w1, A, C);
	and (w2, A, NOTB);
	or (Y, w1, w2);
endmodule

module	operadores5(input wire A, B, C, output wire SOP, POS);
	assign	SOP = (A & ~B & ~C) | (A & ~B & C) | (A & B & C);
	assign	POS = (A|B|C) & (A|B|~C) & (A|~B|C) & (A|~B|~C) & (~A|~B|C);
endmodule