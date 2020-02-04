module ex_6_40(out, shift_r, clk, reset);
    output [7:0] out;
    input shift_r, clk, reset;
    reg [7:0] out;

    always @(posedge clk, negedge reset) begin
        if (!reset)
            out <= 8'b1000_0000;
        else if(shift_r)
            out <= {out[0], out[7:1]};
    end

endmodule

module ex_6_40_tb;
    reg shift_r, clk, reset;
    wire t0, t1, t2, t3, t4, t5, t6, t7;

    ex_6_40 UUT({t0, t1, t2, t3, t4, t5, t6, t7}, shift_r, clk, reset);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        shift_r = 0;
        #2 reset = 0;
        #3 reset = 1;
        #10 shift_r = 1;
        
    join
    initial begin $dumpfile("6-40.vcd"); $dumpvars(0, ex_6_40_tb); end


endmodule