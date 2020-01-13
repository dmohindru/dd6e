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