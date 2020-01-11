module ushift_4(a_par, i_par, sel, msb_in, lsb_in, clear_b, clk);
    output [3:0] a_par;
    input [3:0] i_par;
    input [1:0] sel;
    input msb_in, lsb_in, clear_b, clk;

    wire m3_out, m2_out, m1_out, m0_out;
    //d_ff for outputs
    d_ff f3(a_par[3], m3_out, clk, clear_b); //bit 3
    d_ff f2(a_par[2], m2_out, clk, clear_b); //bit 2
    d_ff f1(a_par[1], m1_out, clk, clear_b); //bit 1
    d_ff f0(a_par[0], m0_out, clk, clear_b); //bit 0

    //mux for inputs to flip flops
    mux_4x1 m3(m3_out, {i_par[3], a_par[2], msb_in, a_par[3]}, sel);  // input to flip flop for bit 3
    mux_4x1 m2(m2_out, {i_par[2], a_par[1], a_par[3], a_par[2]}, sel);  // input to flip flop for bit 2
    mux_4x1 m1(m1_out, {i_par[1], a_par[0], a_par[2], a_par[1]}, sel);  // input to flip flop for bit 1
    mux_4x1 m0(m0_out, {i_par[0], lsb_in, a_par[1], a_par[0]}, sel);  // input to flip flop for bit 0

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

module mux_4x1(y, x, sel);
    output y;
    input [3:0] x;
    input [1:0] sel;
    reg y;

    always @(x, sel) begin
        case(sel)
            2'b00: y = x[0];
            2'b01: y = x[1];
            2'b10: y = x[2];
            2'b11: y = x[3];
        endcase
    end
endmodule

module ushift_4_tb;
    reg [3:0] i_par;
    reg [1:0] sel;
    reg msb_in, lsb_in, clear_b, clk;
    wire [3:0] a_par;

    ushift_4 UUT(a_par, i_par, sel, msb_in, lsb_in, clear_b, clk);
    
    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    /*
     First check shift right
     Second check shift left
     Third check parallel load
     Fourth no change
     Fifth parallel load
     Sixth no change
    */
    initial fork
        //clear_b = 1;
        sel = 2'b00;
        msb_in = 1'b0;
        lsb_in = 1'b0;
        i_par = 4'b0000;
        #2 clear_b = 0;
        #3 clear_b = 1;
        #10 sel = 2'b01; // right shitf
        #10 msb_in = 1'b1;
        #20 msb_in = 1'b0;
        #30 msb_in = 1'b1;
        #40 msb_in = 1'b0;
        #50 sel = 2'b00; //hold value
        #60 i_par = 4'b1101;
        #80 sel = 2'b11; //parallel load
        #90 sel = 2'b00; //hold value
        #120 sel = 2'b10; //left shift
        #120 lsb_in = 1'b1;
        #130 lsb_in = 1'b1;
        #140 lsb_in = 1'b0;
        #150 lsb_in = 1'b1;
        #160 sel = 2'b00; //hold value
        #180 sel = 2'b11; //parallel load
        #180 i_par = 4'b1001;
        #190 sel = 2'b00; //hold value


    join
    initial begin $dumpfile("6-52.vcd"); $dumpvars(0, ushift_4_tb); end
endmodule