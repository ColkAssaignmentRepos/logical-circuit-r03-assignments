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
	reg [3:0] cnt;
	wire clk;
	
	assign LED = {6'h0, cnt};
	
	m_prescale5M u1(CLK1, clk);
	
	always @(posedge clk) begin
		cnt=cnt+1;
	end
	
	m_rom u2(cnt+5, HEX0);
	m_rom u3(cnt+4, HEX1);
	m_rom u4(cnt+3, HEX2);
	m_rom u5(cnt+2, HEX3);
	m_rom u6(cnt+1, HEX4);
	m_rom u7(cnt, HEX5);
	
endmodule
