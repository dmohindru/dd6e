`include "../lib/d-flipflop.v"

module ex_5_35(z, x, y, Clk, Rst);
    output z;
    input x, y, Clk, Rst;
    wire Qa, Qb, Da, Db;

    assign Da = ~x&y | x&Qa;
    assign Db = x&Qa | ~x&Qb;
    assign z = Qb;

    D_flipflop a(Qa, Da, Clk, Rst);
    D_flipflop b(Qb, Db, Clk, Rst);

endmodule

//TODO: write a proper test bench to test FSM for all the state and inputs
module ex_5_6_tb;
    reg clk, rst;
    reg [1:0] in;
    wire z;

    ex_5_35 UUT(z, in[1], in[0], clk, rst);


    initial
        begin
            //reset flip flops to zero
            rst = 1'b1;
            clk = 1'b0;
            #10 rst = 1'b0;
            #10 rst = 1'b1;
            repeat(30) #10 clk = ~clk;
        end
    initial
        begin
            in = 2'b00;
            //repeat (3) #10 in = in + 1;
        end
    initial $monitor("in = %b, z = %b", in, z);
endmodule