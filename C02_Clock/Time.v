// Second Timer Module
module m_second_timer(input one_hz_clk, output [3:0] dig1, output [3:0] dig0, output carry);
	wire [3:0] dig1_cnt;
	wire [3:0] dig0_cnt;
	
	wire carry_to_dig1;
	wire carry_to_minute;
	
	// Senary counter (dig1)
	m_u_counter #(5) u0(carry_to_dig1, dig1_cnt, carry_to_minute);
	
	// Decimal Counter (dig0)
	m_u_counter #(9) u1(one_hz_clk, dig0_cnt, carry_to_dig1);
	
	assign dig1=dig1_cnt;
	assign dig0=dig0_cnt;
	assign carry=carry_to_minute;

endmodule

// Minute Timer Module
module m_minute_timer(input carry_from_second, output [3:0] dig1, output [3:0] dig0, output carry);
	wire [3:0] dig1_cnt;
	wire [3:0] dig0_cnt;
	
	wire carry_to_dig1;
	wire carry_to_hour;
	
	// Senary counter (dig1)
	m_u_counter #(5) u0(carry_to_dig1, dig1_cnt, carry_to_hour);
	
	// Decimal Counter (dig0)
	m_u_counter #(9) u1(carry_from_second, dig0_cnt, carry_to_dig1);
	
	assign dig1=dig1_cnt;
	assign dig0=dig0_cnt;
	assign carry=carry_to_hour;
	
endmodule

// Hour Timer Module
module m_hour_timer(input carry_from_minute, output [3:0] dig1, output [3:0] dig0);
	reg [3:0] dig1_cnt;
	reg [3:0] dig0_cnt;
	
	reg [4:0] hour;
	
	// 24 時間で強制リセット
	always @(posedge carry_from_minute) begin
		if(hour == 5'd23) begin
			dig1_cnt=4'h0;
			dig0_cnt=4'h0;
			hour = 5'd0;
		end
		
		else if (dig0_cnt == 4'h9) begin
			dig0_cnt = 0;
			dig1_cnt = dig1_cnt + 1;
			hour = hour + 1;
		end
		
		else begin
			dig0_cnt = dig0_cnt + 1;
			hour = hour + 1;
		end
	end
	
	// Ternary counter (dig1)
	// m_u_counter #(2) (carry_to_dig1, dig1_cnt, carry_to_day);
	
	// Decimal Counter (dig0)
	// m_u_counter #(9) (carry_from_minute, dig0_cnt, carry_to_dig1);
	
	assign dig1=dig1_cnt;
	assign dig0=dig0_cnt;
	
endmodule
