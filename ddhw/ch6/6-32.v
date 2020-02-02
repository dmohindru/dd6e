module d_ff(q, d, clk, rst);
    output q;
    input d, clk, rst;
    reg q;

    always @ (posedge clk, negedge rst) begin
        if (!rst) q <= 1'b0;
        else q <= d;
    end
endmodule

module mux_2x1(y, x, sel);
    output y;
    input [1:0] x;
    input sel;
    reg y;

    always @(x, sel) 
    begin
        if (sel) y = x[1];
        else y = x[0];
    end
endmodule

module ex_6_32_beh(a, i, load, clk, clear);
    output [3:0] a;
    input [3:0] i;
    input load, clk, clear;
    reg [3:0] a;

    always @(posedge clk, negedge clear) begin
        if (!clear)
            a <= 4'b0000;
        else if(load)
            a <= i;
    end
endmodule

module ex_6_32_str(a, i, load, clk, clear);
    output [3:0] a;
    input [3:0] i;
    input load, clk, clear;
    wire w0, w1, w2, w3;

    mux_2x1 m0(w0, {i[0], a[0]}, load);
    mux_2x1 m1(w1, {i[1], a[1]}, load);
    mux_2x1 m2(w2, {i[2], a[2]}, load);
    mux_2x1 m3(w3, {i[3], a[3]}, load);

    d_ff d0(a[0], w0, clk, clear);
    d_ff d1(a[1], w1, clk, clear);
    d_ff d2(a[2], w2, clk, clear);
    d_ff d3(a[3], w3, clk, clear);

endmodule

module ex_6_32_tb;
    reg load, clk, clear;
    reg [3:0] i;
    wire [3:0] a_beh, a_str;

    ex_6_32_beh UUT0(a_beh, i, load, clk, clear);
    ex_6_32_str UUT1(a_str, i, load, clk, clear);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear = 1;
        load = 0;
        i = 4'b0000;
        #2 clear = 0;
        #3 clear = 1;
        #30 i = 4'b0011;
        #30 load = 1;
        #40 load = 0;
        #50 i = 4'b1010;
        #80 load = 1;
        #90 load = 0;
        #120 clear = 0;
        #121 clear = 1;
        #150 load = 1;
        #160 load = 0;
    join
    initial begin $dumpfile("6-32.vcd"); $dumpvars(0, ex_6_32_tb); end
endmodule