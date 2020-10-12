module testbench();
reg clk, reset, clk1;
reg imprimir, escanear, color, prendido;
reg[0:1] paginas;
reg[0:1] ajustes_escaner;
reg  rellenar_color, rellenar_negro, volver;
wire fin_escaner, fin_color, fin_negro;
wire[0:6] display1;
wire[0:6] display2;
wire imprimirc, fin;
wire	imprimir1_c, imprimir1_n, esc_escaner;


senales		bb(prendido, color, escanear, imprimir, ajustes_escaner, reset, clk, rellenar_color, rellenar_negro, paginas, esc_escaner, fin_color, fin_negro, display1, display2);


	always
		begin
		clk <= 0; reset <=0; #1 clk <= 1; #1;
		end


initial begin
	#1
		$display("\n \n	impresora");
		$display("\n");
		$display("on ajustes reset rell imp pag esc col rell display1 display2 ");
    	$monitor("%b  %b     %b    %b  %b   %b    %b    %b   %b   %b   %b ", prendido, ajustes_escaner, reset, rellenar_color, imprimir, paginas, escanear, color, rellenar_negro, display1, display2);
prendido = 1; ajustes_escaner = 11; reset = 1; rellenar_color = 1;  imprimir = 0; paginas = 11; escanear = 0; color = 0; rellenar_negro = 1;
#2	reset = 0; rellenar_color = 0; rellenar_negro = 0;
#2	escanear = 1;
#8	escanear = 0;
#30	reset = 1;
#2	reset = 0;

#2	escanear = 1; 
#11	escanear = 0;
#22	rellenar_color = 1;
#2	rellenar_color = 0;
#8	reset = 1; 
#5	reset = 0;
#1	ajustes_escaner = 01;

#4	escanear = 1; 
#2	escanear = 0; paginas = 00;
#12	reset = 1; 
#5	reset = 0; 
#2	escanear = 1; 
#2	escanear = 0;
#10	ajustes_escaner = 10;

#20	reset = 1;
#5	reset = 0;
#1	color = 1; paginas = 01;
#2	imprimir = 1;
#2	imprimir = 0;
#12	reset = 1;
#5	reset = 0;
#1	color = 0; paginas = 00;
#2	imprimir = 1; 
#2	imprimir = 0;

#1	rellenar_color = 1; rellenar_negro = 1;
#1	rellenar_color = 0; rellenar_negro = 0;

#20	escanear = 1; 
#2	escanear = 0; paginas = 11;
#12	reset = 1; 
#5	reset = 0; 
#2	escanear = 1; 
#2	escanear = 0;
#10	ajustes_escaner = 10;

#25	reset = 1;
#5	reset = 0;
#1	color = 0; paginas = 11;
#2	imprimir = 1;
#2	imprimir = 0;
#12	reset = 1;
#5	reset = 0;
#1	color = 0; paginas = 00;
#2	imprimir = 1; 
#2	imprimir = 0;


end

initial
	#350	$finish;
	initial begin
		$dumpfile("impresora.vcd");
		$dumpvars(0, testbench);
	end

endmodule