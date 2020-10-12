// FSM proyecto

module flipflop(input CLK, reset, input D, output reg Q);
always @ (posedge CLK, posedge reset) begin
	if(reset) begin
		Q <= 0;
	end
	else
		Q <= D;
	end
endmodule

module antirebote(input wire prendido, boton, clk, reset, output y);
	wire s0, s1;
	wire sf0, sf1;

	assign	sf1 = boton;
	assign	sf0 = s1 & (~boton);

	flipflop	U1(clk, reset, sf0, s0);
	flipflop	U2(clk, reset, sf1, s1);

	assign	y = s0 & prendido;

endmodule

module escaner(input wire antirebote, clk, reset, input wire[0:1]ajustes, output imp_color, negro, escaner);
	wire s0, s1;
	wire sf0, sf1;

	assign	sf1 = ( ~s0 & ajustes[1] & antirebote ) | (antirebote & ~s0 & ~ajustes[0]) | (s1);
	assign	sf0 = s0 | (antirebote & ajustes[0] & ~s0);

	flipflop	U1(clk, reset, sf0, s0);
	flipflop	U2(clk, reset, sf1, s1);

	assign	imp_color = s0 & s1;
	assign	negro = s0 & ~s1;
	assign	escaner = ~s0 & s1;

endmodule

module bandera(input wire prendido, boton, clk, reset, output y);
	wire s0, s1;
	wire sf0, sf1;

	assign	sf0 = (s0 & boton) | (s1);
	assign	sf1 = boton & ~s0 & ~s1;

	flipflop	U1(clk, reset, sf0, s0);
	flipflop	U2(clk, reset, sf1, s1);

	assign	y = s1 & prendido;
endmodule

module tinta(input wire imprimir, prendido, clk, reset, output error, output wire[0:6]y);
	wire s0, s1, s2, s3;
	wire sf0, sf1, sf2, sf3;

	assign	sf0 = (imprimir & s1 & s2 & s3) | s0;

	assign	sf1 = (imprimir & s2 & s3) | s1;

	assign	sf2 = (imprimir & ~s2 & s3) | (~imprimir & s2) | (imprimir & s1 & s2 & s3) | (s2 & ~s3);

	assign	sf3 = (imprimir & s1 & s2 & s3) | (imprimir & ~s3) | (~imprimir & s3);


 
	flipflop	U1(clk, reset, sf0, s0);
	flipflop	U2(clk, reset, sf1, s1);
	flipflop	U3(clk, reset, sf2, s2);
	flipflop	U4(clk, reset, sf3, s3);

	assign	error = s0;

	assign	y[0] = prendido & ((~s1 & s3) | (s1 & ~s2) | (~s1 & s2 & ~s3));
	assign 	y[1] = prendido & ((~s1 & s2 & ~s3) | (s2 & s3) | (~s1 & ~s2 & s3));
	assign 	y[2] = prendido & ((~s2 & ~s3) | (~s1 & s2 & ~s3) | (~s1 & ~s2 & s3) | (s1 & s3));
	assign	y[3] = prendido & ((s1 & s2) | (~s2 & ~s3) | (s2 & s3) | (s1 & s3));
	assign	y[4] = prendido & ((~s1 & ~s2 & s3) | (s1 & s3));
	assign 	y[5] = prendido & ((s1 & ~s2) | (~s1 & s2 & ~s3) | (~s1 & ~s2 & s3) | (s1 & s3));
	assign 	y[6] = prendido & ((s1 & s2) | (~s2 & ~s3) | (~s1 & s2 & ~s3) | (s2 & s3) | (~s1 & ~s2 & s3));
endmodule

module impresora(input wire error, color, clk, reset, input wire[0:1]pagina, output imprimir, fin);
	wire s0, s1, s2, s3;
	wire sf0, sf1, sf2, sf3;

	assign	sf0 = (~s0 & ~s2 & s3 & error) | (~s0 & ~s1 & s2) | (s0 & s1) | (~s0 & s1 & ~s3);
	assign	sf1 = (~s0 & ~s1 & ~s2 & color & pagina[1] & pagina[0]) | (s0 & ~s1 & s2 & s3) | (~s0 & s2 & ~s3 & error)  | (~s0 & ~s2 & s3 & error) | (~s0 & ~s2 & s3 & ~error)  | (~s0 & s2 & s3 & error) | (s1 & error) | (~s0 & s1 & s3);
	assign	sf2 = (~s0 & ~s2 & ~s3 & color & pagina[1] & ~pagina[0]) | (~s0 & ~s2 & ~s3 & color & ~pagina[1] & pagina[0]) | (s0 & ~s1 & ~s2 & s3) | (~s0 & ~s2 & s3 & ~error) | (s0 & s2 & ~s3) | (~s0 & s2 & s3 & error) | (s1 & s2) | (~s0 & s1 & ~s3) | (~s0 & s1 & s3);
	assign	sf3 = (~s1 & ~s2 & ~s3 & color & ~pagina[0]) | (~s0 & s2 & ~s3 & error) | (s0 & ~s1 & ~s3) | (~s0 & s3 & ~error) | (~s0 & s1 & error) | (s1 & s3);



	flipflop	U1(clk, reset, sf0, s0);
	flipflop	U2(clk, reset, sf1, s1);
	flipflop	U3(clk, reset, sf2, s2);
	flipflop	U4(clk, reset, sf3, s3);


	assign	fin = ~s0 & s1 & s2 & s3;
	assign	imprimir = s0 & ~s1;

endmodule

module	senales(input wire prendido, color, escanear, imprimir, input wire[0:1]ajustes_escaner, input wire reset, clk, rellenar_color, rellenar_negro, input wire[0:1]paginas, output wire  esc_escaner, fin_color, fin_negro, output wire[0:6]display1, output wire[0:6]display2);
	wire	b_escanear, b_imprimir, esc_color, esc_negro, senal_negra, senal_color, senal_contador_n, senal_contador_c, imprimir1_c, imprimir1_n, error1, error2, y_color, y_negro, timerDone;


	antirebote	antirebote_escaner(prendido, escanear, clk, reset, b_escanear);
	escaner 	escaner(b_escanear, clk, reset, ajustes_escaner, esc_color, esc_negro, esc_escaner);

	bandera		mandar_imprimir_color(prendido, esc_color, clk, reset, imprimir1_c);
	bandera		mandar_imprimir_negro(prendido, esc_negro, clk, reset, imprimir1_n);

	antirebote	antirebote_impresora(prendido, imprimir, clk, reset, b_imprimir);
	assign	negro_imp = b_imprimir & ~color;
	assign	color_imp = b_imprimir & color;

	assign	senal_negra = imprimir1_n | negro_imp;
	assign	senal_color = imprimir1_c | color_imp;

	assign	senal_contador_n = senal_negra | imprimirr_n;
	assign	senal_contador_c = senal_color | imprimirr_c;



	impresora 	impresoracolor(error1, senal_color, clk, reset, paginas, imprimirr_c, fin_color);
	tinta		tintacolor(senal_contador_c, prendido, clk, rellenar_color, error1, display1);

	impresora 	impresoranegra(error2, senal_negra, clk, reset, paginas, imprimirr_n, fin_negro);
	tinta		tintanegra(senal_contador_n, prendido, clk, rellenar_negro, error2, display2);


endmodule
