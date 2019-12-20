module ex_5_29(out, in, clk, reset);
    output out;
    input in, clk, reset;
    reg out;

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    reg [2:0] state, next_state;

    always @(posedge clk, negedge reset) begin
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

    initial #350 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
    
    #2 reset = 1'b1;
    #3 reset = 1'b0;
    #4 reset = 1'b1;

    in = 1'b0;
    #40 in = 1'b1;
    #90 in = 1'b0;
    #110 in = 1'b1;
    join
    initial begin $dumpfile("5-29.vcd"); $dumpvars(0, ex_5_29_tb); end
endmodule