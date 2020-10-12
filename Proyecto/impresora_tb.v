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


end

initial
	#250	$finish;
	initial begin
		$dumpfile("impresora.vcd");
		$dumpvars(0, testbench);
	end

endmodule