module ex_6_34(so, si, clk, reset);
    output so;
    input si, clk, reset;
    reg [3:0] state;

    assign so = state[0];
    always @(posedge clk, negedge reset) begin
        if (!reset)
            state <= 4'b0000;
        else
            state <= {si, state[3:1]};
    end

endmodule

module ex_6_34_tb;
    reg si, clk, reset;
    output so;

    ex_6_34 UUT(so, si, clk, reset);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        si = 1;
        #2 reset = 0;
        #3 reset = 1;
        #20 si = 0;
        #30 si = 1;
        #40 si = 0;
        #50 reset = 0;
        #52 reset = 1;
        #60 si = 0;
        #70 si = 1;
        #80 si = 0;
        #90 si = 1;
    join
    initial begin $dumpfile("6-34.vcd"); $dumpvars(0, ex_6_34_tb); end

endmodule