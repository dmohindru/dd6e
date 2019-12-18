module FF_5_25(q, d1, d2, ctr, clk, clear);
    output q;
    input d1, d2, ctr, clk, clear;
    reg q;

    always @(posedge clk) begin
        if(!clear) q <= 1'b0;
        else if(ctr) q <= d2;
        else q <= d1;
    end 

endmodule

module FF_5_25_tb;
    reg clk, clear, ctr, d1, d2;
    wire q;

    FF_5_25 UUT(q, d1, d2, ctr, clk, clear);

initial #200 $finish;

initial begin
    clk = 1'b0;
    repeat (25) #5 clk = ~clk;
end

initial begin
    #15 clear = 1'b0;
    #10 clear = 1'b1; ctr = 1'b1; d1 = 1'b0; d2 = 1'b1;
    #10 ctr = 1'b0;
end

initial $monitor("q = %b, d1 = %b, d2 = %b, ctr = %b, clk = %b, clear = %b", q, d1, d2, ctr, clk, clear);

endmodule