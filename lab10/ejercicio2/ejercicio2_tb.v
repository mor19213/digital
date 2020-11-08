module testbench ();

reg		clk;
reg 	reset;
reg 	accu_en;
reg 	bus1_en;
reg 	bus2_en;
reg 	[0:3] in_bus1;
reg 	[0:2] Sel;
wire	c;
wire	z;
wire	[0:3]	out;
reg 	[0:3]	a;
reg 	[0:3]	b;

ejercicio2 i_ejercicio2 (
	.clk    (clk    ),
	.reset  (reset  ),
	.accu_en(accu_en),
	.bus1_en(bus1_en),
	.bus2_en(bus2_en),
	.in_bus1(in_bus1),
	.Sel    (Sel    ),
	.c      (c      ),
	.z      (z      ),
	.out    (out    )
	);


always
	begin
	clk <= 0; #1 clk <=1; #1;
end

initial begin
#1
	$display("\n ejercicio2");
	$display("| clk | reset | accu_en | bus1_en | bus2_en | in_bus1 |  Sel ||| c | z |  out |");
	$display("==============================================================================|",);
	$monitor("|  %b  |   %b   |    %b    |   %b     |    %b    |   %b  |  %b ||| %b | %b | %b |", clk, reset, accu_en, bus1_en, bus2_en, in_bus1, Sel, c, z, out);
	#2	reset = 1; accu_en = 1; bus1_en = 1; bus2_en = 1; Sel = 3'b011; in_bus1 = 4'b0001;
	#1	reset = 0;
	#8	Sel = 3'b001;
	#6	Sel = 3'b000;
	#4	Sel	= 3'b010;
	#4	Sel = 3'b100;
	#6	bus2_en = 0;
	#2	reset = 1;
	#2	bus2_en = 1; Sel = 3'b011; in_bus1 = 4'b0111;
	#2	reset = 0;
	#6	Sel = 3'b000;
	#4	bus1_en = 0; Sel = 3'b000;
	#4	Sel = 3'b010;
	#4	Sel = 3'b100;
end

initial
	#65 $finish;
	initial begin
		$dumpfile("ejercicio2.vcd");
		$dumpvars(0, testbench);
	end

endmodule