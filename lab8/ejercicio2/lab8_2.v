// lab 8
// ejercicio 2

module ROM(
	input logic [11:0] adress,
	output wire [7:0] data);
reg[0:11] memoria [0:4096];

initial begin
	$readmemh("memory_list", memoria);
	end
assign	data = memoria[adress];
endmodule