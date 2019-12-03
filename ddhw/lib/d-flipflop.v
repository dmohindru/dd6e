//D Flipflop with negetive reset
module D_flipflop(Q, D, Clk, Rst);
    output Q;
    input D, Clk, Rst;
    reg Q;

    always @(posedge Clk, negedge Rst)
        if (!Rst) Q <= 1'b0;
        else Q <= D;
endmodule

module D_flipflop_tb;
    reg D, Clk, Rst;
    wire Q;

    D_flipflop UUT(Q, D, Clk, Rst);
    
    initial begin 
        Clk = 1'b0;
        Rst = 1;
        D <= 0;
        #10;
        Rst = 0;
        D <= 1;
        Clk = ~Clk;
        #10;
        Rst = 1;
        D <= 1;
        Clk = ~Clk;
        #10;
        D <= 1;
        Clk = ~Clk;
    end 
    initial $monitor("D = %b, Clk = %b, Rst = %b, Q = %b", D, Clk, Rst, Q); 

endmodule