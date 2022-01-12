module m_rom(input [3:0] adr, output [7:0] dat);
	reg [7:0] data;
	assign dat=data;
	always @(adr) begin
		case (adr)
			4'h0:	data=8'b11000010;	//G
			4'h1:	data=8'b11000000;	//O
			4'h2: data=8'b11000000; //O
      	4'h3: data=8'b10100001;	//d
      	4'h4: data=8'b10000011;	//b
			4'h5:	data=8'b10010001;	//y
			4'h6:	data=8'b10000110;	//e
      	4'h7: data=8'b11111111; //SP
			4'h8:	data=8'b11000010;	//G
			4'h9:	data=8'b11000000;	//O
			4'ha: data=8'b11000000; //O
      	4'hb: data=8'b10100001;	//d
      	4'hc: data=8'b10000011;	//b
			4'hd:	data=8'b10010001;	//y
			4'he:	data=8'b10000110;	//e
      	4'hf: data=8'b11111111; //SP
			default: data=8'hff;
		endcase 
	end
endmodule
		
