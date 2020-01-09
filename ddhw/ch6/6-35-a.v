module ex_6_35_a(a, i, load, reset, clk);
    output [3:0] a;
    input [3:0] i;
    input load, reset, clk;
    
    wire a0_0, a0_1, a0_2, a1_0, a1_1, a1_2, a2_0, a2_1, a2_2, a3_0, a3_1, a3_2;

    and(a0_0, load, i[0]);
    and(a0_1, ~load, ~reset, a[0]);
    or(a0_2, a0_0, a0_1);

    and(a1_0, load, i[1]);
    and(a1_1, ~load, ~reset, a[1]);
    or(a1_2, a1_0, a1_1);

    and(a2_0, load, i[2]);
    and(a2_1, ~load, ~reset, a[2]);
    or(a2_2, a2_0, a2_1);

    and(a3_0, load, i[3]);
    and(a3_1, ~load, ~reset, a[3]);
    or(a3_2, a3_0, a3_1);

    d_ff d0(a[0], a0_2, clk, 1'b1);
    d_ff d1(a[1], a1_2, clk, 1'b1);
    d_ff d2(a[2], a2_2, clk, 1'b1);
    d_ff d3(a[3], a3_2, clk, 1'b1); 
endmodule


module d_ff(q, d, clk, rst);
    output q;
    input d, clk, rst;
    reg q;

    always @ (posedge clk, negedge rst) begin
        if (!rst) q <= 1'b0;
        else q <= d;
    end
endmodule

module ex_6_35_a_tb;
    reg [3:0] i;
    reg load, reset, clk;
    wire [3:0] a;

    ex_6_35_a UUT(a, i, load, reset, clk);

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
    initial begin $dumpfile("6-35-a.vcd"); $dumpvars(0, ex_6_35_a_tb); end
endmodule