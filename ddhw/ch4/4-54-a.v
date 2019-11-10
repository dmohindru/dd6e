module bcd_9_complement(a, x);
    output [3:0] a;
    input [3:0] x;

    //A = w'x'y'
    //B = x'y + xy'
    //C = y
    //D = z'
    assign a[3] = ~x[3] & ~x[2] & ~x[1];
    assign a[2] = x[2] ^ x[1];
    assign a[1] = x[1];
    assign a[0] = ~x[0];
endmodule

module bcd_9_complement_tb;
    reg [3:0] in;
    wire [3:0] f;
    //Instantiate UUT
    bcd_9_complement UUT(f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(9) #10 in = in + 1'b1;
        end
    initial $monitor("wxyz = %b, ABCD = %b", in, f);
endmodule