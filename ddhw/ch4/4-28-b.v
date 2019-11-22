/* 
F1 = (x + y')z = min(1, 5, 7)
F2 = y'z' + xy' + yz' = min(0, 3, 4, 5, 7)
F3 = (x' + y)z = min(1, 3, 7)
*/

module prob_4_28_b(f1, f2, f3, in);
    output f1, f2, f3;
    input [2:0] in;
    wire [7:0] decode_out;

    decoder_3X8 m1(decode_out, 1'b0, in);
    // f1
    nand(f1, decode_out[1], decode_out[5], decode_out[7] );
    // f2
    nand(f2, decode_out[0], decode_out[3], decode_out[4], decode_out[5], decode_out[7]);
    //f3
    nand(f3, decode_out[1], decode_out[3], decode_out[7]);
endmodule


module decoder_3X8(d, en, in);
    output [7:0] d;
    input en;
    input [2:0] in;

    wire not_en, not_a, not_b, not_c;
    // Inverted signals
    not (not_en, en);
    not (not_a, in[2]);
    not (not_b, in[1]);
    not (not_c, in[0]);
    // a = in[2], b = in[1], c = in[0]
    nand (d[0], not_en, not_a, not_b, not_c);
    nand (d[1], not_en, not_a, not_b, in[0]);
    nand (d[2], not_en, not_a, in[1], not_c);
    nand (d[3], not_en, not_a, in[1], in[0]);
    nand (d[4], not_en, in[2], not_b, not_c);
    nand (d[5], not_en, in[2], not_b, in[0]);
    nand (d[6], not_en, in[2], in[1], not_c);
    nand (d[7], not_en, in[2], in[1], in[0]);


endmodule

module prob_4_28_b_tb;
    reg [2:0] in;
    //reg en;
    wire f1, f2, f3;
    
    //Instantiate UUT
    prob_4_28_b UUT(f1, f2, f3, in);

    //stimulus block
    initial
        begin
            in = 3'b000;
            repeat(7) #10 in = in + 1'b1;
        end
    initial $monitor("in = %b, f1 = %b, f2 = %b, f3 = %b", in, f1, f2, f3);
endmodule