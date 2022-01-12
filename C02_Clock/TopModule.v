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
	wire btn0;
	wire btn1;
	wire btn;
	
	wire sw0;
	wire sw1;
	wire sw2;
	
	wire one_hz_clk;
	
	wire stopped;
	
	wire clk_to_sec;
	wire [3:0] current_second_dig1;
	wire [3:0] current_second_dig0;
	wire [7:0] current_second_dig1_disp;
	wire [7:0] current_second_dig0_disp;
	wire carry_to_minute;
	
	wire clk_to_min;
	wire [3:0] current_minute_dig1;
	wire [3:0] current_minute_dig0;
	wire [7:0] current_minute_dig1_disp;
	wire [7:0] current_minute_dig0_disp;
	wire carry_to_hour;
	
	wire clk_to_hour;
	wire [3:0] current_hour_dig1;
	wire [3:0] current_hour_dig0;
	wire [7:0] current_hour_dig1_disp;
	wire [7:0] current_hour_dig0_disp;
	
	m_prescale5M u0(CLK2, one_hz_clk);
	
	m_chattering u1(CLK1, SW[0], sw0);
	m_chattering u2(CLK1, SW[1], sw1);
	m_chattering u3(CLK1, SW[2], sw2);
	m_chattering u4(CLK1, BTN[0], btn0);
	m_chattering u5(CLK1, BTN[1], btn1);
	
	assign btn = btn0 && btn1;
	assign stopped = sw0 || sw1 || sw2;
	
	// 三項演算子はセレクター回路に近い性質があり、スイッチの切り替え先が、
	// 切り替え元と異なるとパルスが発生したとみなされることがある。
	// そのためここでは未定義動作があり、切り替えが正常に動作しないことがある。
	assign clk_to_sec = (sw0 == 1) ? ~btn : (stopped == 1) ? 1'b0 : one_hz_clk;
	assign clk_to_min = (sw1 == 1) ? ~btn : (stopped == 1) ? 1'b0 : carry_to_minute;
	assign clk_to_hour = (sw2 == 1) ? ~btn : (stopped == 1) ? 1'b0 : carry_to_hour;

	m_second_timer u6(clk_to_sec, current_second_dig1, current_second_dig0, carry_to_minute);
	m_minute_timer u7(clk_to_min, current_minute_dig1, current_minute_dig0, carry_to_hour);
	m_hour_timer u8(clk_to_hour, current_hour_dig1, current_hour_dig0);
	
	m_seven_segment u9(current_second_dig1, current_second_dig1_disp);
	m_seven_segment u10(current_second_dig0, current_second_dig0_disp);
	m_seven_segment u11(current_minute_dig1, current_minute_dig1_disp);
	m_seven_segment u12(current_minute_dig0, current_minute_dig0_disp);
	m_seven_segment u13(current_hour_dig1, current_hour_dig1_disp);
	m_seven_segment u14(current_hour_dig0, current_hour_dig0_disp);

	assign LED={7'b0, SW[2:0]};
	assign HEX0=current_second_dig0_disp;
	assign HEX1=current_second_dig1_disp;
	assign HEX2=current_minute_dig0_disp;
	assign HEX3=current_minute_dig1_disp;
	assign HEX4=current_hour_dig0_disp;
	assign HEX5=current_hour_dig1_disp;
	
endmodule
