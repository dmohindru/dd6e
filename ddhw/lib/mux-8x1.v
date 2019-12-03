module mux_8x1 (y, s, d);
    output y;
    input [2:0] s;
    input [7:0] d;

    wire not_s0, not_s1, not_s2, d0_out, d1_out, d2_out, d3_out, d4_out, d5_out, d6_out, d7_out;
    not (not_s0, s[0]);
    not (not_s1, s[1]);
    not (not_s2, s[2]);
    nand (d0_out, not_s2, not_s1, not_s0, d[0]);
    nand (d1_out, not_s2, not_s1, s[0], d[1]);
    nand (d2_out, not_s2, s[1], not_s0, d[2]);
    nand (d3_out, not_s2, s[1], s[0], d[3]);
    nand (d4_out, s[2], not_s1, not_s0, d[4]);
    nand (d5_out, s[2], not_s1, s[0], d[5]);
    nand (d6_out, s[2], s[1], not_s0, d[6]);
    nand (d7_out, s[2], s[1], s[0], d[7]);
        
    nand (y, d0_out, d1_out, d2_out, d3_out, d4_out, d5_out, d6_out, d7_out);

endmodule