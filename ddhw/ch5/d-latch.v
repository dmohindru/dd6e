module dlatch(q, q_not, en, d);
    output q, q_not;
    input en, d;

    wire w1, w2, w3;

    not (w1, d);
    nand(w2, en, d);
    nand(w3, en, w1);
    nand(q, w2, q_not);
    nand(q_not, w3, q);
endmodule

module dlatch_tb;
    reg en, d;
    wire q, q_not;
    
    //Instantiate UUT
    dlatch UUT(q, q_not, en, d);

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