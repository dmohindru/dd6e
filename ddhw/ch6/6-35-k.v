module d_ff(q, q_not, d, clk, rst);
    output q, q_not;
    input d, clk, rst;
    reg q;

    assign q_not = ~q;
    always @ (negedge clk, negedge rst) begin
        if (!rst) q <= 1'b0;
        else q <= d;
    end
endmodule

module ripple_counter(count, clk, reset);
    output [3:0] count;
    input clk, reset;

    wire a3_not, a2_not, a1_not, a0_not;
    d_ff a0(count[0], a0_not, a0_not, clk, reset);
    d_ff a1(count[1], a1_not, a1_not, count[0], reset);
    d_ff a2(count[2], a2_not, a2_not, count[1], reset);
    d_ff a3(count[3], a3_not, a3_not, count[2], reset);
endmodule

module bcd_ripple_counter(count, clk, reset);
    output [3:0] count;
    input clk, reset;

    wire clear_count;
    nand(clear_count, reset, ~count[3], ~count[1]);
    ripple_counter m0(count, clk, clear_count);

endmodule

module bcd_ripple_counter_beh(count, clk, reset);
    output [3:0] count;
    input clk, reset;
    reg [3:0] count;
    
    always @(negedge clk, negedge reset) begin
        if (!reset)
            count <= 4'b0000;
        else if (count >= 9)
            count <= 4'b0000;
        else
            count = count + 1'b1;
    end

endmodule

module ripple_counter_tb;
    reg clk, reset;
    wire [3:0] count;

    bcd_ripple_counter_beh UUT(count, clk, reset);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        #2 reset = 0;
        #3 reset = 1;
    join
    initial begin $dumpfile("6-35-k.vcd"); $dumpvars(0, ripple_counter_tb); end

endmodule