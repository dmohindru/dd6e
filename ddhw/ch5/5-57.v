module ex_5_57 (out, clk, rst);
    output [2:0] out;
    input clk, rst;
    reg [2:0] out;

    always @(posedge clk, negedge rst) 
    begin
        if (!rst) out = 3'b000; 
        else if (out >= 3'b110) out = 3'b000;
        else out = out + 2;
    end
endmodule

module ex_5_57_tb;
    reg clk, rst;
    wire [2:0] out;

    ex_5_57 UUT(out, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        #2 rst = 0;
        #4 rst = 1;
        #100 rst = 0;
        #102 rst = 1;
    join
    initial begin $dumpfile("5-57.vcd"); $dumpvars(0, ex_5_57_tb); end

endmodule