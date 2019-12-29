module ex_5_49(y, x, clk, rst);
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
            a: begin y = 0;
               if (x) next_state = c;
               else next_state = b; end
            b: begin y = 1;
               if (x) next_state = d;
               else next_state = c; end 
            c: begin y = 1;
               if (x) next_state = d;
               else next_state = b; end
            d: begin y = 0;
               if (x) next_state = a;
               else next_state = c; end
        endcase
    end
endmodule

module ex_5_49_tb;
    reg x, clk, rst;
    wire y;

    ex_5_49 UUT(y, x, clk, rst);

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
    initial begin $dumpfile("5-49.vcd"); $dumpvars(0, ex_5_49_tb); end

endmodule