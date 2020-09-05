

// síncrono set
module flipflop2(input wire CLK,reset,set, input wire [3:0]D, output reg [3:0]Q);


always @ (posedge CLK, posedge reset, posedge set) begin
	if(reset) begin
		Q <= 4'b0;
	end
	else if (set) begin
	Q <= 4'b1111;
	end
	else begin
		Q <= D;
	end
end

endmodule