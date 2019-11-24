module mux_16x1(y, s, d);
    output y;
    input [3:0] s;
    input [15:0] d;

    mux_8x1 m1(mux0_out, s[2:0], d[7:0]);
    mux_8x1 m2(mux1_out, s[2:0], d[15:8]);

    mux_2x1 m3(y, s[3], {mux1_out, mux0_out});

endmodule
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

module mux_16x1_tb;
    reg [15:0] in;
    reg [3:0]s;
    wire y;
    
    //Instantiate UUT
    mux_16x1 UUT(y, s, in);

    //stimulus block
    initial
        begin
            in = 16'b0101010101010101;
            s = 4'b0000;
            repeat (15) #10 s = s + 1'b1;
            
        end
    initial $monitor("in = %b, s = %b, y = %b", in, s, y);
endmodule


/*
module mux_8x1_tb;
    reg [7:0] in;
    reg [2:0]s;
    wire y;
    
    //Instantiate UUT
    mux_8x1 UUT(y, s, in);

    //stimulus block
    initial
        begin
            in = 8'b01010101;
            s = 3'b000;
            repeat (7) #10 s = s + 1'b1;
            
        end
    initial $monitor("in = %b, s = %b, y = %b", in, s, y);
endmodule
*/
/*
module mux_2x1_tb;
    reg [1:0] in;
    reg s;
    wire y;
    
    //Instantiate UUT
    mux_2x1 UUT(y, s, in);

    //stimulus block
    initial
        begin
            in = 2'b01;
            s = 1'b0;
            #10 s = 1'b1;
            
        end
    initial $monitor("in = %b, s = %b, y = %b", in, s, y);
endmodule
*/