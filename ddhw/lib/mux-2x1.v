module mux_2x1 (y, s, d);
    output y;
    input s;
    input [1:0] d;

    wire not_s, d0_out, d1_out;
    not (not_s, s);
    nand (d0_out, not_s, d[0]);
    nand (d1_out, s, d[1]);
    nand (y, d0_out, d1_out);

endmodule