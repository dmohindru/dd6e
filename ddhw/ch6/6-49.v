module Shift_Register_4_beh(A_par, I_par, s1, s0, MSB_in, LSB_in, clk, clear_b);
    output [3:0] A_par;
    input [3:0] I_par;
    input s1, s0, MSB_in, LSB_in, clk, clear_b;
    reg [3:0] A_par;

    always @(posedge clk, negedge clear_b) begin
        if (!clear_b) A_par <= 4'b0000;
        else begin
            case({s1, s0})
                2'b00: A_par <= A_par;                  // No Change
                2'b01: A_par <= {MSB_in, A_par[3:1]};   // Shift right
                2'b10: A_par <= {A_par[2:0], LSB_in};   // Shift left
                2'b11: A_par <= I_par;                  //Parallel load
            endcase
        end
    end
endmodule

module ex_6_49_tb;
    reg [3:0] I_par;
    reg s0, s1, MSB_in, LSB_in, clk, clear_b;
    wire [3:0] A_par;

    Shift_Register_4_beh UUT(A_par, I_par, s1, s0, MSB_in, LSB_in, clk, clear_b);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        s0 = 0;
        s1 = 0;
        MSB_in = 0;
        LSB_in = 0;
        I_par = 4'b0000;
        #2 clear_b = 0;
        #3 clear_b = 1;
        #10 {s1, s0} = 2'b11;   //parallel load
        #10 I_par = 4'b1011;
        #20 {s1, s0} = 2'b00;   //no change
        #40 {s1, s0} = 2'b01;   //right shift
        #40 MSB_in = 0;
        #50 MSB_in = 1;
        #60 {s1, s0} = 2'b00;   //no change
        #80 {s1, s0} = 2'b11;   //parallel load
        #80 I_par = 4'b1100;
        #90 {s1, s0} = 2'b00;   //no change
        #110 {s1, s0} = 2'b10;  //left shift
        #110 LSB_in = 1;
        #120 LSB_in = 0;
        #130 {s1, s0} = 2'b00;   //no change
        #150 clear_b = 0;       //clear register
        #151 clear_b = 1;
        #160 {s1, s0} = 2'b11;   //parallel load
        #160 I_par = 4'b1111;
        #170 {s1, s0} = 2'b00;   //no change
    join
    initial begin $dumpfile("6-49.vcd"); $dumpvars(0, ex_6_49_tb); end
endmodule