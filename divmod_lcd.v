module divmod(
    input  [3:0] op1,       // Dividend
    input  [3:0] op2,       // Divisor
    output reg [7:0] quotient, // 4-bit integer + 4-bit fractional part
    output reg [3:0] remainder
);
    integer i;
    reg [3:0] rem;
    reg [7:0] result;

    always @(*) begin
        // Default assignments for all variables
        quotient  = 8'd0;
        remainder = 4'd0;
        result    = 8'd0;
        rem       = 4'd0;
        i         = 0;

        if (op2 == 0) begin
            quotient  = 8'hFF;
            remainder = 4'hF;
        end else begin
            rem = op1;

          
            result[7:4] = op1 / op2;
            rem = op1 % op2;

          
            for (i = 3; i >= 0; i = i - 1) begin
                rem = rem << 1;
                if (rem >= op2) begin
                    result[i] = 1;
                    rem = rem - op2;
                end else begin
                    result[i] = 0;
                end
            end

            quotient  = result;
            remainder = rem;
        end
    end
endmodule
