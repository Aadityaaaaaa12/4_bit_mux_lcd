module alu4_lcd(
    input wire control,
    input [3:0] sel,
    input [3:0] op1,
    input [3:0] op2,
    input wire clk, // 50mhz
    output reg [7:0] out,
    output wire [7:0] LCD_DATA,
    output wire LCD_RS,
    output wire LCD_RW,
    output wire LCD_EN,
    output wire LCD_ON,
    output wire LCD_BLON
);

    wire [7:0] out_logic;
    wire [7:0] out_arithmetic;

    l_instr l(
        .sel(sel),
        .op1(op1),
        .op2(op2),
        .l_out(out_logic)
    );

    a_instr a(
        .sel(sel),
        .op1(op1),
        .op2(op2),
        .a_out(out_arithmetic)
    );

    always @(*) begin
        case (control)
            1'b0: out = out_logic;
            1'b1: out = out_arithmetic;
        endcase
    end

 
    lcd_display lcdmod (
        .clk(clk),
        .data_in(out),
        .LCD_DATA(LCD_DATA),
        .LCD_RS(LCD_RS),
        .LCD_RW(LCD_RW),
        .LCD_EN(LCD_EN),
        .LCD_ON(LCD_ON),
        .LCD_BLON(LCD_BLON)
    );

endmodule
