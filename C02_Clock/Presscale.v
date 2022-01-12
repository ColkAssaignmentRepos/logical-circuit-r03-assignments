// 1/5M Prescaler
module m_prescale5M(input clk, output c_out);
	reg [25:0] cnt;
	wire wcout;
	
	// Default: 49999999 (1Hz)
	assign wcout=(cnt==26'd49999999) ? 1'b1 : 1'b0;
	assign c_out=wcout;
	
	always @(posedge clk) begin
		if(wcout==1'b1)
			cnt=0;
		else
			cnt=cnt+1;
	end
endmodule
