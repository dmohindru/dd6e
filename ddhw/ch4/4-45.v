// Gate level description of 4 bit priority encoder
module priority_encoder_behaviour(valid, c, d);
    output reg valid;
    output reg [1:0] c;
    input [3:0] d;
    
    always @(d) begin
        valid = 0;

        // set valid bit
        if (d[0] || d[1] || d[2] || d[3])
            valid = 1'b1;
        else
            valid = 1'b0;
    
        //set x(c[1])
        if (d[2] == 1 || d[3] == 1)
            c[1] = 1'b1;
        else
            c[1] = 1'b0;
    

        //set y(c[0])
        if (d[3] || (d[1] & ~(d[2])))
            c[0] = 1'b1;
        else
            c[0] = 1'b0;
    end
    
endmodule

module priority_encoder_behaviour_tb;
    reg [3:0] in;
    wire [1:0] f;
    wire v;
    //Instantiate UUT
    priority_encoder_behaviour UUT(v, f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("input = %b, valid = %b, output = %b", in, v, f);
endmodule