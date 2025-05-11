module lcd_display (
    input wire clk,              
    input wire [7:0] data_in,     
    output reg [7:0] LCD_DATA,
    output reg LCD_RS,
    output reg LCD_RW,
    output reg LCD_EN,
    output reg LCD_ON,
    output reg LCD_BLON
);
    reg [25:0] count;
    reg [4:0] state;
    reg [7:0] hex_high, hex_low;
    reg [7:0] lcd_string [0:15]; 
    reg [3:0] char_index;

   
    function [7:0] to_ascii;
        input [3:0] nibble;
        begin
            if (nibble < 10)
                to_ascii = "0" + nibble;
            else
                to_ascii = "A" + (nibble - 10);
        end
    endfunction

    initial begin
        LCD_ON   = 1;
        LCD_BLON = 1;
    end

    always @(posedge clk) begin
        count <= count + 1;

        
        hex_high <= to_ascii(data_in[7:4]);
        hex_low  <= to_ascii(data_in[3:0]);

      
        lcd_string[0]  <= "R";
        lcd_string[1]  <= "e";
        lcd_string[2]  <= "s";
        lcd_string[3]  <= "u";
        lcd_string[4]  <= "l";
        lcd_string[5]  <= "t";
        lcd_string[6]  <= ":";
        lcd_string[7]  <= " ";
        lcd_string[8]  <= "0";
        lcd_string[9]  <= "x";
        lcd_string[10] <= hex_high;
        lcd_string[11] <= hex_low;
        lcd_string[12] <= " ";
        lcd_string[13] <= " ";
        lcd_string[14] <= " ";
        lcd_string[15] <= " ";

        if (count[19:0] == 20'd0) begin
            LCD_EN <= 1;
            LCD_RW <= 0;     // Always writing
            LCD_RS <= 1;     // Sending data
            LCD_DATA <= lcd_string[char_index];
            char_index <= char_index + 1;
            if (char_index == 15)
                char_index <= 0;
        end else begin
            LCD_EN <= 0;
        end
    end
endmodule
