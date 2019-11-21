module prob_4_27(f1, f2, f3, in);
    output f1, f2, f3;
    input [2:0] in;
    wire [7:0] decode_out;

    decoder_3X8 m1(decode_out, 1'b1, in);
    // f1
    or(f1, decode_out[2], decode_out[4], decode_out[7] );
    // f2
    or(f2, decode_out[0], decode_out[3]);
    //f3
    or(f3, decode_out[0], decode_out[2], decode_out[3], decode_out[4], decode_out[7]);
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
    nor (d[0], not_en, in[2], in[1], in[0]);
    nor (d[1], not_en, in[2], in[1], not_c);
    nor (d[2], not_en, in[2], not_b, in[0]);
    nor (d[3], not_en, in[2], not_b, not_c);


    nor (d[4], not_en, not_a, in[1], in[0]);
    nor (d[5], not_en, not_a, in[1], not_c);
    nor (d[6], not_en, not_a, not_b, in[0]);
    nor (d[7], not_en, not_a, not_b, not_c);
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