//T Flipflop with negetive reset
module T_flipflop(Q, T, Clk, Rst);
    output Q;
    input T, Clk, Rst;
    
    wire DT;

    assign DT = Q ^ T;

    D_flipflop m1(Q, DT, Clk, Rst);

endmodule

module T_flipflop_tb;
    reg T, Clk, Rst;
    wire Q;

    T_flipflop UUT(Q, T, Clk, Rst);
    
    initial begin 
        Clk = 1'b0;
        Rst = 1;
        T <= 0;
        #10;
        Rst = 0;
        T <= 0;
        Clk = ~Clk;
        #10;
        Rst = 1;
        T <= 0;
        Clk = ~Clk;
        #10 Clk = ~Clk;
        #10;
        Rst = 1;
        T <= 1;
        Clk = ~Clk;
        #10 Clk = ~Clk;
        /*#10;
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
        #10 Clk = ~Clk;*/
    end 
    initial $monitor("T = %b, Clk = %b, Rst = %b, Q = %b", T, Clk, Rst, Q); 

endmodule