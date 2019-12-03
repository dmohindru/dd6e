//D Flipflop without reset
module D_flipflop(Q, D, Clk);
    output Q;
    input D, Clk;
    reg Q;

    always @(posedge Clk)
        Q <= D;
endmodule

module D_flipflop_tb;
    reg D, Clk;
    wire Q;

    D_flipflop UUT(Q, D, Clk);

    //stimulus block
    initial
        begin
            D = 1'b0;
            Clk = 1'b0;
            #10 Clk = ~Clk;
            #10 D = 1'b1;
            #10 Clk = ~Clk;
            #10 Clk = ~Clk;
        end
    initial $monitor("D = %b, Clk = %b, Q = %b", D, Clk, Q); 

endmodule