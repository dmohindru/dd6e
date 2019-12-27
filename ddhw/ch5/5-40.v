module ex_5_40(out, E, F, clk, rst);
    output [1:0] out;
    input E, F, clk, rst;
    reg [1:0] out, state, next_state;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

     // present state logic
    always @(posedge clk, negedge rst) begin
        if (!rst) state <= S0;
        else state <= next_state;
    
    end

    // next state logic
    always @(state, E, F) begin
        case (state)
        S0: begin out = S0;
            if (E == 0) next_state = S0; 
            else if ({E,F} == 2'b11) next_state = S3; 
            else if({E,F} == 2'b10) next_state = S1;
            end
        
        S1: begin out = S1;
            if (E == 0) next_state = S1; 
            else if ({E,F} == 2'b11) next_state = S0; 
            else if({E,F} == 2'b10) next_state = S2;
            end
        
        S2: begin out = S2;
            if (E == 0) next_state = S2; 
            else if ({E,F} == 2'b11) next_state = S1; 
            else if({E,F} == 2'b10) next_state = S3;
            end
        
        S3: begin out = S3;
            if (E == 0) next_state = S3; 
            else if ({E,F} == 2'b11) next_state = S2; 
            else if({E,F} == 2'b10) next_state = S0;
            end
        endcase
        
    end
endmodule

module ex_5_40_tb;
    reg E, F, clk, rst;
    wire [1:0] out;

    ex_5_40 UUT(out, E, F, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        E = 0;
        F = 0;
        rst = 1;
        #1 rst = 0;
        #3 rst = 1;
        #4 E = 1;
        #20 E = 0;
        #40 E = 1;
        #60 F = 1;
        #100 E = 0;
    join

    initial begin $dumpfile("5-40.vcd"); $dumpvars(0, ex_5_40_tb); end
endmodule