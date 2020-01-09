module ex_6_35_b(a, i, load, reset, clk);
    output [3:0] a;
    input [3:0] i;
    input load, reset, clk;
    reg [3:0] a;
    always @(posedge clk) begin
        if (load) a <= i;
        else if(reset) a <= 4'b0000;
    end
     
endmodule


module ex_6_35_b_tb;
    reg [3:0] i;
    reg load, reset, clk;
    wire [3:0] a;

    ex_6_35_b UUT(a, i, load, reset, clk);

    initial #150 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 0;
        load = 0;
        #10 reset = 1;
        #20 load = 1;
        #20 i = 4'b1010;
        #30 i = 4'b1100;
        #40 i = 4'b0011;
        #50 load = 0;
        #60 load = 1;
        #60 i = 4'b1001;
        #70 load = 0;
        #70 reset = 0;
    join
    initial begin $dumpfile("6-35-b.vcd"); $dumpvars(0, ex_6_35_b_tb); end
endmodule