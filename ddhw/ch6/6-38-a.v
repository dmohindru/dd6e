module ex_6_38_a(a, in, load, up, down, clk, reset);
    output [3:0] a;
    input [3:0] in;
    input load, up, down, clk, reset;
    reg [3:0] a;

    always @(posedge clk, negedge reset) begin
        if (!reset)
            a <= 4'b0000;
        else if (load)
            a <= in;
        else if (up)
            a <= a + 1'b1;
        else if (down)
            a <= a - 1'b1; 
    end

endmodule

module ex_6_38_a_tb;
    reg [3:0] in;
    reg load, up, down, clk, reset;
    wire [3:0] a;

    ex_6_38_a UUT(a, in, load, up, down, clk, reset);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        up = 0;
        down = 0;
        load = 0;
        in = 4'b0000;
        #2 reset = 0;
        #3 reset = 1;
        #30 load = 1;
        #30 in = 4'b0100;
        #40 load = 0;
        #60 up = 1;
        #120 reset = 0;
        #122 reset = 1;
        #200 up = 0;
        #210 down = 1;
    join
    initial begin $dumpfile("6-38-a.vcd"); $dumpvars(0, ex_6_38_a_tb); end

endmodule