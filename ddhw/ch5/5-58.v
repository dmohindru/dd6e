module ex_5_58 (y_out, x_in, clk, rst);
    output y_out;
    input x_in, clk, rst;
    reg y_out;
    reg [1:0] state, next_state;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    /present state logic
    always @(posedge clk, negedge rst) 
    begin
        if (!rst) state <= S0; 
        else state <= next_state;
    end

    //next state logic
    always @(state, x_in) begin
        case (state)
            S0: if (x_in) begin y_out = 0; next_state = S1; end 
                else begin y_out = 0; next_state = S0; end
            S1: if (x_in) begin y_out = 0; next_state = S1; end 
                else begin y_out = 0; next_state = S0; end
            S2: if (x_in) begin y_out = 0; next_state = S1; end 
                else begin y_out = 0; next_state = S0; end
            S3: if (x_in) begin y_out = 0; next_state = S1; end 
                else begin y_out = 0; next_state = S0; end

        endcase
    end

endmodule