module ex_5_50(y_out, x_in, clk, rst);
    output y_out;
    input x_in, clk, rst;
    reg y_out;
    reg [2:0] state, next_state;

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

    // present state logic
    always @(posedge clk, negedge rst) 
    begin
        if (!rst) state <= S0; 
        else state <= next_state;
    end

    //next state logic
    always @(state, x_in) begin
        case (state)
            S0: begin y_out = 0;
                if (x_in) next_state = S1;
                else next_state = S0; end
            S1: begin y_out = 0;
                if (x_in) next_state = S2;
                else next_state = S1; end 
            S2: begin y_out = 1;
                if (x_in) next_state = S3;
                else next_state = S2; end
            S3: begin y_out = 1;
                if (x_in) next_state = S4;
                else next_state = S3; end
            S4: begin y_out = 0;
                next_state = S0;
                end
            default: begin y_out = 0;
                     next_state = S0;
                     end 
        endcase
    end
endmodule 

module ex_5_50_tb;
    reg x_in, clk, rst;
    wire y_out;

    ex_5_50 UUT(y_out, x_in, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        x_in = 0;
        #2 rst = 0;
        #4 rst = 1;
        #10 x_in = 1;
        #20 x_in = 1;
        #30 x_in = 1;
        #40 x_in = 1;
        //---------------
        #50 x_in = 0;
        #60 x_in = 1;
        #70 x_in = 0;
        #80 x_in = 0;
        #90 x_in = 1;
        #100 x_in = 0;
        #110 x_in = 0;
        #120 x_in = 1;
        #130 x_in = 0;
        #140 x_in = 1;
        #150 x_in = 1;
        #160 x_in = 0;
    join
    initial begin $dumpfile("5-50.vcd"); $dumpvars(0, ex_5_50_tb); end

endmodule