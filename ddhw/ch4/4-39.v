module comparator_2bit(y, a, b);
    output reg [5:0] y;
    input [1:0] a, b;

    always @(y, a, b)
    begin
        y = 6'b000000;
        if (a == b)
            y[5] = 1'b1;
        if (a != b)
            y[4] = 1'b1;
        if (a > b)
            y[3] = 1'b1;
        if (a < b)
            y[2] = 1'b1;
        if (a >= b)
            y[1] = 1'b1;
        if (a <= b)
            y[0] = 1'b1;
    end
endmodule

module comparator_2bit_tb;
reg [1:0] a, b;
wire [5:0] y;

//Instantiate UUT
    comparator_2bit UUT(y, a, b);

    //stimulus block
    initial
        begin
            a = 2'b10;
            b = 2'b00;
            repeat (3) #10 b = b + 1'b1; 
        end
    initial $monitor("a = %b, b = %b, y = %b", a, b, y);
endmodule