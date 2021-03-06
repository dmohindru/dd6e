module prob_4_27(f1, f2, f3, in);
    output f1, f2, f3;
    input [2:0] in;
    wire [7:0] decode_out;

    decoder_3X8 m1(decode_out, 1'b0, in);
    // f1
    nand(f1, decode_out[2], decode_out[4], decode_out[7] );
    // f2
    nand(f2, decode_out[0], decode_out[3]);
    //f3
    nand(f3, decode_out[0], decode_out[2], decode_out[3], decode_out[4], decode_out[7]);
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

module prob_4_27_tb;
    reg [2:0] in;
    //reg en;
    wire f1, f2, f3;
    
    //Instantiate UUT
    prob_4_27 UUT(f1, f2, f3, in);

    //stimulus block
    initial
        begin
            in = 3'b000;
            repeat(7) #10 in = in + 1'b1;
        end
    initial $monitor("in = %b, f1 = %b, f2 = %b, f3 = %b", in, f1, f2, f3);
endmodule

/*module decoder_3X8_tb;
    reg [2:0] in;
    reg en;
    wire [7:0] f;
    integer i;
    
    //Instantiate UUT
    decoder_3X8 UUT(f, en, in);

    //stimulus block
    initial
        for (i = 0; i < 2; i = i + 1) begin
            en = i;
            begin
                in = 3'b000;
                repeat(8) #10 in = in + 1'b1;
            end
        end
    initial $monitor("en = %b, in = %b, output = %b", en, in, f);
endmodule
*/