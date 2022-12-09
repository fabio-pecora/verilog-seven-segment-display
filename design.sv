// Code your design here

module halfadder(S,C,x,y);
  input x,y;
  output S,C;
  
  xor U1(S,x,y);
  and U2(C,x,y);
 
endmodule

module fulladder(S,C,x,y,cin);
  input x,y,cin;
  output S,C;
  
  wire S1,D1,D2;
  
  halfadder HA1(S1,D1,x,y);
  halfadder HA2(S,D2,S1,cin);
  or U3(C,D2,D1);
  
endmodule

module four_bit_adder(S,C4,A,B,Cin);
  input[3:0]A,B;
  input Cin;
  output [3:0]S;
  output C4;
  wire C1,C2,C3;
  
  fulladder FA1(S[0],C1,A[0],B[0],Cin);
  fulladder FA2(S[1],C2,A[1],B[1],C1);
  fulladder FA3(S[2],C3,A[2],B[2],C2);
  fulladder FA4(S[3],C4,A[3],B[3],C3);
  
endmodule

module adder_subtractor(S,C,A,B,M);
	//assign M=1;
	
	input[3:0]A,B;
	input M;
	output [3:0]S;
	output C;
	
	wire [3:0]X;
	
	xor U4(X[0],B[0],M);
	xor U5(X[1],B[1],M);
	xor U6(X[2],B[2],M);
	xor U7(X[3],B[3],M);
	
	four_bit_adder FBA1(S,C,A,X,M);
	
endmodule

module bin7seg(x,seg,an,dp);
	input[3:0]x;
	output[0:6]seg;
	output[3:0]an;
	output dp;
	
	reg[0:6]seg;
	
	assign an=4'b1110;
	assign dp=1;
	
	always@(x)
		case(x)
			0:seg=7'b0000001;
			1:seg=7'b1001111;
			2:seg=7'b0010010;
			3:seg=7'b0000110;
			4:seg=7'b0000110;
			5:seg=7'b0100100;
			6:seg=7'b0100000;
			7:seg=7'b0001111;
			8:seg=7'b0000000;
			9:seg=7'b0000100;
			10:seg=7'b0001000;
			11:seg=7'b1100000;
			12:seg=7'b0110001;
			13:seg=7'b1000010;
			14:seg=7'b0110000;
			15:seg=7'b0111000;
			default:seg=7'b1111110;
		endcase

endmodule

module nine_s_complementer(x,seg,an,dp);

	input [3:0]x;
	output [0:6]seg;
	output [3:0]an;
	output dp;
	
	wire [3:0]S;
	wire C;
	
	adder_subtractor AS1(S,C,9,x,1); //M=1 so subtractor
	bin7seg B7S1(S,seg,an,dp);
	
endmodule
