module l_instr(
	
	 input [3:0] sel,
    input [3:0] op1,
    input [3:0] op2,
    output reg [7:0] l_out
	);
	
	
	always @(*) begin
	case(sel)
		4'b0000: l_out = {4'b0000,op1 & op2};//and
		4'b0001: l_out = {4'b0000,op1 | op2};//or
		4'b0010: l_out = {4'b0000,op1 ^ op2};//xor
		4'b0011: l_out = {4'b0000, ~op1};//not
		4'b0100: l_out = {4'b0000,~(op1 & op2)};//nand
		4'b0101: l_out = {4'b0000,~(op1 | op2)};//nor
		4'b0110: l_out = {4'b0000,op1 ^~ op2};//xnor
		4'b0111: l_out = {4'b0000, op1>>1};//shift right logical
		4'b1000: l_out = {4'b0000, op1<<1};//shift left logical
		default: l_out = 8'b0;

	endcase
	end
	
endmodule