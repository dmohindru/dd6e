module ex_6_51(dected, sin, clk, reset);
    output dected;
    input sin, clk, reset;
    reg [2:0] sequence;

    assign dected = (sequence == 3'b111);

    always @(posedge clk, negedge reset) begin
        if (!reset)
            sequence <= 3'b000;
        else
            sequence <= {sin, sequence[2:1]};
    end

endmodule

module ex_6_51_tb;
    reg sin, clk, reset;
    wire dected;

    ex_6_51 UUT(dected, sin, clk, reset);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        sin = 0;
        #2 reset = 0;
        #3 reset = 1;
        #10 sin = 1;
        #30 sin = 0;
        #40 sin = 1;
        #80 sin = 0;
        #90 sin = 1;
        #120 sin = 0;

    join
    initial begin $dumpfile("6-51.vcd"); $dumpvars(0, ex_6_51_tb); end
endmodule