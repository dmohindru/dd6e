module D_FF(q, d, clk, clear, preset);
    output q;
    input d, clk, clear, preset;
    reg q;

    always @(posedge clk) begin
        if (!clear) q <= 1'b0;
        else if(!preset) q <= 1'b1;
        else q <= d;
    end
endmodule

module D_FF_tb;
reg clk, clear, preset, d;
wire q;

D_FF UUT(q, d, clk, clear, preset);

initial #200 $finish;

initial begin
    //d = 1'b0;
    clk = 1'b0;
    //clear = 1'b1;
    //preset = 1'b1;
    //repeat (20) #5 clk = ~clk;
    repeat (25) #5 clk = ~clk;
end

initial begin
    #15 clear = 1'b0;
    #10 preset = 1'b0; clear = 1'b1;
    #10 d = 1'b0; preset = 1'b1;
    #10 d = 1'b1;
    #10 clear = 1'b0;
    #10 clear = 1'b1;
    #10 d = 1'b0;
    #10 preset = 1'b0;
    #10 preset = 1'b1;
    #10 d = 1'b1;
end

initial $monitor("q = %b, d = %b, clk = %b, clear = %b, preset = %b", q, d, clk, clear, preset); 

endmodule