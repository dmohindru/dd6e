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

//right shift register
module rshift_4(s_out, s_in, shift_ctrl, clear_b, clk);
    output s_out;
    input s_in, shift_ctrl, clear_b, clk;

    wire s_out0, s_out1, s_out2, m_out0, m_out1, m_out2, m_out3;

    d_ff d0(s_out0, m_out0, clk, clear_b);
    d_ff d1(s_out1, m_out1, clk, clear_b);
    d_ff d2(s_out2, m_out2, clk, clear_b);
    d_ff d3(s_out, m_out3, clk, clear_b);

    mux_2x1 m0(m_out0, {s_in, s_out0}, shift_ctrl);
    mux_2x1 m1(m_out1, {s_out0, s_out1}, shift_ctrl);
    mux_2x1 m2(m_out2, {s_out1, s_out2}, shift_ctrl);
    mux_2x1 m3(m_out3, {s_out2, s_out}, shift_ctrl);

endmodule

<<<<<<< HEAD
/*module sadder_4(s_out, s_in, shift_ctrl, clear_b, clk);
=======


module sadder_4(s_out, s_in, shift_ctrl, clear_b, clk);
>>>>>>> 4bd5086ce0ff854959cb86f131e03e151da8bb4a
    output s_out;
    input s_in, shift_ctrl, clear_b, clk;

    wire s_out_a, s_out_b, s_out_c, ff_clk_in, ff_j_in, ff_k_in;

    rshift_4 a(s_out_a, s_out, shift_ctrl, clear_b, clk);
    //rshift_4 a(s_out_a, s_in, shift_ctrl, clear_b, clk);
    rshift_4 b(s_out_b, s_in, shift_ctrl, clear_b, clk);

    and(ff_clk_in, shift_ctrl, clk);
    and(ff_j_in, s_out_a, s_out_b);
    nor(ff_k_in, s_out_a, s_out_b);

    jk_ff c(s_out_c, ff_j_in, ff_k_in, ff_clk_in, clear_b);
    
    xor(s_out, s_out_a, s_out_b, s_out_c);

endmodule
*/

module sadder_4(s_out, s_in, shift_ctrl, clear_b, clk);
    output s_out;
    input s_in, shift_ctrl, clear_b, clk;

    reg carry;
    reg [3:0] a, b;

    always @(posedge clk, negedge clear_b) begin
        if (!clear_b) begin
            carry <= 1'b1;
            a <= 4'b0000;
            b <= 4'b0000;
        end
        else if (shift_ctrl) begin
            b <= {s_in, b[3:1]};
            a[2:0] <= a[3:1];
            {carry,a[3]} = a[0] + b[0] + carry;
        end
    end
    assign s_out = a[0];

endmodule


module sadder_4_tb;
    reg s_in, shift_ctrl, clear_b, clk;
    wire s_out;

    sadder_4 UUT(s_out, s_in, shift_ctrl, clear_b, clk);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        shift_ctrl = 0;
        s_in = 0;
        #2 clear_b = 0;
        #3 clear_b = 1;
        //load 1010
        #10 shift_ctrl = 1;
        #10 s_in = 0;
        #20 s_in = 1;
        #30 s_in = 0;
        #40 s_in = 1;
        //load 0011
        #50 s_in = 1;
        #60 s_in = 1;
        #70 s_in = 0;
        #80 s_in = 0;
        //perform addition
        #90 s_in = 0;
        #100 s_in = 0;
        #110 s_in = 0;
        #120 s_in = 0;
    join
    initial begin $dumpfile("6-54.vcd"); $dumpvars(0, sadder_4_tb); end

endmodule