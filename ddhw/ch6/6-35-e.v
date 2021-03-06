module ushift_4(a_par, i_par, sel, clear_b, clk);
    output [3:0] a_par;
    input [3:0] i_par;
    input [1:0] sel;
    input clear_b, clk;

    wire m3_out, m2_out, m1_out, m0_out;
    //d_ff for outputs
    d_ff f3(a_par[3], m3_out, clk, clear_b); //bit 3
    d_ff f2(a_par[2], m2_out, clk, clear_b); //bit 2
    d_ff f1(a_par[1], m1_out, clk, clear_b); //bit 1
    d_ff f0(a_par[0], m0_out, clk, clear_b); //bit 0

    //mux for inputs to flip flops
    mux_4x1 m3(m3_out, {i_par[3], 1'b0, ~a_par[3], a_par[3]}, sel);  // input to flip flop for bit 3
    mux_4x1 m2(m2_out, {i_par[2], 1'b0, ~a_par[2], a_par[2]}, sel);  // input to flip flop for bit 2
    mux_4x1 m1(m1_out, {i_par[1], 1'b0, ~a_par[1], a_par[1]}, sel);  // input to flip flop for bit 1
    mux_4x1 m0(m0_out, {i_par[0], 1'b0, ~a_par[0], a_par[0]}, sel);  // input to flip flop for bit 0

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
    reg clear_b, clk;
    reg [1:0] sel;
    wire [3:0] a_par;

    ushift_4 UUT(a_par, i_par, sel, clear_b, clk);
    
    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        i_par = 4'b0000;
        sel = 2'b00;
        #2 clear_b = 0;
        #3 clear_b = 1;
        // Parallel load
        #10 sel = 2'b11; 
        #10 i_par = 4'b1011;
        //hold value
        #20 sel = 2'b00; 
        //complement output
        #50 sel = 2'b01; 
        //complement output
        #60 sel = 2'b01; 
        //hold value
        #70 sel = 2'b00; 
        //zero output
        #90 sel = 2'b10;
        //hold value
        #100 sel = 2'b00;
        //Parallel load
        #140 sel = 2'b11;
        #140 i_par = 4'b1000;
        //complement output
        #150 sel = 2'b01;
        //hold value
        #160 sel = 2'b00;
    
    join
    initial begin $dumpfile("6-35-e.vcd"); $dumpvars(0, ushift_4_tb); end
endmodule