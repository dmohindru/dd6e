module ex_6_47(p_out, d_in, clk, reset);
    output p_out;
    input d_in, clk, reset;
    reg p_out;

    always @(posedge clk, negedge reset) begin
        if(!reset)
            p_out <= 1'b0;
        else
            p_out <= p_out ^ d_in;
    end

endmodule

module ex_6_47_tb;
    reg d_in, clk, reset;
    wire p_out;

    ex_6_47 UUT(p_out, d_in, clk, reset);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        d_in = 0;
        #2 reset = 0;
        #3 reset = 1;
        #10 d_in = 1;
    join
    initial begin $dumpfile("6-47.vcd"); $dumpvars(0, ex_6_47_tb); end
endmodule