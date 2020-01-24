module up_down_counter(count, up, down, clk, reset_b);
    output [3:0] count;
    input up, down, clk, reset_b;
    reg [3:0] count;

    always @(posedge clk, negedge reset_b) begin
        if (!reset_b)
            count <= 4'b0000;
        else if(up == 1'b1 && down == 1'b0)
            count <= count + 1'b1;
        else if(up == 1'b0 && down == 1'b1)
            count <= count - 1'b1; 
    end

endmodule

module up_down_counter_tb;
    reg up, down, clk, reset_b;
    wire [3:0] count;

    up_down_counter UUT(count, up, down, clk, reset_b);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset_b = 1;
        up = 0;
        down = 0;
        #2 reset_b = 0;
        #3 reset_b = 1;
        #30 up = 1;
        #70 down = 1;
        #100 up = 0;
        #140 down = 0;
        #160 up = 1;
    join
    initial begin $dumpfile("6-35-l.vcd"); $dumpvars(0, up_down_counter_tb); end

endmodule