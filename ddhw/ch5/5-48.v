module ex_5_48(y, x, clk, rst);
    output y;
    input x, clk, rst;
    reg y;
    reg [1:0] state, next_state;

    parameter a = 2'b00, b = 2'b01, c = 2'b10, d = 2'b11;

    // present state logic
    always @(posedge clk, negedge rst) 
    begin
        if (!rst) state <= a; 
        else state <= next_state;
    end

    //next state logic
    always @(state, x) begin
        case (state)
            a: if (x) begin y = 0; next_state = c; end
               else begin y = 1; next_state = b; end
            b: if (x) begin y = 1; next_state = d; end
               else begin y = 0; next_state = c; end 
            c: if (x) begin y = 1; next_state = d; end
               else begin y = 0; next_state = b; end
            d: if (x) begin y = 0; next_state = a; end
               else begin y = 1; next_state = c; end
        endcase
    end
endmodule

module ex_5_48_tb;
    reg x, clk, rst;
    wire y;

    ex_5_48 UUT(y, x, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        x = 0;
        #2 rst = 0;
        #4 rst = 1;
        #10 x = 1;
        #40 x = 0;
        #60 x = 1;
    join
    initial begin $dumpfile("5-48.vcd"); $dumpvars(0, ex_5_48_tb); end

endmodule