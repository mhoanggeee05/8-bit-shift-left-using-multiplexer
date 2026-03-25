module ex3_testbench();
	logic [7:0] A, B;
	logic clk;
	logic rst;
	logic [7:0] datainput;
	logic ENA;
	logic ENB;
	logic [7:0] P;
	logic [7:0] dataoutput;
	
	Lab1_ex3 DUT (.A(A),.B(B),.clk(clk),.rst(rst),.datainput(datainput),.ENA(ENA),.ENB(ENB),.P(P),.dataoutput(dataoutput));
	
	always
	begin 
		clk = 1; #5;
		clk = 0; #5;
	end
	
	initial 
	begin 
		rst=1;datainput=8'h00;ENA=0;ENB=0;
		#5; rst=0;datainput=8'hFA;ENA=1;
		#7; ENA=0;ENB=1;
		#3; datainput= 8'h03;
		#10; datainput= 8'h04;
		#7; ENA=1;ENB=0;
		#3; datainput=8'h74;
		#7; ENA=0;ENB=1;
		#3; datainput=8'h10;
		#7; ENB=0; 
		#3; datainput=8'h30;
		#7; ENA = 1;ENB=1;
		#3; datainput=8'h9A;
		#7; ENB=0;
		#3; datainput=8'h28;
		#7; ENA=0;ENB=1;
		#3; datainput=8'h04;
		#10; datainput=8'h01;
	end
endmodule 