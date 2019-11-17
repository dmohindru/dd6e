//gate level description of bcd to excess-3 convertor
module bcd_to_excess_3_gate(x, a);
    output [3:0] x;
    input [3:0] a;
    wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10;
    //a = a[3], b = a[2], c = a[1], d = a[0]
    and m1(w1, a[2], a[0]);
    and m2(w2, a[2], a[1]);
    //w = bd + bc + a
    or m3(x[3], w1, w2, a[3]);

    //b'
    not m6(w3, a[2]);
    //c'
    not m4(w4, a[1]);
    //z = d' 
    not m5(x[0], a[0]);

    and m6(w6, a[2], w4, x[0]);
    and m7(w7, w3, a[0]);
    and m8(w8, w3, a[1]);
    //x = bc'd' + b'd + b'c
    or m9(x[2], w6, w7, w8);

    and m10(w9, w4, x[0]);
    and m11(w10, a[1], a[0]);
    //y = c'd' + cd
    or m12(x[1], w9, w10);

endmodule

module bcd_to_excess_3_gate_tb;
    reg [3:0] in;
    wire [3:0] f;
    //Instantiate UUT
    bcd_to_excess_3_gate UUT(f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(9) #10 in = in + 1'b1;
        end
    initial $monitor("input = %b, output = %b", in, f);
endmodule