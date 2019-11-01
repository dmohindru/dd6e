module circuit_4_5(A, B, C, x, y, z);
    output A, B, C;
    input x, y, z;
    //A = x'y + yz
    //B = xyz' + x'y' + y'z
    //C = x'z + xz'
    assign A = (~x&y) | (y&z);
    assign B = (x&y&~z) | (~x&~y) | (~y&z);
    assign C = (~x&z) | (x&~z);
endmodule

module circuit_4_5_tb;
    reg [2:0] in;
    wire [2:0] f;
    //Instantiate UUT
    circuit_4_5 UUT(f[2], f[1], f[0], in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 3'b000;
            repeat(7) #10 in = in + 1'b1;
        end
    initial $monitor("xyz = %d, ABC = %d", in, f);
endmodule