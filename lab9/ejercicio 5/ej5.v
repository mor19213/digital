// lab 9

module ROM(
	input wire [6:0] address,
	output reg [12:0] data);

	always @ ( * ) begin
    casex (address)
    7'bxxxxxx0: //0
      data <= 13'b1000000001000;
    7'b00001x1: //1
      data <= 13'b0100000001000;
    7'b00000x1: //2
      data <= 13'b1000000001000;
    7'b00011x1: //3
      data <= 13'b1000000001000;
    7'b00010x1: //4
      data <= 13'b0100000001000;
    7'b0010xx1: //5
      data <= 13'b0001001000010;
    7'b0011xx1: //6
      data <= 13'b1001001100000;
    7'b0100xx1: //7
      data <= 13'b0011010000010;
    7'b0101xx1: //8
      data <= 13'b0011010000100;
    7'b0110xx1: //9
      data <= 13'b1011010100000;
    7'b0111xx1: //10
      data <= 13'b1000000111000;
    7'b1000x11: //11
      data <= 13'b0100000001000;
    7'b1000x01: //12
      data <= 13'b1000000001000;
    7'b1001x11: //13
      data <= 13'b1000000001000;
    7'b1001x01: //14
      data <= 13'b0100000001000;
    7'b1010xx1: //15
      data <= 13'b0011011000010;
    7'b1011xx1: //16
      data <= 13'b1011011100000;
    7'b1100xx1: //17
      data <= 13'b0100000001000;
    7'b1101xx1: //18
      data <= 13'b0000000001001;
    7'b1110xx1: //19
      data <= 13'b0011100000010;
    7'b1111xx1: //20
      data <= 13'b1011100100000;
    default:
      data <= 13'b0;
    endcase
    end
endmodule
