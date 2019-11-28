module alu_8_bit(y, sel, a, b);
    output reg [7:0] y;
    input [2:0] sel;
    input [7:0] a, b;

    always @(sel, a, b) begin
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
    end
endmodule

module alu_8_bit_tb;
    reg [7:0] a, b;
    reg [2:0] sel;
    wire [7:0] y;
    
    //Instantiate UUT
    alu_8_bit UUT(y, sel, a, b);

    //stimulus block
    initial
        begin
            a = 8'b01001111;
            b = 8'b00011111;
            sel = 3'b000;
            repeat (7) #100 sel = sel + 1'b1; 
        end
    initial $monitor("a = %b, b = %b, sel = %b, y = %b", a, b, sel, y);
endmodule