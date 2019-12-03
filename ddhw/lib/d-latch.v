//Description of D latch
module D_latch(Q, D, enable);
    output Q;
    input D, enable;
    reg Q;

    always @(enable, D)
        if (enable) Q <= D;
endmodule

module D_latch_tb;
    reg D, enable;
    wire Q;

    D_latch UUT(Q, D, enable);

    //stimulus block
    initial
        begin
            D = 1'b0;
            enable = 1'b0;
            //#10 Clk = ~Clk;
            #10 D = 1'b1;
            enable = ~enable;
            #10 D = ~D;
            enable = ~enable;
            #10 enable = ~enable;
        end
    initial $monitor("D = %b, enable = %b, Q = %b", D, enable, Q); 

endmodule