// ejercicio2 testbench
module testbench();
reg[11:0] adress;
wire[7:0] data;

ROM u1(adress, data);

initial begin
#1
$display("\n Memoria ROM");
$display("\n  adress        |    data");
$monitor(" %b  |   %b ", adress, data);
	adress = 12'b000000000000;
#1	adress = 12'b000000000100;
#1	adress = 12'b000000000010;
#1	adress = 12'b000000001100;
#1	adress = 12'b000000000010;
#1	adress = 12'b000000000100;
#1	adress = 12'b000001001001;
#1	adress = 12'b000000100111;
#1	adress = 12'b000010100011;
#1	adress = 12'b000010101111;
#1	adress = 12'b000011111111;

end

initial
	#30 $finish;
	initial begin
		$dumpfile("lab8_2.vcd");
		$dumpvars(0, testbench);
	end
endmodule