module ex_5_45(y, x, clk, rst);
    output y;
    input x, clk, rst;
    reg y;
    reg [1:0] state, next_state;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    // present state logic
    always @(posedge clk, negedge rst) begin
        if (!rst) state <= S0;
        else state <= next_state;
    end

    // next state logic
    always @(state, x) begin
        case (state)
            S0: begin y = 0; if(x == 1) next_state = S1; else if (x == 0) next_state = S0; end
            S1: begin y = 0; if(x == 1) next_state = S2; else if (x == 0) next_state = S0; end
            S2: begin y = 0; if(x == 1) next_state = S3; else if (x == 0) next_state = S0; end
            S3: begin y = 1; if(x == 1) next_state = S3; else if (x == 0) next_state = S0; end
        endcase
    end
endmodule


module ex_5_45_tb;
    reg x, clk, rst;
    wire y;

    ex_5_45 UUT(y, x, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        x = 0;
        rst = 1;
        #1 rst = 0;
        #3 rst = 1;
        #20 x = 1;
        #30 x = 1;
        #40 x = 0;
        #50 x = 1;
        #60 x = 1;
        #70 x = 1;
        #80 x = 1;
        #90 x = 0;
    join
    initial begin $dumpfile("5-45.vcd"); $dumpvars(0, ex_5_45_tb); end

endmodule