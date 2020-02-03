module t_ff(q, q_not, t, clk, reset);
    output q, q_not;
    input t, clk, reset;
    reg q;

    assign q_not = ~q;
    always @(posedge clk, negedge reset) begin
        if (!reset) q <= 1'b0;
        else if(t) q <= ~q;
    end
endmodule

module t_ff_tb;
    reg t, clk, reset;
    wire q, q_not;

    t_ff UUT(q, q_not, t, clk, reset);
    initial #100 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        t = 1'b0;
        #2 reset = 0;
        #3 reset = 1;
        //----------
        #10 t = 1'b1;
        //----------
        #20 t = 1'b0;
        //----------
        #30 t = 1'b1;
    join
    initial begin $dumpfile("tff.vcd"); $dumpvars(0, t_ff_tb); end

endmodule