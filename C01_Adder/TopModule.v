module TopModule(
	//////////// CLOCK //////////
	input 		          		CLK1,
	input 		          		CLK2,
	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,
	//////////// Push Button //////////
	input 		     [1:0]		BTN,
	//////////// LED //////////
	output		     [9:0]		LED,
	//////////// SW //////////
	input 		     [9:0]		SW
	);
	wire in0, in1, in2, in3, in4, in5, in6, in7; 
	wire [3:0] input1;
	wire [3:0] input2;
	wire [7:0] result;
	wire [7:0] led0, led1, led2, led3;
	
	m_chattering u0(CLK1, SW[0], in0);
	m_chattering u1(CLK1, SW[1], in1);
	m_chattering u2(CLK1, SW[2], in2);
	m_chattering u3(CLK1, SW[3], in3);
	m_chattering u4(CLK1, SW[4], in4);
	m_chattering u5(CLK1, SW[5], in5);
	m_chattering u6(CLK1, SW[6], in6);
	m_chattering u7(CLK1, SW[7], in7);
	
	assign input1 = {in3, in2, in1, in0};
	assign input2 = {in7, in6, in5, in4};
	
	m_adder u8(input1, input2, result);
	
	m_seven_segment u9(result[3:0], led0);
	m_seven_segment u10(result[7:4], led1);
	m_seven_segment u11(input1, led2);
	m_seven_segment u12(input2, led3);
	
	assign LED={2'h0, input2, input1};
	assign HEX0=led0;
	assign HEX1=led1;
	assign HEX2=led2;
	assign HEX3=led3;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
endmodule
