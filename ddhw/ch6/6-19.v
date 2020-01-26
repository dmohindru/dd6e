/* Test for verifying solution to ex problem 6-19 */

module d_ff(q, q_not, d, clk, rst);
    output q, q_not;
    input d, clk, rst;
    reg q;

    assign q_not = ~q;
    always @ (posedge clk, negedge rst) begin
        if (!rst) q <= 1'b0;
        else q <= d;
    end
endmodule

module jk_ff(q, q_not, j, k, clk, reset);
    output q, q_not;
    input j, k, clk, reset;
    reg q;

    assign q_not = ~q;

    always @(posedge clk, negedge reset) begin
        if (!reset) q <= 1'b0;
        else if({j,k} == 2'b00) q <= q;
        else if({j,k} == 2'b01) q <=1'b0;
        else if({j,k} == 2'b10) q <=1'b1;
        else q <= ~q;
    end
endmodule

module bcd_counter_jk(count, clk, reset);
    output [3:0] count;
    input clk, reset;

    wire q1, q1_not, q2, q2_not, q4, q4_not, q8, q8_not;
    wire q2_j, q2_k, q4_j, q4_k, q8_j, q8_k;

    assign q2_j = q8_not&q1;
    assign q2_k = q1;

    assign q4_j = q2&q1;
    assign q4_k = q2&q1;

    assign q8_j = q1&q2&q4;
    assign q8_k = q1;
    
    jk_ff q1ff(q1, q1_not, 1'b1, 1'b1, clk, reset);
    jk_ff q2ff(q2, q2_not, q2_j, q2_k, clk, reset);
    jk_ff q4ff(q4, q4_not, q4_j, q4_k, clk, reset);
    jk_ff q8ff(q8, q8_not, q8_j, q8_k, clk, reset);

    assign count = {q8, q4, q2, q1};
endmodule

module bcd_counter_d(count, clk, reset);
    output [3:0] count;
    input clk, reset;

    wire q1, q1_not, q2, q2_not, q4, q4_not, q8, q8_not;
    wire q2_d, q4_d, q8_d;

    assign q2_d = (q8_not&q2_not&q1) | (q2&q1_not);

    assign q4_d = (q4_not&q2&q1) | (q4&q2_not) | (q4&q1_not);

    assign q8_d = (q4&q2&q1) | (q8&q1_not);
    
    d_ff q1ff(q1, q1_not, q1_not, clk, reset);
    d_ff q2ff(q2, q2_not, q2_d, clk, reset);
    d_ff q4ff(q4, q4_not, q4_d, clk, reset);
    d_ff q8ff(q8, q8_not, q8_d, clk, reset);

    assign count = {q8, q4, q2, q1};
endmodule

module counter_tb;
    reg clk, reset;
    wire [3:0] count_jk, count_d;

    bcd_counter_jk UUT(count_jk, clk, reset);
    bcd_counter_d UUT1(count_d, clk, reset);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        #2 reset = 0;
        #3 reset = 1;
    join
    initial begin $dumpfile("6-19.vcd"); $dumpvars(0, counter_tb); end


endmodule