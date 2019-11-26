
module prob_4_47_a (y, a, b, c, d);
    output y;
    input a, b, c, d;
    wire not_c, c_nor_d, c_xor_d;
    assign not_c = ~c;
    assign c_nor_d = ~(c|d);
    assign c_xor_d = (c^d);
    mux_4x1 m1(y, {a, b}, {c_xor_d, c_nor_d, d, not_c});
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

module prob_4_47_a_tb;
    reg [3:0] in;
    wire y;
    
    //Instantiate UUT
    prob_4_47_a UUT(y, in[3], in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat (15) #10 in = in + 1'b1; 
        end
    initial $monitor("in = %b, y = %b", in, y);
endmodule