module d_ff(q, d, clk, rst);
    output q;
    input d, clk, rst;
    reg q;

    always @ (posedge clk, negedge rst) begin
        if (!rst) q <= 1'b0;
        else q <= d;
    end
endmodule

module ex_6_31_beh(a, i, clk, clear_b);
    output [3:0] a;
    input [3:0] i;
    input clk, clear_b;
    reg [3:0] a;

    always @(posedge clk, negedge clear_b) begin
        if (!clear_b)
            a <= 4'b0000;
        else
            a <= i;
    end
endmodule

module ex_6_31_stru(a, i, clk, clear_b);
    output [3:0] a;
    input [3:0] i;
    input clk, clear_b;
    
    d_ff d0(a[0], i[0], clk, clear_b);
    d_ff d1(a[1], i[1], clk, clear_b);
    d_ff d2(a[2], i[2], clk, clear_b);
    d_ff d3(a[3], i[3], clk, clear_b);
endmodule

module ex_6_31_tb;
    reg clk, reset;
    reg [3:0] i;
    wire [3:0] a_beh, a_stru;

    ex_6_31_beh reg_beh(a_beh, i, clk, reset);
    ex_6_31_stru reg_stru(a_stru, i, clk, reset);

    initial #150 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        i = 4'b1111;
        #2 reset = 0;
        #3 reset = 1;
        #10 i = 4'b1010;
        #30 i = 4'b0011;
        #40 reset = 0;
        #42 reset = 1;
        #50 i = 4'b1101;
    join
    initial begin $dumpfile("6-31.vcd"); $dumpvars(0, ex_6_31_tb); end

endmodule