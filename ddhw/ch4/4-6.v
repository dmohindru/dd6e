module circuit_4_6(F, w, x, y, z);
    output F;
    input w, x, y, z;
    //F = xyz + wyz + wxz + wxy
    wire w1, w2, w3, w4;
    and g1(w1, x, y, z);
    and g2(w2, w, y, z);
    and g3(w3, w, x, z);
    and g4(w4, w, x, y);
    or g5(F, w1, w2, w3, w4);
endmodule

module circuit_4_6_tb;
    reg [3:0] in;
    wire f;
    //Instantiate UUT
    circuit_4_6 UUT(f, in[3], in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("wxyz = %b, F = %b", in, f);
endmodule