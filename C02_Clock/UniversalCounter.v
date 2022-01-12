// Universal Counter
module m_u_counter(input clk, output [3:0] q, output c_out);
	parameter maxcnt=15;	//default=HEX counter
	reg [3:0] cnt;
	
	assign q=cnt;
	assign c_out = (cnt==4'h0) ? 1'b1 : 1'b0;
	
	always@(posedge clk) begin
		if(cnt==maxcnt)
			cnt=4'h0;
		else
			cnt=cnt+1;
	end
	
endmodule
