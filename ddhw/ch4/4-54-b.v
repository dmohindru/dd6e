module code5421_9_complement(a, x);
    output [3:0] a;
    input [3:0] x;

    //A = x'y'
    //B = w'x'y + x'z' + w'xy'
    //C = w'y + x'y'z
    //D = x'y'z + w'xz' + yz' + wy
    assign a[3] = ~x[2] & ~x[1];
    assign a[2] = ~x[3]&~x[2]&x[1] | ~x[2]&~x[0] | ~x[3]&x[2]&~x[1];
    assign a[1] = ~x[3]&x[1] | ~x[2]&~x[1]&x[0];
    assign a[0] = ~x[2]&~x[1]&x[0] | ~x[3]&x[2]&~x[0] | x[1]&~x[0] | x[3]&x[1];
endmodule

module code5421_9_complement_tb;
    reg [3:0] in;
    wire [3:0] f;
    //Instantiate UUT
    code5421_9_complement UUT(f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(7) #10 in = in + 1'b1;
            #10 in = 4'b1011;
            #10 in = 4'b1100;
        end
    
        
    initial $monitor("wxyz = %b, ABCD = %b", in, f);
endmodule