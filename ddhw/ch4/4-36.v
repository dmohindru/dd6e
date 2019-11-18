// Gate level description of 4 bit priority encoder
module priority_encoder_gate(valid, c, d);
    output valid;
    output [1:0] c;
    input [3:0] d;
    wire w1, w2;

    //c[1] = x, c[0] = y
    //x = d[2] + d[3]
    or m1(c[1], d[2], d[3]);
    
    //y = d[3] + d[1]d[2]'
    not m2(w1, d[2]);
    and m3(w2, w1, d[1]);
    or m4(c[0], d[3], w2);

    //output for valid
    or(valid, d[0], d[1], c[1]);

endmodule

module priority_encoder_gate_tb;
    reg [3:0] in;
    wire [1:0] f;
    wire v;
    //Instantiate UUT
    priority_encoder_gate UUT(v, f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("input = %b, valid = %b, output = %b", in, v, f);
endmodule