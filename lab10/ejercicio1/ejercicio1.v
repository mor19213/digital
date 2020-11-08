// -----------------------------------------------------------------------------
//	Daniela Morales Ponce
//	laboratorio 10
//	ejercicio1
// -----------------------------------------------------------------------------

module pc_counter(
    input clk, reset, enable, load, input[0:11]loadbits,
    output reg[0:11] count
);

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
	$readmemh("memory_list", memoria);
	end
assign	data = memoria[adress];
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

module flipflopD4(input wire clk, reset, enable, input wire [0:7]prog_byte, output wire [0:3]instr, output wire [0:3]oprnd);

	flipflopD ff1(clk, reset, prog_byte[0], enable, instr[0]);
	flipflopD ff2(clk, reset, prog_byte[1], enable, instr[1]);
	flipflopD ff3(clk, reset, prog_byte[2], enable, instr[2]);
	flipflopD ff4(clk, reset, prog_byte[3], enable, instr[3]);

	flipflopD ff5(clk, reset, prog_byte[4], enable, oprnd[0]);
	flipflopD ff6(clk, reset, prog_byte[5], enable, oprnd[1]);
	flipflopD ff7(clk, reset, prog_byte[6], enable, oprnd[2]);
	flipflopD ff8(clk, reset, prog_byte[7], enable, oprnd[3]);

endmodule

module ejercicio1 (
	input	clk,    			// Clock
	input	pc_en, 				// program counter Enable
	input	fetch_en, 			// fecth enable
	input	reset,  			// reset ff y pc
	input 	[0:11]loadbits,		// load pc
	input	load,				// load bit
	output	[0:7]data,		// program byte 
	output	[0:3]instr,
	output	[0:3]oprnd
);
	wire [0:11] address;

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


	flipflopD4 i_flipflopD4 (
		.clk      (clk),
		.reset    (reset),
		.enable   (fetch_en),
		.prog_byte(data),
		.instr    (instr),
		.oprnd    (oprnd)
	);
endmodule
