// -----------------------------------------------------------------------------
//	Daniela Morales Ponce
//	proyecto 2
//	Nibbler
// -----------------------------------------------------------------------------

module pc_counter(
    input clk, reset, enable, load, input[0:11]loadbits,
    output reg[0:11] count);

	always @ (posedge clk, posedge reset, posedge load) begin


		if(enable) begin
		    	count <= count + 1'b1;
			end

		if(load) begin
			count <= loadbits;
			end

		if(reset) begin
			count <= 000000000000;
			end

	end
	endmodule

module ROM(
	input logic [0:11] adress,
	output wire [0:7] data);
	reg[0:11] memoria [0:4095];

	initial begin
		$readmemb("memory_list", memoria);
		end
	assign	data = memoria[adress];
	endmodule

module RAM (
	input	weRAM,
	input	csRAM, 
	input	logic [0:11]address,
	inout 	[0:3]data
	);
	reg [0:3]salida;
	reg[0:3] ram [0:4095];

	assign	data = (csRAM && !weRAM) ? salida : 4'bzzzz;

	always @ (address or data or weRAM or csRAM)
	begin
		if (csRAM && weRAM) begin
			ram[address] <= data;
		end

		else if (csRAM && !weRAM) begin
			salida <= ram[address];
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

module fetch(input wire clk, reset, enable, input wire [0:7]prog_byte, output wire [0:3]instr, output wire [0:3]oprnd);

	flipflopD ff1(clk, reset, prog_byte[0], enable, instr[0]);
	flipflopD ff2(clk, reset, prog_byte[1], enable, instr[1]);
	flipflopD ff3(clk, reset, prog_byte[2], enable, instr[2]);
	flipflopD ff4(clk, reset, prog_byte[3], enable, instr[3]);

	flipflopD ff5(clk, reset, prog_byte[4], enable, oprnd[0]);
	flipflopD ff6(clk, reset, prog_byte[5], enable, oprnd[1]);
	flipflopD ff7(clk, reset, prog_byte[6], enable, oprnd[2]);
	flipflopD ff8(clk, reset, prog_byte[7], enable, oprnd[3]);
		endmodule

//bus drivers e inputs
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

//accumulator y outputs
module flipflopD4(input wire clk, reset, enable, input wire [0:3]in, output wire [0:3]out);



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
	input 		[0:3]instr, 
	output	logic	[0:12]control
	);

	wire	[0:6]algo;

	assign	algo[0:3] = instr[0:3];
	assign	algo[4] = c;
	assign	algo[5] = z;
	assign	algo[6] = phase;

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
	output	[0:1]Q
	);

	flipflopD i_flipflopDc (.CLK(clk), .reset(reset), .D(c), .enable(enable), .Q(Q[0]));
	flipflopD i_flipflopDz (.CLK(clk), .reset(reset), .D(z), .enable(enable), .Q(Q[1]));
	endmodule

module control(input clk, reset, c, z, enable_flags, enable_phase, phase, input [0:3]instr, output [0:12]control);
	wire [0:1]Q;

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
	input 	[0:2] Sel,
	input	load,				// load bit
	output	[0:7]data,		// program byte 
	output	[0:3]instr,
	output	[0:3]oprnd,
	output	c,
	output	z,
	output [0:3] out,
	output 	[0:3]out_bus1,
	output 	[0:3] out_accu,
	output 	[0:11]address
		);
	wire	[0:3]y;
	wire	[0:3] out_alu;

	wire [0:11] loadbits;

	assign	loadbits[0:3] = oprnd[0:3];
	assign	loadbits[4:11] = data[0:7];

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
	input 	clk,
	input 	reset,
	input 	[0:3]pushbuttons,
	output 	phase, c_flag, z_flag,
	output 	[0:3]instr, oprnd, data_bus, FF_out, accu,
	output 	[0:7]program_byte,
	output 	[0:11]pc, address_ram
		);
	wire	f_phase;
	wire [0:2]Sel;
	wire [0:12] control;
	wire	loadA,	loadPC, loadFlags, csRAM, weRAM, oeALU, oeIN, oeOprnd, loadOut;

	assign	incPC 	= control[0];
	assign	loadPC 	= control[1];
	assign	loadA 	= control[2];
	assign	loadFlags 	= control[3];
	assign	Sel 	= control[4:6];
	assign	csRAM 	= control[7];
	assign	weRAM 	= control[8];
	assign	oeALU 	= control[9];
	assign	oeIN 	= control[10];
	assign	oeOprnd = control[11];
	assign	loadOut = control[12];

	assign	f_phase = ~phase;

	ej1_2 i_ej1_2 (
		.clk       (clk    			),
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
		.c         (c_flag 			),
		.z         (z_flag 			),
		.out       (data_bus 		),			//salida del bus 2, salida ALU
		.out_bus1  (data_bus		),
		.out_accu  (accu 			),
		.address 	(pc 			)
		);

control i_control (
	.clk         (clk         ),
	.reset       (reset       ),
	.c           (c_flag           ),
	.z           (z_flag      ),
	.enable_flags(loadFlags ),
	.enable_phase(1'b1 		),
	.phase       (phase       ),
	.instr       (instr       ),
	.control     (control     )
);


	assign	address_ram[0:3] = oprnd;
	assign	address_ram[4:11] = program_byte;
	RAM i_RAM (.weRAM(weRAM), .csRAM(csRAM), .address(address_ram), .data(data_bus));

	flipflopD4 i_flipflopD4 (.clk(clk), .reset(reset), .enable(loadOut), .in(data_bus), .out(FF_out));

	tristate_buffer i_tristate_buffer (.enable(oeIN), .a(pushbuttons), .y(data_bus));


	endmodule

