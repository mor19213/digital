module testbench();

	reg	p1, p2, p3, c1, c2, c3, c4, p4, p5, p6, p7, d4, d5, d6, d7, g1, g2, g3, o1, o2, o3;
	wire led1, led2, C, D, led3, led4, led5, g, SOP, POS;

	gatelevel1	G1(p1, p2, p3, led1, led2);
	gatelevel2	G2(c1, c2, c3, c4, C, D);
	operadores1	OP1(p4, p5, p6, p7, led3, led4);
	operadores2 OP2(d5, d6, d7, led5, led6);
	gatelevel5	G5(g1, g2, g3,g);
	operadores5	OP5(o1, o2, o3, SOP, POS);

	initial begin
	#1
		$display("\n \n	ejercicio 1");
		$display("\n");
		$display("ejercicio 1, tabla 1 y 2");
		$display("A B C | Y1| Y2");
   		$display("------|---|---");
    	$monitor("%b %b %b | %b | %b", p1, p2, p3, led1, led2);
			p1 = 0; p2 = 0; p3 = 0;
		#1	p1 = 0; p2 = 0; p3 = 1;
		#1	p1 = 0; p2 = 1; p3 = 0;
		#1	p1 = 0; p2 = 1; p3 = 1;
		#1	p1 = 1; p2 = 0; p3 = 0;
		#1	p1 = 1; p2 = 0; p3 = 1;
		#1	p1 = 1; p2 = 1; p3 = 0;
		#1	p1 = 1; p2 = 1; p3 = 1;
	end


	initial begin
	#9
		$display("\n");
		$display("ejercicio 1, tabla 3 y 4");
		$display("A B C D | Y3| Y4");
   		$display("--------|---|---");
    	$monitor("%b %b %b %b | %b | %b", c1, c2, c3, c4, C, D);
    		c1 = 0; c2 = 0; c3 = 0; c4 = 0;
    	#1	c1 = 0; c2 = 0; c3 = 0; c4 = 1;
    	#1	c1 = 0; c2 = 0; c3 = 1; c4 = 0;
    	#1	c1 = 0; c2 = 0; c3 = 1; c4 = 1;
    	#1	c1 = 0; c2 = 1; c3 = 0; c4 = 0;
    	#1	c1 = 0; c2 = 1; c3 = 0; c4 = 1;
    	#1	c1 = 0; c2 = 1; c3 = 1; c4 = 0;
    	#1	c1 = 0; c2 = 1; c3 = 1; c4 = 1;
    	#1	c1 = 1; c2 = 0; c3 = 0; c4 = 0;
    	#1	c1 = 1; c2 = 0; c3 = 0; c4 = 1;
    	#1	c1 = 1; c2 = 0; c3 = 1; c4 = 0;
    	#1	c1 = 1; c2 = 0; c3 = 1; c4 = 1;
    	#1	c1 = 1; c2 = 1; c3 = 0; c4 = 0;
    	#1	c1 = 1; c2 = 1; c3 = 0; c4 = 1;
    	#1	c1 = 1; c2 = 1; c3 = 1; c4 = 0;
    	#1	c1 = 1; c2 = 1; c3 = 1; c4 = 1;
	end

	initial begin
	#29
		$display("\n 			ejercicio 2");
		$display("\n");
		$display("ejercicio 2, tabla 1 y 3");
		$display("A B C D | Y1| Y3");
   		$display("--------|---|---");
		$monitor("%b %b %b %b | %b | %b ", p4, p5, p6, p7, led3, led4);
			p4 = 0; p5 = 0; p6 = 0; p7 = 0;
		#1	p4 = 0; p5 = 0; p6 = 0; p7 = 1;
		#1	p4 = 0; p5 = 0; p6 = 1; p7 = 0;
		#1	p4 = 0; p5 = 0; p6 = 1; p7 = 1;
		#1	p4 = 0; p5 = 1; p6 = 0; p7 = 0;
		#1	p4 = 0; p5 = 1; p6 = 0; p7 = 1;
		#1	p4 = 0; p5 = 1; p6 = 1; p7 = 0;
		#1	p4 = 0; p5 = 1; p6 = 1; p7 = 1;
		#1	p4 = 1; p5 = 0; p6 = 0; p7 = 0;
		#1	p4 = 1; p5 = 0; p6 = 0; p7 = 1;
		#1	p4 = 1; p5 = 0; p6 = 1; p7 = 0;
		#1	p4 = 1; p5 = 0; p6 = 1; p7 = 1;
		#1	p4 = 1; p5 = 1; p6 = 0; p7 = 0;
		#1	p4 = 1; p5 = 1; p6 = 0; p7 = 1;
		#1	p4 = 1; p5 = 1; p6 = 1; p7 = 0;
		#1	p4 = 1; p5 = 1; p6 = 1; p7 = 1;
	end

	initial begin
	#45
		$display("\n");
		$display("ejercicio 2, tabla 2 y 4");
		$display("A B C | Y2| Y4");
   		$display("------|---|---");
		$monitor("%b %b %b | %b | %b ", d5, d6, d7, led5, led6);
			d5 = 0; d6 = 0; d7 = 0;
		#1	d5 = 0; d6 = 0; d7 = 1;
		#1	d5 = 0; d6 = 1; d7 = 0;
		#1	d5 = 0; d6 = 1; d7 = 1;
		#1	d5 = 1; d6 = 0; d7 = 0;
		#1	d5 = 1; d6 = 0; d7 = 1;
		#1	d5 = 1; d6 = 1; d7 = 0;
		#1	d5 = 1; d6 = 1; d7 = 1;
		
	end

	initial begin
	#55
		$display("\n");
		$display("ejercicio 5, Karnaugh");
		$display("A B C | Y");
   		$display("------|---");
		$monitor("%b %b %b | %b ", g1, g2, g3, g);
			g1 = 0; g2 = 0; g3 = 0;
		#1	g1 = 0; g2 = 0; g3 = 1;
		#1	g1 = 0; g2 = 1; g3 = 0;
		#1	g1 = 0; g2 = 1; g3 = 1;
		#1	g1 = 1; g2 = 0; g3 = 0;
		#1	g1 = 1; g2 = 0; g3 = 1;
		#1	g1 = 1; g2 = 1; g3 = 0;
		#1	g1 = 1; g2 = 1; g3 = 1;

	end
	
	initial begin
	#65
		$display("\n");
		$display("ejercicio 5, SOP y POS");
		$display("A B C | SOP | POS ");
   		$display("------|-----|------");
		$monitor("%b %b %b | %b   |   %b ", o1, o2, o3, SOP, POS);
			o1 = 0; o2 = 0; o3 = 0;
		#1	o1 = 0; o2 = 0; o3 = 1;
		#1	o1 = 0; o2 = 1; o3 = 0;
		#1	o1 = 0; o2 = 1; o3 = 1;
		#1	o1 = 1; o2 = 0; o3 = 0;
		#1	o1 = 1; o2 = 0; o3 = 1;
		#1	o1 = 1; o2 = 1; o3 = 0;
		#1	o1 = 1; o2 = 1; o3 = 1;
		#1 $display("\n");
	end

	initial
		#75 $finish;

	initial begin
		$dumpfile("lab4.vcd");
		$dumpvars(0, testbench);
	end

	endmodule