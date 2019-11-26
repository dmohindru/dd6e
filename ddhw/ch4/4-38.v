module quad_2X1_mux(y, s, a, b);
    output reg [3:0] y;
    input s;
    input [3:0] a, b;

    always @(s, a, b)
    if (s == 1) y = a;
    else y = b; 
endmodule

module quad_2X1_mux_tb;
    reg [3:0] a, b;
    reg s;
    wire [3:0] y;
    
    //Instantiate UUT
    quad_2X1_mux UUT(y, s, a, b);

    //stimulus block
    initial
        begin
            a = 4'b0101;
            b = 4'b1010;
            s = 1'b0;
            #10 s = 1'b1;
            
        end
    initial $monitor("a = %b, b = %b,  s = %b, y = %b", a, b, s, y);
endmodule