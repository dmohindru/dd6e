module ex_5_60 (out, clk, rst);
    output [3:0] out;
    input clk, rst;
    reg [3:0] out;

    always @(posedge clk, negedge rst) 
    begin
        if (!rst) out = 4'b000; 
        else if (out >= 4'b1001) out = 4'b0000;
        else out = out + 1;
    end
endmodule

module ex_5_60_tb;
    reg clk, rst;
    wire [3:0] out;

    ex_5_60 UUT(out, clk, rst);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        #2 rst = 0;
        #4 rst = 1;
        #120 rst = 0;
        #122 rst = 1;
    join
    initial begin $dumpfile("5-60.vcd"); $dumpvars(0, ex_5_60_tb); end

endmodule