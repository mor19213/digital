// lab 9

// ejercicio 04
// buffer triestado
module tristate_buffer(input wire c, input wire [0:3]a, output wire [0:3]y);
	assign y= c ? a : 4'bz;	
endmodule