module ex_6_46(out, clk, reset);
    output [5:0] out;
    input clk, reset;
    reg [5:0] out;

    always @(posedge clk, negedge reset) begin
        if (!reset)
            out <= 6'b100000;
        else
            out <= {out[0], out[5:1]};
    end
endmodule

module ex_6_46_tb;
    reg clk, reset;
    wire t0, t1, t2, t3, t4, t5;

    ex_6_46 UUT({t0, t1, t2, t3, t4, t5}, clk, reset);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        #2 reset = 0;
        #3 reset = 1;
    join
    initial begin $dumpfile("6-46.vcd"); $dumpvars(0, ex_6_46_tb); end

endmodule