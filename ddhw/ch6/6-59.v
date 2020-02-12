module d_ff(q, d, clk, rst);
    output q;
    input d, clk, rst;
    reg q;

    always @ (posedge clk, negedge rst) begin
        if (!rst) q <= 1'b0;
        else q <= d;
    end
endmodule

module ex_6_59_a(out, clk, reset);
    output [7:0] out;
    input clk, reset;

    wire a_out, b_out, c_out, e_out; 

    d_ff a(a_out, ~e_out, clk, reset);
    d_ff b(b_out, a_out, clk, reset);
    d_ff c(c_out, b_out, clk, reset);
    d_ff e(e_out, c_out, clk, reset);

    assign out[7] = ~a_out & ~e_out;
    assign out[6] = a_out & ~b_out;
    assign out[5] = b_out & ~c_out;
    assign out[4] = c_out & ~e_out;
    assign out[3] = a_out & e_out;
    assign out[2] = ~a_out & b_out;
    assign out[1] = ~b_out & c_out;
    assign out[0] = ~c_out & e_out;

endmodule

module ex_6_59_b(out, clk, reset);
    output [7:0] out;
    input clk, reset;
    reg [7:0] out;

    always @(posedge clk, negedge reset) begin
        if (!reset)
            out <= 8'b1000_0000;
        else
            out <= {out[0], out[7:1]};
    end
endmodule

module ex_6_59_tb;
    reg clk, reset;
    wire t0_a, t1_a, t2_a, t3_a, t4_a, t5_a, t6_a, t7_a;
    wire t0_b, t1_b, t2_b, t3_b, t4_b, t5_b, t6_b, t7_b;

    ex_6_59_a UUT0({t0_a, t1_a, t2_a, t3_a, t4_a, t5_a, t6_a, t7_a}, clk, reset);
    ex_6_59_b UUT1({t0_b, t1_b, t2_b, t3_b, t4_b, t5_b, t6_b, t7_b}, clk, reset);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        #2 reset = 0;
        #3 reset = 1;
        
    join
    initial begin $dumpfile("6-59.vcd"); $dumpvars(0, ex_6_59_tb); end


endmodule