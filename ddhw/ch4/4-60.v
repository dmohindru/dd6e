module even_parity_checker_4bit(C, x, y, z, P);
    output C;
    input x, y, z, P;

    wire w1, w2;
    xor(w1, x, y);
    xor(w2, z, P);
    xor(C, w1, w2);
endmodule

module even_parity_checker_4bit_tb;
    reg [3:0] in;
    wire C;
    
    //Instantiate UUT
    even_parity_checker_4bit UUT(C, in[3], in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat (15) #100 in = in + 1'b1; 
        end
    initial $monitor("x = %b, y = %b, z = %b, P = %b, C = %b", in[3], in[2], in[1], in[0], C);
endmodule