module fig_25(y, x, clk, rst);
    output y;
    input x, clk, rst;
    reg y;

    parameter a = 3'b000, b = 3'b001, c = 3'b010, d = 3'b011, e = 3'b100, f = 3'b101, g = 3'b110;
    reg [2:0] state, next_state;

    // present state logic
    always @(posedge clk, negedge rst) begin
        if (!rst) state <= a;
        else state <= next_state;
    end

    // next state and output logic
    always @(state, x) begin
        case (state)
            a: begin y = 0; if (x) next_state = b; else next_state = a; end 
            b: begin y = 0; if (x) next_state = d; else next_state = c; end
            c: begin y = 0; if (x) next_state = d; else next_state = a; end
            d: if (x) begin y = 1; next_state = f; end else begin y = 0; next_state = e; end
            e: if (x) begin y = 1; next_state = f; end else begin y = 0; next_state = a; end
            f: if (x) begin y = 1; next_state = f; end else begin y = 0; next_state = g; end
            g: if (x) begin y = 1; next_state = f; end else begin y = 0; next_state = a; end
            default: begin y = 0; next_state = a; end
        endcase
    end
endmodule


module fig_26(y, x, clk, rst);
    output y;
    input x, clk, rst;
    reg y;

    parameter a = 3'b000, b = 3'b001, c = 3'b010, d = 3'b011, e = 3'b100;
    reg [2:0] state, next_state;

    // present state logic
    always @(posedge clk, negedge rst) begin
        if (!rst) state <= a;
        else state <= next_state;
    end

    // next state and output logic
    always @(state, x) begin
        case (state)
            a: begin y = 0; if (x) next_state = b; else next_state = a; end 
            b: begin y = 0; if (x) next_state = d; else next_state = c; end
            c: begin y = 0; if (x) next_state = d; else next_state = a; end
            d: if (x) begin y = 1; next_state = d; end else begin y = 0; next_state = e; end
            e: if (x) begin y = 1; next_state = d; end else begin y = 0; next_state = a; end
            default: begin y = 0; next_state = a; end
        endcase
    end
endmodule

module ex_5_37_tb;
    reg x, clk, rst;
    wire y1, y2;

    fig_25 UUT1(y1, x, clk, rst);
    fig_26 UUT2(y2, x, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
    x = 0;
    rst = 1;
    #1 rst = 0;
    #2 rst = 1;
    //#4 rst = 0;
    //#5 x = 0;
    #10 x = 1;
    #20 x = 1;
    #30 x = 1;
    #40 x = 1;
    #50 x = 0;
    #60 x = 0;
    join

    initial begin $dumpfile("5-37.vcd"); $dumpvars(0, ex_5_37_tb); end
endmodule
