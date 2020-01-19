module s_subtractor_4(s_out, s_in_a, s_in_b, shift_ctrl, clear_b, clk);
    output s_out;
    input s_in_a, s_in_b, shift_ctrl, clear_b, clk;
    reg [1:0] sum;

    always @(posedge clk, negedge clear_b) begin
        if (!clear_b)
            sum <= 2'b10;
        else if (shift_ctrl)
            sum <= s_in_a + !s_in_b + sum[1];
    end
    assign s_out = sum[0];
endmodule

module s_subtractor_4_tb;
    reg s_in_a, s_in_b, shift_ctrl, clear_b, clk;
    wire s_out;

    s_subtractor_4 UUT(s_out, s_in_a, s_in_b, shift_ctrl, clear_b, clk);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        shift_ctrl = 0;
        s_in_a = 0;
        s_in_b = 0;
        #2 clear_b = 0;
        #3 clear_b = 1;
        //load 1010 in a and 0011 in b
        #10 shift_ctrl = 1;
        #10 s_in_a = 0;
        #10 s_in_b = 1;
        #20 s_in_a = 1;
        #20 s_in_b = 1;
        #30 s_in_a = 0;
        #30 s_in_b = 0;
        #40 s_in_a = 1;
        #40 s_in_b = 0;
        //perform subtraction finish process by 4 cycles
        #90 shift_ctrl = 0;
    join
    initial begin $dumpfile("6-35-i.vcd"); $dumpvars(0, s_subtractor_4_tb); end

endmodule