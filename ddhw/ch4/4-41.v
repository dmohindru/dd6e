module Add_usign_4(c_out, sum, a, b, c_in);
    //wire b0_in, b1_in, b2_in, b3_in, c1, c2, c3, c4;    //intermediate wires
    output reg [3:0] sum;
    output reg c_out;
    input [3:0] a, b;
    input c_in;

    always @(a, b, c_in)
    case (c_in)
        1'b0: {c_out, sum} = a + b;
        1'b1: {c_out, sum} = a - b;
    endcase

endmodule

module Add_usign_tb;
    reg [3:0] a, b;
    reg c_in;
    wire [3:0] s;
    wire c_out;

    //Instantiate UUT
    Add_usign_4 UUT(c_out, s, a, b, c_in);
    
    //stimulus block
    initial
        begin
            a = 4'b0010;
            b = 4'b0011;
            c_in = 1'b0;
            #100;
            //a = 4'b0010;
            //b = 4'b0013;
            c_in = 1'b1;
            #100;
        end
    initial $monitor("a = %d, b = %d, c_in = %d, sum = %d, c_out = %d", a, b, c_in, s, c_out);
endmodule