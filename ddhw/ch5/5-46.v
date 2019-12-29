module ex_5_46(y_out, x_in, clk, rst);
    output y_out;
    input x_in, clk, rst;
    reg y_out;
    reg [2:0] state, next_state;

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;

    // present state logic
    always @(posedge clk) begin
        if (!rst) state <= S0;
        else state <= next_state;
    end

    //next state logic
    always @(state, x_in) begin
        case (state)
            S0: begin y_out = 0; if (x_in) next_state = S1; else next_state = S0; end
            S1: begin y_out = 1; next_state = S2; end
            S2: begin y_out = 1; next_state = S3; end
            S3: begin y_out = 1; next_state = S4; end
            S4: begin y_out = 0; next_state = S5; end
            S5: begin y_out = 0; next_state = S0; end
            default: begin y_out = 0; next_state = S0; end
        endcase
    end
endmodule

module ex_5_46_tb;
    reg x_in, clk, rst;
    wire y_out;

    ex_5_46 UUT(y_out, x_in, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        x_in = 0;
        rst = 0;
        #6 rst = 1;
        #20 x_in = 1;
        #30 x_in = 0;
        #40 x_in = 1;
        #50 x_in = 0;
        #80 x_in = 1;
        #90 x_in = 0;
    join
    initial begin $dumpfile("5-46.vcd"); $dumpvars(0, ex_5_46_tb); end

endmodule