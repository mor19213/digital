module testbench();
reg	clk, reset, load, enable;
reg[11:0] loadbits;
wire[11:0] count;
reg[11:0] adress;
wire[7:0] data;
reg[3:0] A;
reg[3:0] B;
reg[2:0] sel;
wire[3:0] out;

contador u1(clk, reset, enable, load,loadbits, count);
ROM 	 u2(adress, data);
alu		 u3(A, B, sel, out);

always
	begin
	clk <= 0; #1 clk <= 1; #1;
	end

initial begin
#1
	$display("\n contador 12 bits");
	$display("\n clk | reset | enable | load |    load     |   count");
	$monitor("%b       %b        %b       %b    %b      %b    ", clk, reset, enable, load, loadbits, count);
		reset = 1; enable = 0; load = 0; loadbits = 12'b100100000001;
	#1	reset = 0; 
	#2	enable = 1;
	#5	enable = 0;
	#5	enable = 1;
	#3	load = 1; 
	#8	load = 0;
	#9	reset = 1;
	#4	reset = 0;
	#4	loadbits = 12'b100000000000; enable = 0;
	#6	load = 1;
	#4	load = 0;
	#8	enable = 1;
	end


initial begin
#80
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

initial begin
#120
$display("\n ALU ");
$display("\n  A    |   B    | sel  | out  ");
$monitor(" %b    %b    %b    %b ", A, B, sel, out);
	A = 4'b0101; B = 4'b0110; sel = 3'b000;
#1	A = 4'b1101; B = 4'b0010; sel = 3'b000;
#1	A = 4'b0101; B = 4'b0110; sel = 3'b001;
#1	A = 4'b1001; B = 4'b0110; sel = 3'b001;
#1	A = 4'b0101; B = 4'b0110; sel = 3'b010;
#1	A = 4'b0111; B = 4'b0100; sel = 3'b010;
#1	A = 4'b0101; B = 4'b0110; sel = 3'b011;
#1	A = 4'b0001; B = 4'b1110; sel = 3'b011;
#1	A = 4'b0101; B = 4'b0110; sel = 3'b100;
#1	A = 4'b0110; B = 4'b1000; sel = 3'b100;
#1	A = 4'b0101; B = 4'b0110; sel = 3'b101;
#1	A = 4'b0001; B = 4'b0100; sel = 3'b101;
#1	A = 4'b0101; B = 4'b0110; sel = 3'b110;
#1	A = 4'b1111; B = 4'b0001; sel = 3'b110;
#1	A = 4'b0101; B = 4'b0110; sel = 3'b111;
#1	A = 4'b1111; B = 4'b0100; sel = 3'b111;

end

initial
	#150 $finish;
	initial begin
		$dumpfile("lab8.vcd");
		$dumpvars(0, testbench);
	end
endmodule
