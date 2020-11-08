// -----------------------------------------------------------------------------
//	Daniela Morales Ponce
//	laboratorio 10
//	ejercicio2
// -----------------------------------------------------------------------------

module tristate_buffer(input wire enable, input wire [0:3]a, output wire [0:3]y);
	assign y= enable ? a : 4'bzzzz;	
endmodule

module alu(
           input		[0:3]a,
           input		[0:3]b,     
           input		[0:2]Sel,
           output		reg c, 
           output		z,
           output reg 	[0:3]out
           );

reg	[0:4] out1;
           
    always @(*)
    begin
        case(Sel)
        0:					//	pasar A
			out1 = a;
		1:					//	comparador, restar
			out1 = a - b;
		2:					//	pasar b, lit
			out1 = b;
		3:					//	suma
			out1 = a + b;
		4:					//	nand
			out1 = (a ~& b);
      
		default: 
			out1 = 5'bzzzzz;
		endcase

		out = out1[1:4];
    end

    assign  z = ~(out1[4] | out1[1] | out1[2] | out1[3]);
      
always @(*)
  begin
    case (Sel)
    0:          //  pasar A
      c = 0;
    1:          //  comparador, restar
      c = out1[0];
    2:          //  pasar b, lit
      c = 0;
    3:          //  suma
      c = out1[0];
    4: 
      c = 0;

      default:
      c = 1'bz;
    endcase
  end
endmodule

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

module accumulator(input wire clk, reset, enable, input wire [0:3]in_alu, output wire [0:3]accu);



	flipflopD i_flipflopD1 (.CLK(clk), .reset(reset), .D(in_alu[0]), .enable(enable), .Q(accu[0]));
	flipflopD i_flipflopD2 (.CLK(clk), .reset(reset), .D(in_alu[1]), .enable(enable), .Q(accu[1]));
	flipflopD i_flipflopD3 (.CLK(clk), .reset(reset), .D(in_alu[2]), .enable(enable), .Q(accu[2]));
	flipflopD i_flipflopD4 (.CLK(clk), .reset(reset), .D(in_alu[3]), .enable(enable), .Q(accu[3]));

endmodule

module ejercicio2 (
	input	clk,    			//	Clock
	input	reset,
	input	accu_en, 			//	Enable accumulator
	input	bus1_en,			//	Enable bus 1
	input	bus2_en,			//	Enable bus 2
	input	[0:3] in_bus1,
	input 	[0:2] Sel,
	output	c,
	output	z,
	output [0:3] out	
);
	wire	[0:3]y;
	wire 	[0:3] out_bus1;
	wire	[0:3] out_alu;
	wire	[0:3] out_accu;

tristate_buffer i_tristate_buffer1	(	.enable(bus1_en), 
										.a(in_bus1), 
										.y(out_bus1)
										);


alu 			i_alu 				(	.a(out_accu), 
										.b(out_bus1), 
										.Sel(Sel), 
										.c(c), 
										.z(z), 
										.out(out_alu)
										);


accumulator 	i_accumulator 		(	.clk(clk), 
										.reset(reset), 
										.enable(accu_en), 
										.in_alu(out_alu), 
										.accu(out_accu)
										);

tristate_buffer i_tristate_buffer2 	(	.enable(bus2_en), 
										.a(out_alu), 
										.y(y)
										);

assign	out = y;

endmodule
