module bcd_decimal_decoder(d, a);
    output [9:0] d;
    input [3:0] a;

    //d0 = a'b'c'd'
    assign d[0] = ~a[3] & ~a[2] & ~a[1] & ~a[0];
    //d1 = a'b'c'd
    assign d[1] = ~a[3] & ~a[2] & ~a[1] & a[0];
    //d2 = b'cd'
    assign d[2] = ~a[2] & a[1] & ~a[0];
    //d3 = b'cd
    assign d[3] = ~a[2] & a[1] & a[0];
    //d4 = bc'd'
    assign d[4] = a[2] & ~a[1] & ~a[0];
    //d5 = bc'd
    assign d[5] = a[2] & ~a[1] & a[0];
    //d6 = bcd'
    assign d[6] = a[2] & a[1] & ~a[0];
    //d7 = bcd
    assign d[7] = a[2] & a[1] & a[0];
    //d8 = ad'
    assign d[8] = a[3] & ~a[0];
    //d9 = ad
    assign d[9] = a[3] & a[0];
endmodule

module bcd_decimal_decoder_tb;
    reg [3:0] in;
    wire [9:0] f;
    
    //Instantiate UUT
    bcd_decimal_decoder UUT(f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(9) #10 in = in + 1'b1;
        end
    initial $monitor("input = %b, output = %b", in, f);
endmodule