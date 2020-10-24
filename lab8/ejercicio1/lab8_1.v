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

