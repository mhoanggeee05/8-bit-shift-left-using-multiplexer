	module top (
		 input  [9:0] SW,
		 input  [1:0] KEY,
		 output [7:0] LEDR
	);

		 wire [7:0] A, B, P;

		 Lab1_ex3 u0 (
			  .datainput  (SW[7:0]),
			  .ENA        (SW[9]),
			  .ENB        (SW[8]),
			  .rst        (~KEY[0]),
			  .clk        (~KEY[1]),
			  .A          (A),
			  .B          (B),
			  .P          (P),
			  .dataoutput (LEDR)
		 );

	endmodule

	module Lab1_ex3 (
		output [7:0] A, B,
		input clk,
		input rst,
		input [7:0] datainput,
		input ENA,
		input ENB,
		output [7:0] P,
		output [7:0] dataoutput
		);
		
		nbitregEB u0 (.D(datainput),.rst(rst),.clk(clk),.ENB(ENB),.Q(B));
		nbitregEA u1(.D(datainput),.rst(rst),.clk(clk),.ENA(ENA),.Q(A));
		shiftreg u2(.A(A),.B(B),.P(P));
		nbitreg u3 (.D(mux_out),.clk(clk),.rst(rst),.Q(dataoutput));
		
		wire [7:0] mux_out;
		assign mux_out = ENA ? A :
									ENB ? B : P;
		
	endmodule
		
	module shiftreg (
		input [7:0] A, B,
		output [7:0] P
		);
		
		logic [7:0] temp;
		
		MUX u0 (.D0(A[0]),.D1(1'b0),.D2(1'b0),.D3(1'b0),.D4(1'b0),.D5(1'b0),.D6(1'b0),.D7(1'b0),.S2(B[2]),.S1(B[1]),.S0(B[0]),.Y(temp[0]));
		MUX u1 (.D0(A[1]),.D1(A[0]),.D2(1'b0),.D3(1'b0),.D4(1'b0),.D5(1'b0),.D6(1'b0),.D7(1'b0),.S2(B[2]),.S1(B[1]),.S0(B[0]),.Y(temp[1]));
		MUX u2 (.D0(A[2]),.D1(A[1]),.D2(A[0]),.D3(1'b0),.D4(1'b0),.D5(1'b0),.D6(1'b0),.D7(1'b0),.S2(B[2]),.S1(B[1]),.S0(B[0]),.Y(temp[2]));
		MUX u3 (.D0(A[3]),.D1(A[2]),.D2(A[1]),.D3(A[0]),.D4(1'b0),.D5(1'b0),.D6(1'b0),.D7(1'b0),.S2(B[2]),.S1(B[1]),.S0(B[0]),.Y(temp[3]));
		MUX u4 (.D0(A[4]),.D1(A[3]),.D2(A[2]),.D3(A[1]),.D4(A[0]),.D5(1'b0),.D6(1'b0),.D7(1'b0),.S2(B[2]),.S1(B[1]),.S0(B[0]),.Y(temp[4]));
		MUX u5 (.D0(A[5]),.D1(A[4]),.D2(A[3]),.D3(A[2]),.D4(A[1]),.D5(A[0]),.D6(1'b0),.D7(1'b0),.S2(B[2]),.S1(B[1]),.S0(B[0]),.Y(temp[5]));
		MUX u6 (.D0(A[6]),.D1(A[5]),.D2(A[4]),.D3(A[3]),.D4(A[2]),.D5(A[1]),.D6(A[0]),.D7(1'b0),.S2(B[2]),.S1(B[1]),.S0(B[0]),.Y(temp[6]));
		MUX u7 (.D0(A[7]),.D1(A[6]),.D2(A[5]),.D3(A[4]),.D4(A[3]),.D5(A[2]),.D6(A[1]),.D7(A[0]),.S2(B[2]),.S1(B[1]),.S0(B[0]),.Y(temp[7]));
		
		logic  B_temp;
		assign B_temp = ~(B[7] | B[6] |B[5] |B[4] |B[3]);
		assign P[0] = B_temp & temp[0];
		assign P[1] = B_temp & temp[1];
		assign P[2] = B_temp & temp[2];
		assign P[3] = B_temp & temp[3];
		assign P[4] = B_temp & temp[4];
		assign P[5] = B_temp & temp[5];
		assign P[6] = B_temp & temp[6];
		assign P[7] = B_temp & temp[7];
		
	endmodule

	module MUX (
		input logic D7, D6, D5, D4, D3, D2, D1, D0,
		input logic S2, S1, S0,
		output logic Y
		);
		assign Y = (~S2 &~S1 &~S0 &D0 | ~S2 &~S1 &S0 &D1) |
					  (~S2 & S1 &~S0 &D2 | ~S2 & S1 &S0 &D3) |
					  (S2 &~S1 &~S0 &D4 |  S2 &~S1 &S0 &D5)  |
					  (S2 & S1 &~S0 &D6 |  S2 & S1 &S0 &D7)   ;

	endmodule
						
	module nbitregEB (
		input logic [7:0] D,
		input logic rst,
		input clk,
		input ENB, 
		output reg [7:0] Q
		);
		
		always_ff @(posedge clk, posedge rst) 
		if (rst) Q <= '0;
		else if (ENB) Q <= D;
		
	endmodule
		
	module nbitregEA (
		input logic [7:0] D,
		input logic rst,
		input clk,
		input ENA, 
		output reg [7:0] Q
		);
		
		always_ff @(posedge clk, posedge rst) 
		if (rst) Q <= '0;
		else if (ENA) Q <= D;
		
	endmodule

	module nbitreg (
		input logic [7:0] D,
		input logic rst,
		input clk,
		output reg [7:0] Q
		);
		
		always_ff @(posedge clk, posedge rst) 
		if (rst) Q <= '0;
		else  Q <= D;
		
	endmodule
