module jk_ff(q, j, k, clk, reset);
    output q;
    input j, k, clk, reset;
    reg q;

    always @(posedge clk, negedge reset) begin
        if (!reset) q <= 1'b0;
        else if({j,k} == 2'b00) q <= q;
        else if({j,k} == 2'b01) q <=1'b0;
        else if({j,k} == 2'b10) q <=1'b1;
        else q <= ~q;
    end
endmodule

module ex_6_58_a(a, c_out, i, load, count, clk, clear_b);
    output [3:0] a;
    output c_out;
    input [3:0] i;
    input load, count, clk, clear_b;

    wire i0_not, i1_not, i2_not, i3_not;
    wire w1, w2, w3, w4, w5, w6, w7, w8;
    wire w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19;

    assign i0_not = ~i[0];
    assign i1_not = ~i[1];
    assign i2_not = ~i[2];
    assign i3_not = ~i[3];

    and(w0, count, ~load);
    //----------------
    and(w1, i[0], load);
    and(w2, i0_not, load);

    and(w3, i[1], load);
    and(w4, i1_not, load);

    and(w5, i[2], load);
    and(w6, i2_not, load);

    and(w7, i[3], load);
    and(w8, i3_not, load);
    //----------------

    and(w17, w0, a[0]);
    and(w18, w0, a[0], a[1]);
    and(w19, w0, a[0], a[1], a[2]);

    //---------------------
    or(w9, w0, w1);
    or(w10, w0, w2);

    or(w11, w17, w3);
    or(w12, w17, w4);

    or(w13, w18, w5);
    or(w14, w18, w6);

    or(w15, w19, w7);
    or(w16, w19, w8);
    //--------------------

    jk_ff a0(a[0], w9, w10, clk, clear_b);
    jk_ff a1(a[1], w11, w12, clk, clear_b);
    jk_ff a2(a[2], w13, w14, clk, clear_b);
    jk_ff a3(a[3], w15, w16, clk, clear_b);

    //c_out
    and(c_out, w0, a[0], a[1], a[2], a[3]);

endmodule

module ex_6_58_b(a, c_out, i, load, count, clk, clear_b);
    output [3:0] a;
    output c_out;
    input [3:0] i;
    input load, count, clk, clear_b;
    reg [3:0] a;
    //reg c_out;

    always @(posedge clk, negedge clear_b) 
    begin
        //c_out = count && (a == 4'b1111);
        if (!clear_b)
            a <= 4'b0000;
        else if(load)
            a <= i;
        else if(count)
            a <= a + 1'b1;
    end

    assign c_out = count && (a == 4'b1111);
endmodule

