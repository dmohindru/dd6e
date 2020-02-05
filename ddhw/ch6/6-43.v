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

module shift_reg(so, si, shift_ctr, clk, reset);
    output so;
    input si, shift_ctr, clk, reset;

    mux_2x1 m0(m0_out, {si, d0_out}, shift_ctr);
    mux_2x1 m1(m1_out, {d0_out, d1_out}, shift_ctr);
    mux_2x1 m2(m2_out, {d1_out, d2_out}, shift_ctr);
    mux_2x1 m3(m3_out, {d2_out, d3_out}, shift_ctr);

    d_ff d0(d0_out, m0_out, clk, reset);
    d_ff d1(d1_out, m1_out, clk, reset);
    d_ff d2(d2_out, m2_out, clk, reset);
    d_ff d3(d3_out, m3_out, clk, reset);

    assign so = d3_out;

endmodule

module ex_6_43_tb;
    reg si, shift_ctr, clk, reset;
    wire so1, so2;

    shift_reg s0(so1, si, shift_ctr, clk, reset);
    shift_reg s1(so2, so1, shift_ctr, clk, reset);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        shift_ctr = 0;
        si = 0;
        #2 reset = 0;
        #3 reset = 1;
        #10 shift_ctr = 1;
        #10 si = 1;
    join
    initial begin $dumpfile("6-43.vcd"); $dumpvars(0, ex_6_43_tb); end
    
endmodule