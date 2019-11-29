module prob_4_49(f1, f2, a, b, c, d);
    output f1, f2;
    input a, b, c, d;

    wire not_a, not_b, t1, t2, t3, t4, t5;
    
    not(not_a, a);
    not(not_b, b);

    and(t1, not_b, c);
    and(t2, not_a, b);
    or(t3, t1, a);
    xor(t4, t2, d);
    or(t5, t2, d);
    or(f1, t3, t4);
    not(f2, t5);

endmodule

module prob_4_49_tb;
    reg [3:0] in;
    wire f1, f2;
    
    //Instantiate UUT
    prob_4_49 UUT(f1, f2, in[3], in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat (15) #100 in = in + 1'b1; 
        end
    initial $monitor("a = %b, b = %b, c = %b, d = %b, f1 = %b, f2 = %b", in[3], in[2], in[1], in[0], f1, f2);
endmodule