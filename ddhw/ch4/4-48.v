module alu_8_bit_en(y, en, sel, a, b);
    output reg [7:0] y;
    input en;
    input [2:0] sel;
    input [7:0] a, b;

    always @(en, sel, a, b) begin
        if (en == 1)
            case(sel)
                3'b000  :   y = 8'b00000000;
                3'b001  :   y = a & b;
                3'b010  :   y = a | b;
                3'b011  :   y = a + b;
                3'b100  :   y = a - b;
                3'b101  :   y = a ^ b;
                3'b110  :   y = ~a;
                3'b111  :   y = 8'b11111111;

            endcase
        else
            y = 8'bzzzzzzzz;
    end
endmodule

module alu_8_bit_tb;
    reg [7:0] a, b;
    reg en;
    reg [2:0] sel;
    wire [7:0] y;
    
    //Instantiate UUT
    alu_8_bit_en UUT(y, en, sel, a, b);

    //stimulus block
    initial
        begin
            a = 8'b01001111;
            b = 8'b00011111;
            en = 1'b0;
            sel = 3'b000;
            repeat (8) #100 sel = sel + 1'b1;

            en = 1'b1;
            sel = 3'b000;
            repeat (7) #100 sel = sel + 1'b1; 
        end
    initial $monitor("a = %b, b = %b, en = %b, sel = %b, y = %b", a, b, en, sel, y);
endmodule