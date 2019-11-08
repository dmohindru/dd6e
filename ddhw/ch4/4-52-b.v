module four_bit_decrementer(c, sum, a);
    output c;
    output [3:0] sum;
    input [3:0] a;
    assign {c, sum} = a - 4'b0001;
endmodule

module four_bit_dec_tb;
    reg [3:0] in;
    wire [3:0] s;
    wire c;

    //Instantiate UUT
    four_bit_decrementer UUT(c, s, in);
    
    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("in = %b, carry = %b, sum = %b", in, c, s);
endmodule