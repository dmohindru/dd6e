module ex_6_38_b(a, in, op, clk, reset);
    output [3:0] a;
    input [3:0] in;
    input [1:0] op;
    input clk, reset;
    reg [3:0] a;

    always @(posedge clk, negedge reset) begin
        if (!reset)
            a <= 4'b0000;
        else begin
            case (op)
                2'b00:
                    a <= a;         // no operation
                2'b01:
                    a <= in;        // load operation
                2'b10:
                    a <= a + 1'b1;  // count up operation
                2'b11:
                    a <= a - 1'b1;  // count down operation
            endcase
        end 
    end

endmodule

module ex_6_38_b_tb;
    reg [3:0] in;
    reg [1:0] op;
    reg clk, reset;
    wire [3:0] a;

    ex_6_38_b UUT(a, in, op, clk, reset);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        op = 2'b00;
        in = 4'b0000;
        #2 reset = 0;
        #3 reset = 1;
        #30 op = 2'b01;
        #30 in = 4'b0100;
        #40 op = 2'b00;
        #60 op = 2'b10;
        #120 reset = 0;
        #122 reset = 1;
        #200 op = 2'b10;
        #210 op = 2'b11;
    join
    initial begin $dumpfile("6-38-b.vcd"); $dumpvars(0, ex_6_38_b_tb); end

endmodule