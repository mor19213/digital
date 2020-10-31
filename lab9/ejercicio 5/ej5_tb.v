module testbench();

reg [6:0] address;
wire [12:0] data;

ROM		ugh(address, data);

initial begin
#1
	$display("\n ejercicio 5 \n  address |      data");
	$monitor("%b | %b ", address, data);
		address = 7'bxxxxxx0;
	#2	address = 7'b00001x1;
	#2	address = 7'b00000x1;
	#2	address = 7'b00011x1;
	#2	address = 7'b00010x1;
	#2	address = 7'b0010xx1;
	#2	address = 7'b0011xx1;
	#2	address = 7'b0100xx1;
	#2	address = 7'b0101xx1;
	#2	address = 7'b0110xx1;
	#2	address = 7'b0111xx1;
	#2	address = 7'b1000x11;
	#2	address = 7'b1000x01;
	#2	address = 7'b1001x11;
	#2	address = 7'b1001x01;
	#2	address = 7'b1010xx1;
	#2	address = 7'b1011xx1;
	#2	address = 7'b1100xx1;
	#2	address = 7'b1101xx1;
	#2	address = 7'b1110xx1;
	#2	address = 7'b1111xx1;
		// sin x
	#2	address = 7'b1111110;
	#2	address = 7'b0000111;
	#2	address = 7'b0000001;
	#2	address = 7'b0001111;
	#2	address = 7'b0001011;
	#2	address = 7'b0010001;
	#2	address = 7'b0011101;
end


initial
	#60	$finish;
	initial begin
		$dumpfile("ej5.vcd");
		$dumpvars(0, testbench);
	end
endmodule