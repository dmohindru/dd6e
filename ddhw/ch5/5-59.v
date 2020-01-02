module d_ff(q, d, clk, rst);
    output q;
    input d, clk, rst;
    reg q;

    always @ (posedge clk, negedge rst) begin
        if (!rst) q <= 1'b0;
        else q <= d;
    end
endmodule

module ex_5_59(out, clk, rst);
    output [2:0] out;
    input clk, rst;
    wire a, b, a_in, b_in;

    d_ff m1(a, a_in, clk, rst);
    d_ff m2(b, b_in, clk, rst);

    assign out = {a, b, 1'b0};
    assign a_in = a ^ b;
    assign b_in = ~b;
endmodule

module ex_5_59_tb;
    reg clk, rst;
    wire [2:0] out;

    ex_5_59 UUT(out, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        #2 rst = 0;
        #4 rst = 1;
        #100 rst = 0;
        #102 rst = 1;
    join
    initial begin $dumpfile("5-59.vcd"); $dumpvars(0, ex_5_59_tb); end

endmodule