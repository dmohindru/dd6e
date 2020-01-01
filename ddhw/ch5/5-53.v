/*
// Normal mealy machine
module ex_5_53(y_out, x_in, clk, rst);
    output y_out;
    input x_in, clk, rst;
    reg y_out;
    reg [1:0] state, next_state;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    //present state logic
    always @(posedge clk, negedge rst) 
    begin
        if (!rst) state <= S0; 
        else state <= next_state;
    end

    //next state logic
    always @(state, x_in) begin
        case (state)
            S0: if(x_in) begin y_out = 0; next_state = S1; end else begin y_out = 1; next_state = S0; end
            S1: if(x_in) begin y_out = 0; next_state = S2; end else begin y_out = 0; next_state = S1; end
            S2: if(x_in) begin y_out = 1; next_state = S3; end else begin y_out = 0; next_state = S2; end
            S3: if(x_in) begin y_out = 0; next_state = S1; end else begin y_out = 1; next_state = S0; end
        endcase
    end

endmodule*/

//registered or synchoronous mealy machine
module ex_5_53(y_out, x_in, clk, rst);
    output y_out;
    input x_in, clk, rst;
    reg y_out, out;
    reg [1:0] state, next_state;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    //present state logic
    always @(posedge clk, negedge rst) 
    begin
        if (!rst) begin state <= S0; y_out <= 1; end 
        else begin state <= next_state; y_out <= out; end
    end

    //next state logic
    always @(state, x_in) begin
        case (state)
            S0: if(x_in) begin out = 0; next_state = S1; end else begin out = 1; next_state = S0; end
            S1: if(x_in) begin out = 0; next_state = S2; end else begin out = 0; next_state = S1; end
            S2: if(x_in) begin out = 1; next_state = S3; end else begin out = 0; next_state = S2; end
            S3: if(x_in) begin out = 0; next_state = S1; end else begin out = 1; next_state = S0; end
        endcase
    end

endmodule

module ex_5_53_tb;
    reg x_in, clk, rst;
    wire y_out;

    ex_5_53 UUT(y_out, x_in, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        x_in = 0;
        #2 rst = 0;
        #4 rst = 1;
        #10 x_in = 1;
        //#17 x_in = 0;
        #20 x_in = 1;
        //#27 x_in = 0;
        #30 x_in = 1;
        #37 x_in = 0;
        //-----------
        /*#40 x_in = 1;
        #47 x_in = 0;
        #50 x_in = 1;
        #57 x_in = 0;
        #60 x_in = 1;
        #67 x_in = 0; */
        //#110 x_in = 1;
        //-------------
        #70 x_in = 1;
        #77 x_in = 0;
        #80 x_in = 1;
        #87 x_in = 0;
        #90 x_in = 1;
        #97 x_in = 0;
        //-------------
        #100 x_in = 0;

    join
    initial begin $dumpfile("5-53.vcd"); $dumpvars(0, ex_5_53_tb); end
endmodule