module testbench();
	
// entradas
	reg[1:0] S1;
	reg[1:0] S4;
	reg S2, S5;
	reg[2:0] S0;
	reg[2:0] S3;
	reg[1:0] b5;
	reg[1:0] b1;
	reg b, c, c4;

// salidas
	wire y0, y1, y2, y3, y4, y5;

	t1m8 a0(S0, y0);
	t1m4 a1(c, S1, y1);
	t1m2 a2(b1, S2, y2);
	t2m8 a3(S3, y3);
	t2m4 a4(c4, S4, y4);
	t2m2 a5(b5, S5, y5);

// Tabla 1
	initial begin
	#1
		$display("\n");
		$display("Tabla 1, MUX 8:1");
		$display("  S  | Y");
		$display("---|---");
		$monitor(" %b|%b ", S0, y0);
			S0 = 000;
		#1	S0 = 001;
		#1	S0 = 010;
		#1 	S0 = 011;
		#1	S0 = 100;
		#1	S0 = 101;
		#1	S0 = 110;
		#1	S0 = 111;
	end

		initial begin
	#10
		$display("\n");
		$display("Tabla 1, MUX 4:1");
		$display("S    | Y");
		$display("-----|---");
		$monitor(" %b %b | %b ", S1, c, y1);
			S1 = 00; c = 0;
		#1	S1 = 00; c = 1;
		#1	S1 = 01; c = 0;
		#1	S1 = 01; c = 1;
		#1	S1 = 10; c = 0;
		#1	S1 = 10; c = 1;
		#1 	S1 = 11; c = 0;
		#1 	S1 = 11; c = 1;
	end

	initial begin
	#20
		$display("\n");
		$display("Tabla 1, MUX 2:1");
		$display("S    | Y");
		$display("-----|---");
		$monitor(" %b %b | %b ", S2, b1, y2);
			S2 = 0; b1 = 00;
		#1	S2 = 0; b1 = 01;
		#1	S2 = 0; b1 = 10;
		#1	S2 = 0; b1 = 11;
		#1	S2 = 1; b1 = 00;
		#1	S2 = 1; b1 = 01;
		#1	S2 = 1; b1 = 10;
		#1	S2 = 1; b1 = 11;
	end

// Tabla 2
	initial begin
	#30
		$display("\n");
		$display("Tabla 2, MUX 8:1");
		$display("  S  | Y");
		$display("---|---");
		$monitor(" %b|%b ", S3, y3);
			S3 = 000;
		#1	S3 = 001;
		#1	S3 = 010;
		#1 	S3 = 011;
		#1	S3 = 100;
		#1	S3 = 101;
		#1	S3 = 110;
		#1	S3 = 111;
	end

	initial begin
		#40
		$display("\n");
		$display("Tabla 2, MUX 4:1");
		$display("S    | Y");
		$display("-----|---");
		$monitor(" %b %b | %b ", S4, c4, y4);
			S4 = 00; c4 = 0;
		#1	S4 = 00; c4 = 1;
		#1	S4 = 01; c4 = 0;
		#1	S4 = 01; c4 = 1;
		#1	S4 = 10; c4 = 0;
		#1	S4 = 10; c4 = 1;
		#1 	S4 = 11; c4 = 0;
		#1 	S4 = 11; c4 = 1;
	end

		initial begin
	#50
		$display("\n");
		$display("Tabla 2, MUX 2:1");
		$display("S    | Y");
		$display("-----|---");
		$monitor(" %b %b | %b ", S5, b5, y5);
			S5 = 0; b5 = 00;
		#1	S5 = 0; b5 = 01;
		#1	S5 = 0; b5 = 10;
		#1	S5 = 0; b5 = 11;
		#1	S5 = 1; b5 = 00; //c5 = 0;
		#1	S5 = 1; b5 = 01; //c5 = 1;
		#1	S5 = 1; b5 = 10; //c5 = 0;
		#1	S5 = 1; b5 = 11; //c5 = 1;
		#1 $display("\n");
	end


	initial
	#65 $finish;

	initial begin
		$dumpfile("lab5.vcd");
		$dumpvars(0, testbench);
	end
endmodule