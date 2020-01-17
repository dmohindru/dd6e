module jk_ff(q, j, k, clk, reset);
    output q;
    input j, k, clk, reset;
    reg q;

    always @(posedge clk, negedge reset) begin
        if (!reset) q <= 1'b0;
        else if({j,k} == 2'b00) q <= q;
        else if({j,k} == 2'b01) q <=1'b0;
        else if({j,k} == 2'b10) q <=1'b1;
        else q <= ~q;
    end
endmodule

module jk_ff_tb;
    reg j, k, clk, reset;
    wire q;

    jk_ff UUT(q, j, k, clk, reset);
    initial #100 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        j = 1'b0;
        k = 1'b0; 
        #2 reset = 0;
        #3 reset = 1;
        //----------
        #10 j = 1'b0;
        #10 k = 1'b0;
        //----------
        #20 j = 1'b0;
        #20 k = 1'b1;
        //----------
        #30 j = 1'b1;
        #30 k = 1'b0;
        //----------
        #40 j = 1'b1;
        #40 k = 1'b1;
    join
    initial begin $dumpfile("jkff.vcd"); $dumpvars(0, jk_ff_tb); end

endmodule