//right shift register
module rshift_4(s_out, s_in, shift_ctrl, clear_b, clk);
    output s_out;
    input s_in, shift_ctrl, clear_b, clk;
    reg [3:0] s;
    always @(posedge clk, negedge clear_b) begin
        if (!clear_b) begin
             s <= 4'b0000;
        end
        else if (shift_ctrl) begin
            s <= {s_in, s[3:1]}; 
        end
    end

    assign s_out = s[0];
endmodule

module rshift_4_tb;
    reg s_in, shift_ctrl, clear_b, clk;
    wire s_out;

    rshift_4 UUT(s_out, s_in, shift_ctrl, clear_b, clk);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        shift_ctrl = 0;
        s_in = 0;
        #2 clear_b = 0;
        #3 clear_b = 1;
        //----------
        #10 shift_ctrl = 1;
        #10 s_in = 1;
        #20 s_in = 0;
        #30 s_in = 1;
        #40 s_in = 0;
        //-----------
        #50 shift_ctrl = 0; 
        //-----------
        #100 shift_ctrl = 1;
        #100 s_in = 0;
        #110 s_in = 0;
        #120 s_in = 1;
        #130 s_in = 1;
        //----------
        #140 shift_ctrl = 0;
    join
    initial begin $dumpfile("rshift4.vcd"); $dumpvars(0, rshift_4_tb); end

endmodule