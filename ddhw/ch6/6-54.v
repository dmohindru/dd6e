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

    always @(posedge clk) begin
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
    mux_2x1 m3(m_out3, {s_out, s_out2}, shift_ctrl);

endmodule