module ex_5_38_a(out, x, clk, rst);
    output [1:0] out;
    input x, clk, rst;
    reg [1:0] out, state, next_state;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    // present state logic
    always @(posedge clk, negedge rst) begin
        if (!rst) state <= S0;
        else state <= next_state;
    end 

    // next state logic
    always @(state, x) begin
        case (state)
            S0: begin out = S0; if (x) next_state = S2; else next_state = S0; end
            S1: begin out = S1; if (x) next_state = S0; else next_state = S1; end
            S2: begin out = S2; if (x) next_state = S3; else next_state = S2; end
            S3: begin out = S3; if (x) next_state = S1; else next_state = S3; end
        endcase
    end
endmodule

module ex_5_38_b(out, x, clk, rst);
    output [1:0] out;
    input x, clk, rst;
    reg [1:0] out, state, next_state;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    // present state logic
    always @(posedge clk, negedge rst) begin
        if (!rst) state <= S0;
        else state <= next_state;
    end 

    // next state logic
    always @(state, x) begin
        case (state)
            S0: begin out = S0; if (x) next_state = S3; else next_state = S0; end
            S1: begin out = S1; if (x) next_state = S0; else next_state = S1; end
            S2: begin out = S2; if (x) next_state = S1; else next_state = S2; end
            S3: begin out = S3; if (x) next_state = S2; else next_state = S3; end
        endcase
    end
endmodule

module ex_5_38_tb;
    reg x, clk, rst;
    wire [1:0] ex_16_a, ex_16_b;

    ex_5_38_a UUT1(ex_16_a, x, clk, rst);
    ex_5_38_b UUT2(ex_16_b, x, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
    x = 0;
    rst = 1;
    #1 rst = 0;
    #3 rst = 1;
    //#4 rst = 0;
    #4 x = 1;
    #30 x = 0;
    #50 x = 1;
    join

    initial begin $dumpfile("5-38.vcd"); $dumpvars(0, ex_5_38_tb); end
endmodule