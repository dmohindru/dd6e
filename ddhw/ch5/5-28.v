module ex_2_28_behaviour(out, x, y, clk, reset);
    output out;
    input x, y, clk, reset;

    parameter S0 = 1'b0, S1 = 1'b1;
    reg state, next_state;

    always @(posedge clk) begin
        if (!reset) state <= S0;
        else state <= next_state;
    end

    always @(state, x, y) begin
        case (state)
            S0: if({x,y} == 2'b00 || {x,y} == 2'b11) next_state = S0; else next_state = S1;
            S1: if({x,y} == 2'b00 || {x,y} == 2'b11) next_state = S1; else next_state = S0;
        endcase
    end

    assign out = state; // output of flip flop
endmodule

//D Flipflop with synchronous negetive reset
module D_flipflop(q, d, clk, reset);
    output q;
    input d, clk, reset;
    reg q;

    always @(posedge clk, negedge reset) begin
        if (!reset) q <= 1'b0;
        else q <= d;
    end
endmodule

module ex_2_28_structural(out, x, y, clk, reset);
    output out;
    input x, y, clk, reset;
    wire w1, w2;

    //xor(w1, x, y);
    //xor(w2, w1, out);
    assign w1 = x ^ y;
    assign w2 = w1 ^ out;
    D_flipflop ff(out, w2, clk, reset);
    //D_flipflop ff(out, 1'b1, clk, reset);
endmodule

module ex_28_tb;
    reg x, y, clk, reset;
    wire out_behaviour, out_structural;

    ex_2_28_behaviour UUT1(out_behaviour, x, y, clk, reset);
    ex_2_28_structural UUT2(out_structural, x, y, clk, reset);
    
    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial begin
    reset = 1'b1;
    #15 reset = 1'b0;
    #10 reset = 1'b1; 
    #10 x = 1'b0; y = 1'b0;
    #10 x = 1'b0; y = 1'b1;
    #10 x = 1'b1; y = 1'b1;
    #10 x = 1'b1; y = 1'b0;
    end
    initial begin $dumpfile("5-28.vcd"); $dumpvars(0, ex_28_tb); end

endmodule