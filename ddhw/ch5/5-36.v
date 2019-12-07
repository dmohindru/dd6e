`include "../lib/d-flipflop.v"
`include "../lib/t-flipflop.v"

module ex_5_36(out, Clk, Rst);
    output [1:0] out;
    input Clk, Rst;

    wire Ta, Tb;
    assign Ta = out[1] | out[0];
    assign Tb = ~out[1] | out[0];
    T_flipflop a(out[1], Ta, Clk, Rst);
    T_flipflop a(out[0], Tb, Clk, Rst);
endmodule

module ex_5_36_tb;
reg clk, rst;
wire [1:0] count;

ex_5_36 UUT(count, clk, Rst);

initial
    begin
        
    end
endmodule