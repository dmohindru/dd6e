module less_than_2(f, x, y, z);
    output f;
    input x, y, z;
    //F = x'y' + x'z'
    assign f = (~x&~y) | (~x&~z);
endmodule

module less_than_2_tb;
    reg [2:0] in;
    wire f;
    //Instantiate UUT
    less_than_2 UUT(f, in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 3'b000;
            repeat(7) #10 in = in + 1'b1;
        end
    initial $monitor("xyz = %b, f = %b", in, f);
endmodule
