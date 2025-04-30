module a_instr(
	 input [3:0] sel,
    input [3:0] op1,
    input [3:0] op2,
    output reg [7:0] a_out

	);
	

	wire 	[7:0] div_out;
	wire 	[3:0] mod_out;

	divmod d(
    .op1(op1),
    .op2(op2),
    .quotient(div_out),
    .remainder(mod_out)
);

		
	always @(*) begin
	
	case(sel)
		4'b0000: a_out = {4'b0000,op1 + op2};//addition
		4'b0001: a_out = {4'b0000,op1-op2};//subtraction
		4'b0010: a_out = op1*op2;//multiplication
		4'b0011: a_out = op1 + 4'b0001;//increment
		4'b0100: a_out = op1 - 4'b0001;//decrement
		4'b1000: a_out = div_out;//division
		4'b1001: a_out = {4'b0000,mod_out};//modulus
		default: a_out = 8'b0;
	endcase
	end
	
	
	
	
	endmodule