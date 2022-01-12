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
	wire mode;
	wire clk;
	
	// 2022年01月05日 追記:
	// 丸山先生のレビューにより、なぜかチャタリング防止と分周器で同じ CLK1 を用いると想定しない動作をすることがわかった
	// チャタリング防止と分周器とで CLK1 と CLK2 を使うようにすれば想定動作をする

	m_chattering u0(CLK1, SW[0], mode);
	
	m_prescale5M u1(CLK2, clk);
	
	always @(posedge clk) begin
		cnt=cnt+1;
	end
	
	assign LED={9'h0, mode};
	
	m_rom u2(cnt+5, mode, HEX0);
	m_rom u3(cnt+4, mode, HEX1);
	m_rom u4(cnt+3, mode, HEX2);
	m_rom u5(cnt+2, mode, HEX3);
	m_rom u6(cnt+1, mode, HEX4);
	m_rom u7(cnt, mode, HEX5);
	
endmodule
