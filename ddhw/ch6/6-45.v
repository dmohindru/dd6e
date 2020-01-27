module ex_6_45(out, start, clk, reset_b);
    output out;
    input start, clk, reset_b;
    reg out;
    reg[3:0] state, next_state;

    parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, S4 = 4'b0100, S5 = 4'b0101,
               S6 = 4'b0110, S7 = 4'b0111, S8 = 4'b1000;
    
    // present state logic
    always @(posedge clk, negedge reset_b) begin
        if (!reset_b) state <= S0;
        else state <= next_state;
    end

    //next state logic
    always @(state, start) begin
        out = 1'b0;
        case (state)
            S0: if (start) next_state = S1; else next_state = S0;
            S1: begin next_state = S2; out = 1'b1; end
            S2: begin next_state = S3; out = 1'b1; end
            S3: begin next_state = S4; out = 1'b1; end
            S4: begin next_state = S5; out = 1'b1; end
            S5: begin next_state = S6; out = 1'b1; end
            S6: begin next_state = S7; out = 1'b1; end
            S7: begin next_state = S8; out = 1'b1; end
            S8: begin next_state = S0; out = 1'b1; end
            default: next_state = S0;
        endcase
    end

endmodule

module ex_6_45_tb;
    reg start, clk, reset_b;
    wire out;

    ex_6_45 UUT(out, start, clk, reset_b);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset_b = 1;
        start = 0;
        #2 reset_b = 0;
        #3 reset_b = 1;
        #10 start = 1;
        #20 start = 0;
    join
    initial begin $dumpfile("6-45.vcd"); $dumpvars(0, ex_6_45_tb); end
endmodule