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

module ex_6_56(a_out, cout, count_enable, clk, clear_b);
    output [3:0] a_out;
    output cout;
    input count_enable, clk, clear_b;
    wire a1_en, a2_en, a3_en;

    and(a1_en, count_enable, a_out[0]);
    and(a2_en, a1_en, a_out[1]);
    and(a3_en, a2_en, a_out[2]);

    jk_ff A0(a_out[0], count_enable, count_enable, clk, clear_b);
    jk_ff A1(a_out[1], a1_en, a1_en, clk, clear_b);
    jk_ff A2(a_out[2], a2_en, a2_en, clk, clear_b);
    jk_ff A3(a_out[3], a3_en, a3_en, clk, clear_b);

    and(cout, a3_en, a_out[3]);

endmodule


module ex_6_56_tb;
    reg count_enable, clk, clear_b;
    wire cout;
    wire [3:0] a_out;

    ex_6_56 UUT(a_out, cout, count_enable, clk, clear_b);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        count_enable = 0;
        #2 clear_b = 0;
        #3 clear_b = 1;
        #30 count_enable = 1;
    join
    initial begin $dumpfile("6-56.vcd"); $dumpvars(0, ex_6_56_tb); end
endmodule