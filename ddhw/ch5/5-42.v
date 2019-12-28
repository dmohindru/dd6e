module d_ff(q, d, clk, rst);
    output q;
    input d, clk, rst;
    reg q;

    always @ (posedge clk, negedge rst) begin
        if (!rst) q <= 1'b0;
        else q <= d;
    end
endmodule

module ex_5_42(y, x, clk, rst);
    output y;
    input x, clk, rst;

    wire a, b, w1, w2, w3, w4, w5;
    and(w1, x, a);
    and(w2, x, b);
    or(w3, w1, w2);

    and(w4, x, ~b);
    or(w5, w1, w4);
    d_ff a_ff(a, w3, clk, rst);
    d_ff b_ff(b, w5, clk, rst);

    //output
    and(y, a, b);
endmodule

module ex_5_42_tb;
    reg x, clk, rst;
    wire y;

    ex_5_42 UUT(y, x, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        x = 0;
        rst = 1;
        #1 rst = 0;
        #3 rst = 1;
        #20 x = 1;
        #30 x = 1;
        #40 x = 0;
        #50 x = 1;
        #60 x = 1;
        #70 x = 1;
        #80 x = 1;
        #90 x = 0;
    join
    initial begin $dumpfile("5-42.vcd"); $dumpvars(0, ex_5_42_tb); end

endmodule