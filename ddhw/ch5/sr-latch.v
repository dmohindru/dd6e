module srlatch(q, q_not, en, s, r);
    output q, q_not;
    input en, s, r;

    wire w1, w2;

    nand(w1, en, s);
    nand(w2, en, r);
    nand(q, w1, q_not);
    nand(q_not, w2, q);
endmodule

module srlatch_tb;
    reg en;
    reg [1:0] in;
    wire q, q_not;
    
    //Instantiate UUT
    srlatch UUT(q, q_not, en, in[1], in[0]);

    //stimulus block
    initial
        begin
            //set initial state of sr latch
            en = 1'b1;
            in = 2'b01;
            #10 en = 1'b0;
            repeat (3) #10 in = in + 1'b1;
            #10 en = 1'b1;
            repeat (3) #10 in = in + 1'b1;
            
        end
    initial $monitor("en = %b, s = %b, r = %b, q = %b, q_not = %b", en, in[1], in[0], q, q_not);
endmodule