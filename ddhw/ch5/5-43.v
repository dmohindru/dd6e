module ex_5_43(out, clk, rst);
    output [2:0] out;
    input clk, rst;
    reg [2:0] out, state, next_state;

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100,
              S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;
    
    // present state logic
    always @(posedge clk, negedge rst) begin
        if (!rst) state <= S0;
        else state <= next_state;
    end

    // next state logic
    always @(state) begin
        case (state)
            S0: begin out = S0; next_state = S1; end
            S1: begin out = S1; next_state = S2; end
            S2: begin out = S2; next_state = S3; end
            S3: begin out = S3; next_state = S4; end
            S4: begin out = S4; next_state = S5; end
            S5: begin out = S5; next_state = S6; end
            S6: begin out = S6; next_state = S7; end
            S7: begin out = S7; next_state = S0; end
        endcase
    end
endmodule

module ex_5_43_tb;
    reg clk, rst;
    wire [2:0] out;

    ex_5_43 UUT(out, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        #1 rst = 0;
        #3 rst = 1;
        #30 rst = 0;
        #32 rst = 1;
    join
    initial begin $dumpfile("5-43.vcd"); $dumpvars(0, ex_5_43_tb); end
endmodule