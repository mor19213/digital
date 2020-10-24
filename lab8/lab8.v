//lab8

// ejercicio 01, contador de 12 bits

module contador(
    input clk, reset, enable, load, input[11:0]loadbits,
    output reg[11:0] count
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

// ejercicio 2
module ROM(
	input logic [11:0] adress,
	output wire [7:0] data);
reg[0:11] memoria [0:4095];

initial begin
	$readmemh("memory_list", memoria);
	end
assign	data = memoria[adress];
endmodule


// ejercicio 3

module alu(
           input wire [3:0] A,
           input wire [3:0] B,     
           input logic [2:0] Sel,
           output logic [3:0] out
    );
    always @(*)
    begin
        case(Sel)
        0:	
			out = A & B;
		1:	
			out = A | B;
		2:	
			out = A + B;
		3:	
			out = 4'b0000;
		4:	
			out = A & ~B;
		5:	
			out = A | ~B;
		6:	
			out = A - B;
		7:	
			out = (A < B) ? 4'b1111 : 4'b0000;
		default: 
			out = 4'b0000;
		endcase
    end

endmodule

