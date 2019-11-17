//gate level description of bcd to excess-3 convertor
module bcd_to_excess_3_behaviour(x, a);
    output reg [3:0] x;
    input [3:0] a;
    
    always @ (a)
    begin 
        x = a + 4'b0011;
    end

endmodule

module bcd_to_excess_3_behaviour_tb;
    reg [3:0] in;
    wire [3:0] f;
    //Instantiate UUT
    bcd_to_excess_3_behaviour UUT(f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(9) #10 in = in + 1'b1;
        end
    initial $monitor("input = %b, output = %b", in, f);
endmodule