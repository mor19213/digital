// ejercicio 05
// flip flop D

module flipflop1(input wire CLK,reset, input wire [3:0]D, output reg [3:0]Q);

always @ (posedge CLK, posedge reset) begin
	if(reset) begin
		Q <= 4'b0;
	end
	else	
		Q <= D;
end


endmodule