module decoder_4X16(d, en, in);
    output [15:0] d;
    input en;
    input [3:0] in;

    wire [3:0] sub_en;
    decoder_2X4 m1(sub_en, 1'b1, in[3:2]);
    decoder_2X4 m2(d[15:12], sub_en[3], in[1:0]);
    decoder_2X4 m3(d[11:8], sub_en[2], in[1:0]);
    decoder_2X4 m4(d[7:4], sub_en[1], in[1:0]);
    decoder_2X4 m5(d[3:0], sub_en[0], in[1:0]);

endmodule

module decoder_2X4(d, en, in);
    output [3:0] d;
    input en;
    input [1:0] in;

    wire not_en, not_a, not_b;
    // Inverted signals
    not (not_en, en);
    not (not_a, in[1]);
    not (not_b, in[0]);
    // a = in[1], b = in[0]
    nor (d[0], not_en, in[1], in[0]);
    nor (d[1], not_en, in[1], not_b);
    nor (d[2], not_en, not_a, in[0]);
    nor (d[3], not_en, not_a, not_b);
endmodule

module decoder_4X16_tb;
    reg [3:0] in;
    wire [15:0] f;
    
    //Instantiate UUT
    decoder_4X16 UUT(f, 1'b1, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("in = %b, output = %b", in, f);
endmodule