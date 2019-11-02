module grey_code_convertor(A, B, C, D, w, x, y, z);
    output A, B, C, D;
    input w, x, y, z;
    //A = w
    //B = w'x + wx' = w XOR x
    //C = x'y + xy' = x XOR y
    //D = y'z + yz' = y XOR z
    assign A = w;
    assign B = w ^ x;
    assign C = x ^ y;
    assign D = y ^ z;
endmodule

module grey_code_convertor_tb;
    reg [3:0] in;
    wire [3:0] f;
    //Instantiate UUT
    grey_code_convertor UUT(f[3], f[2], f[1], f[0], in[3], in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("wxyz = %b, ABCD = %b", in, f);
endmodule