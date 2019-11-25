module adder_full (s, c, a, b, c_in);
    output s, c;
    input a, b, c_in;
    wire not_c_in;
    not m0(not_c_in, c_in);
    mux_4x1 m1(s, {a, b}, {c_in, not_c_in, not_c_in, c_in});
    mux_4x1 m2(c, {a, b}, {1'b1, c_in, c_in, 1'b0});
endmodule


module mux_4x1 (y, s, d);
    output y;
    input [1:0] s;
    input [3:0] d;

    wire not_s0, not_s1, d0_out, d1_out, d2_out, d3_out;
    not (not_s0, s[0]);
    not (not_s1, s[1]);

    nand (d0_out, not_s1, not_s0, d[0]);
    nand (d1_out, not_s1, s[0], d[1]);
    nand (d2_out, s[1], not_s0, d[2]);
    nand (d3_out, s[1], s[0], d[3]);
    
        
    nand (y, d0_out, d1_out, d2_out, d3_out);

endmodule

module prob_4_46_a_tb;
    reg [2:0] in;
    wire s, c;
    
    //Instantiate UUT
    adder_full UUT(s, c, in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 3'b000;
            repeat (7) #10 in = in + 1'b1; 
        end
    initial $monitor("in = %b, s = %b, c = %b", in, s, c);
endmodule

/*module mux_4x1_tb;
    reg [3:0] in;
    reg [1:0]s;
    wire y;
    
    //Instantiate UUT
    mux_4x1 UUT(y, s, in);

    //stimulus block
    initial
        begin
            in = 4'b0101;
            s = 2'b00;
            repeat (3) #10 s = s + 1'b1;
            
        end
    initial $monitor("in = %b, s = %b, y = %b", in, s, y);
endmodule
*/