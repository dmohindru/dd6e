module ex_5_54(y_out, x1, x2, clk, rst);
    output y_out;
    input x1, x2, clk, rst;
    reg y_out, state, next_state;

    parameter S0 = 1'b0, S1 = 1'b1;

    //present state logic
    always @(posedge clk, negedge rst) 
    begin
        if (!rst) state <= S0; 
        else state <= next_state;
    end

    //next state logic
    always @(state, x1, x2) begin
        case (state)
            S0: begin
                    y_out = 0;
                    case({x1,x2})
                        2'b00, 2'b11: next_state = S1;
                        default: next_state = S0;
                    endcase
                end
            S1: begin
                    y_out = 1;
                    next_state = S0;
                end
        endcase
    end
endmodule

module ex_5_54_tb;
    reg x1, x2, clk, rst;
    wire y_out;

    ex_5_54 UUT(y_out, x1, x2, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        x1 = 1;
        x2 = 0;
        #2 rst = 0;
        #4 rst = 1;
        #40 x2 = 1;
        #90 x1 = 0;
    join
    initial begin $dumpfile("5-54.vcd"); $dumpvars(0, ex_5_54_tb); end

endmodule