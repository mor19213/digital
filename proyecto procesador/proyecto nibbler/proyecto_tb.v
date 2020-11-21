//testbench Daniela Morales

module testbench();
//wires e inputs
    reg clk;
    reg pc_en;
    reg fetch_en;
    reg reset;
    reg reset_accu;
    reg accu_en;
    reg bus1_en;
    reg bus2_en;
    reg [0:2] Sel;
    reg load;
    wire [0:7] data;
    wire [0:3] instr;
    wire [0:3] oprnd;
    wire c;
    wire z;
    wire [0:3] out;
    reg enable;
    reg en_phase;
    wire [0:1]Q;
    wire [0:12] control;
    reg     c1, z1;
    reg [0:3] instr1;
    reg c2, z2, phase2;
    reg enable_phase;
    reg [0:3]instr2;
    wire [0:12]control2;
    wire q;
    wire    phase;


    reg [0:3] pushbuttons;
    wire c_flag;
    wire z_flag;
    wire [0:3] data_bus;
    wire [0:3] FF_out;
    wire [0:3] accu;
    wire [0:7] program_byte;
    wire [0:11] PC;
    wire [0:11] address_RAM;
uP i_uP (
    .clock         (clk         ),
    .reset       (reset       ),
    .pushbuttons (pushbuttons ),
    .phase       (phase    ),
    .c_flag      (c_flag      ),
    .z_flag      (z_flag      ),
    .instr       (instr       ),
    .oprnd       (oprnd       ),
    .data_bus    (data_bus    ),
    .FF_out      (FF_out      ),
    .accu        (accu        ),
    .program_byte(program_byte),
    .PC          (PC          ),
    .address_RAM (address_RAM )
    );


always
    begin
    clk <= 0; #5 clk <=1; #5;
end

initial begin
    #5
    $display("uP");
    $display("c r instr phase c_flag z_flag instr oprnd data_bus FF_out accu program_byte      pc        address_ram",);
    $monitor("%b %b  %b   %b     %b     %b      %b  %b   %b   %b   %b   %b   %b  %b", clk, reset, pushbuttons,
        phase, c_flag, z_flag, instr, oprnd, data_bus, FF_out, accu, program_byte, PC, address_RAM);
        reset = 1; 
    #5  reset = 0; pushbuttons = 4'b1111;
    end


initial
    #715    $finish;
    initial begin
        $dumpfile("uP.vcd");
        $dumpvars(0, testbench);
    end

endmodule