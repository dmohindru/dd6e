module jk_ff(q, j, k, clk, reset);
    output q;
    input j, k, clk, reset;
    reg q;

    always @(posedge clk, negedge reset) begin
        if (!reset) q <= 1'b0;
        else if({j,k} == 2'b00) q <= q;
        else if({j,k} == 2'b01) q <=1'b0;
        else if({j,k} == 2'b10) q <=1'b1;
        else q <= ~q;
    end
endmodule

module ex_6_39_beh(a, clk, reset);
    output [2:0] a;
    input clk, reset;
    reg [2:0] a, a_next;
    
    parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110, s7 = 3'b111;
    
    always @(posedge clk, negedge reset) begin
        if (!reset)
            a <= s0;
        else
            a <= a_next;
    end

    always @(a) begin
        case (a)
            s0: a_next = s1;
            s1: a_next = s2;
            s2: a_next = s4;
            s3: a_next = s4;
            s4: a_next = s5;
            s5: a_next = s6;
            s6: a_next = s0;
            s7: a_next = s0;
            default: a_next = s0;
        endcase
    end
endmodule

module ex_6_39_str(a, clk, reset);
    output [2:0] a;
    input clk, reset;

    jk_ff m0(a_out, b_out, b_out, clk, reset);
    jk_ff m1(b_out, c_out, 1'b1, clk, reset);
    jk_ff m2(c_out, ~b_out, 1'b1, clk, reset);

    assign a = {a_out, b_out, c_out};

endmodule

module ex_6_39_tb;
    reg clk, reset;
    wire [2:0] a_beh, a_str;

    ex_6_39_beh UUT0(a_beh, clk, reset);
    ex_6_39_str UUT1(a_str, clk, reset);

    initial #300 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        #2 reset = 0;
        #3 reset = 1;
    join
    initial begin $dumpfile("6-39.vcd"); $dumpvars(0, ex_6_39_tb); end
    
endmodule