//D Flipflop with negetive reset
module JK_flipflop(Q, J, K, Clk, Rst);
    output Q;
    input J, K, Clk, Rst;
    
    wire JK;

    assign JK = (J & ~Q) | (~K & Q);

    D_flipflop m1(Q, JK, Clk, Rst);

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