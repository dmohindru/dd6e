module seq_clk(Q, A, B, C, CLK);
    reg E;
    always @ (posedge CLK)
    begin
        Q = E | C;
        E = A & B;
    end
endmodule