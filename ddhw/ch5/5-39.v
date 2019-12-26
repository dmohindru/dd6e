module ex_5_39(y, x, clk, rst);
    output y;
    input x, clk, rst;
    reg y, state, next_state;

    parameter S0 = 1'b0, S1 = 1'b1;

    // present state logic
    always @(posedge clk, negedge rst) begin
        if (!rst) state <= S0;
        else state <= next_state;
    end

    // next state logic
    always @(state, x) begin
        case (state)
        S0: if (x == 1) begin y = 1; next_state = S1; end 
            else if(x == 0) begin y = 0; next_state = S0; end 
        S1: if (x == 1) begin y = 0; next_state = S1; end 
            else if(x == 0) begin y = 1; next_state = S1; end
        endcase
    end
endmodule

module ex_5_39_tb;
    reg x, clk, rst;
    wire y;

    ex_5_39 UUT(y, x, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        x = 0;
        rst = 1;
        #1 rst = 0;
        #3 rst = 1;
        //#4 rst = 0;
        #4 x = 0;
        #10 x = 1;
        #20 x = 0;
        #30 x = 1;
        #40 x = 0;
        #50 x = 1;
    join

    initial begin $dumpfile("5-39.vcd"); $dumpvars(0, ex_5_39_tb); end
endmodule