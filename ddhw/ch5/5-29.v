module ex_5_29(out, in, clk, reset);
    output out;
    input in, clk, reset;
    reg out;

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (!reset) state <= S0;
        else state <= next_state;
    end

    always @(state, in) begin
        case(state)
            S0:
                if (in) begin out = 1; next_state = S4; end 
                else begin out = 0; next_state = S3; end
            S1:
                if (in) begin out = 1; next_state = S4; end 
                else begin out = 0; next_state = S1; end
            S2:
                if (in) begin out = 1; next_state = S0; end 
                else begin out = 0; next_state = S2; end
            S3:
                if (in) begin out = 1; next_state = S2; end 
                else begin out = 0; next_state = S1; end
            S4:
                if (in) begin out = 0; next_state = S3; end 
                else begin out = 0; next_state = S2; end
        endcase
    end
endmodule

module ex_5_29_tb;
    reg in, clk, reset;
    wire out;

    ex_5_29 UUT(out, in, clk, reset);

    initial #100 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial begin
    reset = 1'b1;
    #15 reset = 1'b0;
    #10 reset = 1'b1; in = 1'b0;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    end
    initial begin $dumpfile("5-29.vcd"); $dumpvars(0, ex_5_29_tb); end
endmodule