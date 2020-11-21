// -----------------------------------------------------------------------------
//	Daniela Morales Ponce
//	proyecto 2
//	Nibbler
// -----------------------------------------------------------------------------

module pc_counter(
    input clk, reset, enable, load, input[11:0]loadbits,
    output reg[11:0] count);

	always @ (posedge clk, posedge reset) begin


		if(reset) begin
			count <= 12'b0;
			end

		else if(enable) begin
		    	count <= count + 1'b1;
			end

		else if(load) begin
			count <= loadbits;
			end
	end
	endmodule

module ROM(
	input  [11:0] adress,
	output wire [7:0] data);
	reg[11:0] memoria [4095:0];

	initial begin
		$readmemh("memory_list", memoria);
		end
	assign	data = memoria[adress];
	endmodule

module RAM (
	input	weRAM,
	input	csRAM, 
	input [11:0]address,
	inout 	[3:0]data
	);
	reg [3:0]salida;
	reg[3:0] ram [4095:0];

	assign	data = (csRAM && !weRAM) ? salida : 4'bz;

	always @ (address or data or weRAM or csRAM)
	begin
		if (csRAM && weRAM) begin		//	escribiendo un valor en la dirección dada
			ram[address] <= data;		//	store
		end

		else if (csRAM && !weRAM) begin	//	buscando el valor y poniendolo en la salida
			salida <= ram[address];		//	load
		end
	end
	endmodule

module flipflopD(
	input wire CLK, reset, D, enable, output reg Q);

	always @ (posedge CLK, posedge reset, enable) begin
		if (reset) begin
			Q <= 1'b0;
		end
		else if (enable) begin
			Q <= D;
		end
	end
	endmodule

module fetch(input wire clk, reset, enable, input wire [7:0]prog_byte, output wire [3:0]instr, output wire [3:0]oprnd);

	flipflopD ff1(clk, reset, prog_byte[7], enable, instr[3]);
	flipflopD ff2(clk, reset, prog_byte[6], enable, instr[2]);
	flipflopD ff3(clk, reset, prog_byte[5], enable, instr[1]);
	flipflopD ff4(clk, reset, prog_byte[4], enable, instr[0]);

	flipflopD ff5(clk, reset, prog_byte[3], enable, oprnd[3]);
	flipflopD ff6(clk, reset, prog_byte[2], enable, oprnd[2]);
	flipflopD ff7(clk, reset, prog_byte[1], enable, oprnd[1]);
	flipflopD ff8(clk, reset, prog_byte[0], enable, oprnd[0]);
		endmodule

//bus drivers e inputs
module tristate_buffer(input wire enable, input wire [3:0]a, output wire [3:0]y);
		assign y= enable ? a : 4'bz;	
		endmodule

module alu(
           input		[3:0]a,
           input		[3:0]b,     
           input		[2:0]Sel,
           output		reg c, 
           output		z,
           output reg 	[3:0]out
           );

			reg	[4:0] out1;
		           
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
					out1 = 5'bz;
				endcase

		        case(Sel)
		        0:					//	pasar A
					out = out1[3:0];
				1:					//	comparador, restar
					out = out[3:0];
				2:					//	pasar b, lit
					out = out1[3:0];
				3:					//	suma
					out = out1[3:0];
				4:					//	nand
					out = out1[3:0];
		      
				default: 
					out = 4'bz;
				endcase

				case (Sel)
			    0:          //  pasar A
			      c = 0;
			    1:          //  comparador, restar
			      c = out1[4];
			    2:          //  pasar b, lit
			      c = 0;
			    3:          //  suma
			      c = out1[4];
			    4: 
			      c = 0;

			      default:
			      c = 1'bz;
			    endcase

			    end

		    assign  z = ~out1[0] & ~out1[1] & ~out1[2] & ~out1[3];
			endmodule

//accumulator y outputs
module flipflopD4(input wire clk, reset, enable, input wire [3:0]in, output wire [3:0]out);



	flipflopD i_flipflopD1 (.CLK(clk), .reset(reset), .D(in[0]), .enable(enable), .Q(out[0]));
	flipflopD i_flipflopD2 (.CLK(clk), .reset(reset), .D(in[1]), .enable(enable), .Q(out[1]));
	flipflopD i_flipflopD3 (.CLK(clk), .reset(reset), .D(in[2]), .enable(enable), .Q(out[2]));
	flipflopD i_flipflopD4 (.CLK(clk), .reset(reset), .D(in[3]), .enable(enable), .Q(out[3]));
	endmodule

// decoder de 2 salidas para hacer el de 8
module decode(
	input 		c,
	input 		z, 
	input		phase, 
	input 		[3:0]instr, 
	output	logic	[12:0]control
	);

	wire	[6:0]algo;

	assign	algo[6:3] = instr[3:0];
	assign	algo[2] = c;
	assign	algo[1] = z;
	assign	algo[0] = phase;

	always @(*)
		casex (algo)
			7'bxxxxxx0:		control = 13'b1000000001000;	//any
			//JUMP
			7'b00001x1: 	control = 13'b0100000001000;	//JC
			7'b00000x1: 	control = 13'b1000000001000;	//JC
			7'b00011x1: 	control = 13'b1000000001000;	//JNC
			7'b00010x1: 	control = 13'b0100000001000;	//JNC
			//COMP
			7'b0010xx1:		control = 13'b0001001000010;	//CMPI
			7'b0011xx1: 	control = 13'b1001001100000;	//CMPM
			//LIT
			7'b0100xx1: 	control = 13'b0011010000010;	//LIT
			//IN
			7'b0101xx1: 	control = 13'b0011010000100;	//IN
			//LD Y ST
			7'b0110xx1: 	control = 13'b1011010100000;	//LD
			7'b0111xx1: 	control = 13'b1000000111000;	//ST
			//JUMP
			7'b1000x11: 	control = 13'b0100000001000;	//JZ
			7'b1000x01: 	control = 13'b1000000001000;	//JZ
			7'b1001x11: 	control = 13'b1000000001000;	//JNZ
			7'b1001x01: 	control = 13'b0100000001000;	//JNZ
			//ADD
			7'b1010xx1: 	control = 13'b0011011000010;	//ADDI
			7'b1011xx1: 	control = 13'b1011011100000;	//ADDM
			//JMP
			7'b1100xx1: 	control = 13'b0100000001000;	//JMP
			//OUT
			7'b1101xx1: 	control = 13'b0000000001001;	//OUT
			//NAND
			7'b1110xx1: 	control = 13'b0011100000010;	//NANDI
			7'b1111xx1: 	control = 13'b1011100100000;	//NANDM

			default : 		control = 13'bz;
			
		endcase
	endmodule

module phase(input wire clk, reset, enable, output wire q);
	wire d;
	assign d = ~q;
	flipflopD f1(clk, reset, d, enable, q);
	endmodule

module flags (
	input clk,    // Clock
	input reset,
	input enable,
	input	c,
	input	z,
	output	[1:0]Q
	);

	flipflopD i_flipflopDc (.CLK(clk), .reset(reset), .D(c), .enable(enable), .Q(Q[0]));
	flipflopD i_flipflopDz (.CLK(clk), .reset(reset), .D(z), .enable(enable), .Q(Q[1]));
	endmodule

module control(input clk, reset, c, z, enable_flags, enable_phase, phase, input [3:0]instr, output flag_c, flag_z, output [12:0]control);
	wire [1:0]Q;
	assign	flag_z = Q[1];
	assign	flag_c = Q[0];

	phase i_phase (.clk(clk), .reset(reset), .enable(enable_phase), .q(phase));
	flags i_flags (.clk(clk), .reset(reset), .enable(enable_flags), .c(c), .z(z), .Q(Q));
	decode i_decode (.c(Q[0]), .z(Q[1]), .phase(phase), .instr(instr), .control(control));
	endmodule

module ej1_2 (
	input	clk,    			// Clock
	input	pc_en, 				// program counter Enable
	input	fetch_en, 			// fecth enable
	input	reset,  			// reset ff y pc
	input	reset_accu,
	input	accu_en, 			//	Enable accumulator
	input	bus1_en,			//	Enable bus 1
	input	bus2_en,			//	Enable bus 2
	input 	[2:0] Sel,
	input	load,				// load bit
	output	[7:0]data,		// program byte 
	output	[3:0]instr,
	output	[3:0]oprnd,
	output	c,
	output	z,
	output [3:0] out,
	output 	[3:0]out_bus1,
	output 	[3:0] out_accu,
	output 	[11:0]address
		);
	wire	[3:0]y;
	wire	[3:0] out_alu;

	wire [11:0] loadbits;

	assign	loadbits[11:8] = oprnd[3:0];
	assign	loadbits[7:0] = data[7:0];

	pc_counter i_pc_counter (
		.clk(clk), 
		.reset(reset), 
		.enable(pc_en), 
		.load(load), 
		.loadbits(loadbits), 
		.count(address)
		);
	ROM i_ROM (
		.adress(address), 
		.data(data)
		);
	fetch i_fetch (
		.clk      (clk),
		.reset    (reset),
		.enable   (fetch_en),
		.prog_byte(data),
		.instr    (instr),
		.oprnd    (oprnd)
				);
	tristate_buffer i_tristate_buffer1	(	.enable(bus1_en), 
											.a(oprnd), 
											.y(out_bus1)
											);
	alu 			i_alu 				(	.a(out_accu), 
											.b(out_bus1), 
											.Sel(Sel), 
											.c(c), 
											.z(z), 
											.out(out_alu)
											);
	flipflopD4 	i_accumulator 		(	.clk(clk), 
											.reset(reset_accu), 
											.enable(accu_en), 
											.in(out_alu), 
											.out(out_accu)
											);
	tristate_buffer i_tristate_buffer2 	(	.enable(bus2_en), 
											.a(out_alu), 
											.y(y)
											);
	assign	out = y;
	endmodule

module uP (
	input 	clock,
	input 	reset,
	input 	[3:0]pushbuttons,
	output 	phase, c_flag, z_flag,
	output 	[3:0]instr, oprnd, data_bus, FF_out, accu,
	output 	[7:0]program_byte,
	output 	[11:0]PC, address_RAM
		);
	wire	f_phase;
	wire [2:0]Sel;
	wire [12:0] control;
	wire	loadA,	loadPC, loadFlags, csRAM, weRAM, oeALU, oeIN, oeOprnd, loadOut, c, z;

	assign	incPC 	= control[12];
	assign	loadPC 	= control[11];
	assign	loadA 	= control[10];
	assign	loadFlags 	= control[9];
	assign	Sel 	= control[8:6];
	assign	csRAM 	= control[5];
	assign	weRAM 	= control[4];
	assign	oeALU 	= control[3];
	assign	oeIN 	= control[2];
	assign	oeOprnd = control[1];
	assign	loadOut = control[0];

	assign	f_phase = ~phase;

	ej1_2 i_ej1_2 (
		.clk       (clock    		),
		.pc_en     (incPC			),
		.fetch_en  (f_phase  		),
		.reset     (reset 			),
		.reset_accu(reset 			),
		.accu_en   (loadA   		),
		.bus1_en   (oeOprnd 		),
		.bus2_en   (oeALU  			),
		.Sel       (Sel 			),
		.load      (loadPC 			),
		.data      (program_byte 	),
		.instr     (instr 			),
		.oprnd     (oprnd 			),
		.c         (c 			),
		.z         (z 			),
		.out       (data_bus 		),			//salida del bus 2, salida ALU
		.out_bus1  (data_bus		),
		.out_accu  (accu 			),
		.address 	(PC 			)
		);

	control i_control (
		.clk         (clock         ),
		.reset       (reset       	),
		.c           (c         	),
		.z           (z      ),
		.enable_flags(loadFlags ),
		.enable_phase(1'b1 		),
		.phase       (phase       ),
		.instr       (instr       ),
		.control     (control     ),
		.flag_c		 (c_flag),
		.flag_z		 (z_flag)
			);


	assign	address_RAM[11:8] = oprnd;
	assign	address_RAM[7:0] = program_byte;
	RAM i_RAM (.weRAM(weRAM), .csRAM(csRAM), .address(address_RAM), .data(data_bus));

	flipflopD4 i_flipflopD4 (.clk(clk), .reset(reset), .enable(loadOut), .in(data_bus), .out(FF_out));

	tristate_buffer i_tristate_buffer (.enable(oeIN), .a(pushbuttons), .y(data_bus));


	endmodule

