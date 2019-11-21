module decoder_5X32(d, en, in);
    output [31:0] d;
    input en;
    input [4:0] in;

    wire [3:0] sub_en;
    decoder_2X4 m1(sub_en, 1'b1, in[4:3]);

    decoder_3X8 m2(d[31:24], sub_en[3], in[2:0]);
    decoder_3X8 m3(d[23:16], sub_en[2], in[2:0]);
    decoder_3X8 m4(d[15:8], sub_en[1], in[2:0]);
    decoder_3X8 m5(d[7:0], sub_en[0], in[2:0]);
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


module decoder_5X32_tb;
    reg [4:0] in;
    reg en;
    wire [31:0] f;
    integer i;
    
    //Instantiate UUT
    decoder_5X32 UUT(f, 1'b1, in);

    //stimulus block
    initial
        begin
            in = 5'b00000;
            repeat(31) #10 in = in + 1'b1;
        end
    initial $monitor("in = %b, output = %b", in, f);
endmodule

/*
module decoder_3X8_tb;
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
                in = 2'b00;
                repeat(8) #10 in = in + 1'b1;
            end
        end
    initial $monitor("en = %b, in = %b, output = %b", en, in, f);
endmodule
*/
/*
module decoder_2X4_tb;
    reg [1:0] in;
    reg en;
    wire [3:0] f;
    integer i;
    
    //Instantiate UUT
    decoder_2X4 UUT(f, en, in);

    //stimulus block
    initial
        for (i = 0; i < 2; i = i + 1) begin
            en = i;
            begin
                in = 2'b00;
                repeat(4) #10 in = in + 1'b1;
            end
        end
    initial $monitor("en = %b, in = %b, output = %b", en, in, f);
endmodule
*/