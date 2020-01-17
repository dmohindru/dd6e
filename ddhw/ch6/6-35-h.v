module s_subtractor_4(s_out, s_in, shift_ctrl, clear_b, clk);
    output s_out;
    input s_in, shift_ctrl, clear_b, clk;

    reg carry;
    reg [3:0] a, b;

    always @(posedge clk, negedge clear_b) begin
        if (!clear_b) begin
            carry <= 1'b1;
            a <= 4'b0000;
            b <= 4'b0000;
        end
        else if (shift_ctrl) begin
            b <= {s_in, b[3:1]};
            a[2:0] <= a[3:1];
            {carry,a[3]} = a[0] + !b[0] + carry;
        end
    end
    assign s_out = a[0];
endmodule

module s_subtractor_4_tb;
    reg s_in, shift_ctrl, clear_b, clk;
    wire s_out;

    s_subtractor_4 UUT(s_out, s_in, shift_ctrl, clear_b, clk);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        shift_ctrl = 0;
        s_in = 0;
        #2 clear_b = 0;
        #3 clear_b = 1;
        //load 1010
        #10 shift_ctrl = 1;
        #10 s_in = 0;
        #20 s_in = 1;
        #30 s_in = 0;
        #40 s_in = 1;
        //load 0011
        #50 s_in = 1;
        #60 s_in = 1;
        #70 s_in = 0;
        #80 s_in = 0;
        //perform addition
        #90 s_in = 0;
        #100 s_in = 0;
        #110 s_in = 0;
        #120 s_in = 0;
    join
    initial begin $dumpfile("6-35-h.vcd"); $dumpvars(0, s_subtractor_4_tb); end

endmodule