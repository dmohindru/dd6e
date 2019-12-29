module ex_5_44(q, d, clk, rst);
    output q;
    input d, clk, rst;
    reg q;

    always @(posedge clk) begin
        if (!rst) q <= 1'b0;
        else q <= d;
    end

endmodule

module ex_5_44_tb;
    reg d, clk, rst;
    wire q;

    ex_5_44 UUT(q, d, clk, rst);
    initial #100 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        #1 rst = 0;
        #10 rst = 1;
        #10 d = 1;
        #30 d = 0;
        #40 rst = 0;
        #46 rst = 1;
        #50 d = 1;
    join
    initial begin $dumpfile("5-44.vcd"); $dumpvars(0, ex_5_44_tb); end
endmodule