module Add_half(c_out, sum, a, b);
    output c_out, sum;
    input a, b;
    xor G1(sum, a, b);
    and G2(c_out, a, b);
endmodule

module Add_full(c_out, sum, a, b, c_in);
    output c_out, sum;
    input a, b, c_in;
    wire w1, w2, w3;
    Add_half M1(w2, w1, a, b); //w1 = x^y, w2 = xy
    Add_half M2(w3, sum, w1, c_in); //w3 = (x^y)z
    or(c_out, w2, w3);
endmodule

module Add_usign_4(c_out, sum, a, b, c_in);
    wire b0_in, b1_in, b2_in, b3_in, c1, c2, c3, c4;    //intermediate wires
    output [3:0] sum;
    output c_out;
    input [3:0] a, b;
    input c_in;
    xor g0(b0_in, b[0], c_in);
    xor g1(b1_in, b[1], c_in);
    xor g2(b2_in, b[2], c_in);
    xor g3(b3_in, b[3], c_in);

    Add_full m0(c1, sum[0], a[0], b0_in, c_in);
    Add_full m1(c2, sum[1], a[1], b1_in, c1);
    Add_full m2(c3, sum[2], a[2], b2_in, c2);
    Add_full m3(c_out, sum[3], a[3], b3_in, c3);

endmodule

module Add_usign_tb;
    reg [3:0] a, b;
    reg c_in;
    wire [3:0] s;
    wire c_out;
    integer i, j;

    //Instantiate UUT
    Add_usign_4 UUT(c_out, s, a, b, c_in);
    
    //stimulus block
    initial
        begin
            a = 4'b000;
            
            c_in = 1'b1;
            for (i = 0; i < 15; i = i + 1) begin
                #100 a = a + 1'b1;
                #100 b = 4'b0000;
                for (j = 0; j < 15; j = j + 1) begin
                    #100 b = b + 1'b1;
                end
            end
            
            //c_in = 1'b0;
            //#100;
            //a = 4'b0010;
            //b = 4'b0013;
            //c_in = 1'b1;
            //#100;
        end
    initial $monitor("a = %d, b = %d, c_in = %d, sum = %d, c_out = %d", a, b, c_in, s, c_out);
endmodule
