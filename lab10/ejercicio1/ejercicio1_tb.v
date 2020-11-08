module testbench();

reg clk;
reg pc_en;
reg fetch_en;
reg reset;
reg [0:11] loadbits;
reg load;
wire [0:7] data;
wire [0:3] instr;
wire [0:3] oprnd;

		ejercicio1 i_ejercicio1 (
			.clk     (clk     ),
			.pc_en   (pc_en   ),
			.fetch_en(fetch_en),
			.reset   (reset   ),
			.loadbits(loadbits),
			.load    (load    ),
			.data    (data    ),
			.instr   (instr   ),
			.oprnd   (oprnd   )
		);

always
	begin
	clk <= 0; #1 clk <=1; #1;
end

initial begin
#1
	$display("\n ejercicio1");
	$display("|clk e_pc e_fetch reset  loadbits    load |program byte   instr  oprnd");
	$monitor("|  %b   %b    %b      %b    %b    %b | %b       %b  %b", clk, pc_en, fetch_en, reset, loadbits, load, data, instr, oprnd);
	#1	reset = 1; pc_en = 1; fetch_en = 1; load = 0; loadbits = 12'h000;
	#1	reset = 0;
	#5	loadbits = 12'h003;
	#3	load = 1;
	#5	load = 0;
	#5	fetch_en = 0;
	#4	pc_en = 0; 
	#3	fetch_en = 1;
	#5	reset = 1;
	#4	reset = 0; pc_en = 1; fetch_en = 1; loadbits = 12'h0A1;
	#1	load = 1;
	#1	load = 0;
end

initial
	#45	$finish;
	initial begin
		$dumpfile("ejercicio1.vcd");
		$dumpvars(0, testbench);
	end
endmodule
