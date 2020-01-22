module jk_ff(q, q_not, j, k, clk, reset);
    output q, q_not;
    input j, k, clk, reset;
    reg q;

    assign q_not = ~q;

    always @(negedge clk, negedge reset) begin
        if (!reset) q <= 1'b0;
        else if({j,k} == 2'b00) q <= q;
        else if({j,k} == 2'b01) q <=1'b0;
        else if({j,k} == 2'b10) q <=1'b1;
        else q <= ~q;
    end
endmodule

module bcd_ripple_counter(count, clk, reset);
    output [3:0] count;
    input clk, reset;

    wire q1, q1_not, q2, q2_not, q4, q4_not, q8, q8_not, q2_q4_and;
    and(q2_q4_and, q2, q4);
    jk_ff ffq1(q1, q1_not, 1'b1, 1'b1, clk, reset);
    jk_ff ffq2(q2, q2_not, q8_not, 1'b1, q1, reset);
    jk_ff ffq4(q4, q4_not, 1'b1, 1'b1, q2, reset);
    jk_ff ffq8(q8, q8_not, q2_q4_and, 1'b1, q1, reset);

    assign count = {q8, q4, q2, q1};
endmodule

module bcd_ripple_counter_tb;
    reg clk, reset;
    wire [3:0] count;

    bcd_ripple_counter UUT(count, clk, reset);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        #2 reset = 0;
        #3 reset = 1;
    join
    initial begin $dumpfile("6-55.vcd"); $dumpvars(0, bcd_ripple_counter_tb); end
endmodule
