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

module ex_6_36_beh(a, up, down, clk, clear);
    output [3:0] a;
    input up, down, clk, clear;
    reg [3:0] a;

    always @(posedge clk, negedge clear) begin
        if (!clear)
            a <= 4'b0000;
        else if(up)
            a <= a + 1'b1;
        else if(down)
            a <= a - 1'b1;
    end
endmodule

module ex_6_36_str(a, up, down, clk, clear);
    output [3:0] a;
    input up, down, clk, clear;

    wire down_out, a0_not, a1_not, a2_not, a3_not, t0_in, t1_in, t2_in, t3_in;
    wire w2, w3, w4, w5, w6, w7;
    
    and(down_out, down, ~up);

    //input to t0
    or(t0_in, up, down_out);
    
    //input to t1
    and(w2, down_out, a0_not);
    and(w3, up, a[0]);
    or(t1_in, w2, w3);

    //input to t2
    and(w4, w2, a1_not);
    and(w5, w3, a[1]);
    or(t2_in, w4, w5);

    //input to t3
    and(w6, w4, a2_not);
    and(w7, w5, a[2]);
    or(t3_in, w6, w7);

    t_ff t0(a[0], a0_not, t0_in, clk, clear);
    t_ff t1(a[1], a1_not, t1_in, clk, clear);
    t_ff t2(a[2], a2_not, t2_in, clk, clear);
    t_ff t3(a[3], a3_not, t3_in, clk, clear);

endmodule

module ex_6_36_tb;
    reg up, down, clk, clear;
    wire [3:0] a_beh, a_str;

    ex_6_36_beh UUT0(a_beh, up, down, clk, clear);
    ex_6_36_str UUT1(a_str, up, down, clk, clear);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear = 1;
        up = 0;
        down = 0;
        #2 clear = 0;
        #3 clear = 1;
        #30 up = 1;
        #100 clear = 0;
        #102 clear = 1;
        #130 up = 0;
        #130 down = 1;
    join
    initial begin $dumpfile("6-36.vcd"); $dumpvars(0, ex_6_36_tb); end

endmodule