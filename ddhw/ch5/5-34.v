//JK Flip Flop with negetive reset
module JK_flipflop(Q, J, K, Clk, Rst);
    output Q;
    input J, K, Clk, Rst;

    wire JK, k_not;

    not (k_not, K);
    mux_2x1 m1(JK, Q, {k_not, J} );
    D_flipflop m2(Q, JK, Clk, Rst);

endmodule

//D Flipflop with negetive reset
module D_flipflop(Q, D, Clk, Rst);
    output Q;
    input D, Clk, Rst;
    reg Q;

    always @(posedge Clk, negedge Rst)
        if (!Rst) Q <= 1'b0;
        else Q <= D;
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

module JK_flipflop_tb;
    reg J, K, Clk, Rst;
    wire Q;

    JK_flipflop UUT(Q, J, K, Clk, Rst);
    
    initial begin 
        Clk = 1'b0;
        Rst = 1;
        J <= 0;
        K <= 0;
        #10;
        Rst = 0;
        J <= 0;
        K <= 0;
        Clk = ~Clk;
        #10;
        Rst = 1;
        J <= 0;
        K <= 0;
        Clk = ~Clk;
        #10 Clk = ~Clk;
        #10;
        Rst = 1;
        J <= 0;
        K <= 1;
        Clk = ~Clk;
        #10 Clk = ~Clk;
        #10;
        Rst = 1;
        J <= 1;
        K <= 0;
        Clk = ~Clk;
        #10 Clk = ~Clk;
        #10;
        Rst = 1;
        J <= 1;
        K <= 1;
        Clk = ~Clk;
        #10 Clk = ~Clk;
    end 
    initial $monitor("J = %b, K = %b, Clk = %b, Rst = %b, Q = %b", J, K, Clk, Rst, Q); 

endmodule