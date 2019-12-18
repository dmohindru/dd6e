module JK_FF(q, j, k, clk, reset);
    output q;
    input j, k, clk, reset;
    reg q;

    always @(posedge clk) begin
        if (!reset) q <= 1'b0;
        else if({j,k} == 2'b00) q <= q;
        else if({j,k} == 2'b01) q <=1'b0;
        else if({j,k} == 2'b10) q <=1'b1;
        else q <= ~q;
    end
endmodule

module JK_FF_tb;
    reg j, k, clk, reset;
    wire q;

    JK_FF UUT(q, j, k, clk, reset);

    initial #200 $finish;

    initial begin
        clk = 1'b0;
        repeat (25) #5 clk = ~clk;
    end

    initial begin
        #15 reset = 1'b0; j = 1'b0; k = 1'b0;
        #10 reset = 1'b1; j = 1'b1; k = 1'b0;
        #10 j = 1'b0; k = 1'b1;
        #10 j = 1'b1; k = 1'b1;
    end

    initial $monitor("q = %b, j = %b, k = %b, clk = %b, reset = %b", q, j, k, clk, reset);
endmodule