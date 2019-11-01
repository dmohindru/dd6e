module high_even(f, x, y, z);
    output f;
    input x, y, z;
    //F = z'
    assign f = ~z;
endmodule

module high_even_tb;
    reg [2:0] in;
    wire f;
    //Instantiate UUT
    high_even UUT(f, in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 3'b000;
            repeat(7) #10 in = in + 1'b1;
        end
    initial $monitor("xyz = %d, f = %b", in, f);
endmodule
