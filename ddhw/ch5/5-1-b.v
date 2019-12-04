module prob_5_1b(q, q_not, en, d);
    output q, q_not;
    input en, d;

    wire w1, w2, w3, w4;

    not(w1, d);
    not(w2, en); 
    nor(w3, w2, d);
    nor(w4, w2, w1);
    nor(q, w3, q_not);
    nor(q_not, w4, q);
endmodule

module prob_5_1b_tb;
    reg en, d;
    wire q, q_not;
    
    //Instantiate UUT
    prob_5_1b UUT(q, q_not, en, d);

    //stimulus block
    initial
        begin
            //set initial state of d latch
            en = 1'b1;
            d = 1'b1;
            #10 en = 1'b0;
            d = 1'b0;
            #10 d = d + 1'b1;
            #10 en = 1'b1;
            d = 1'b0;
            #10 d = d + 1'b1;          
        end
    initial $monitor("en = %b, d = %b, q = %b, q_not = %b", en, d, q, q_not);
endmodule