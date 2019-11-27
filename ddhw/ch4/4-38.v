module quad_2X1_mux(y, s, en, a, b);
    output [3:0] y;
    input s, en;
    input [3:0] a, b;

    //always @(s, en, a, b)
    //if (s == 1) y = a;
    //else y = b;
    //active high enable
    assign y = en ? (s ? a : b) : 4'bzzzz;
endmodule

module quad_2X1_mux_tb;
    reg [3:0] a, b;
    reg s, en;
    wire [3:0] y;
    integer i;
    
    //Instantiate UUT
    quad_2X1_mux UUT(y, s, en, a, b);

    //stimulus block
    initial
        begin
            a = 4'b0101;
            b = 4'b1010;
            for (i = 0; i < 2; i = i + 1) begin
                en = i;
                s = 1'b0;
                #10 s = 1'b1;
            end
        end
    initial $monitor("a = %b, b = %b, en = %b, s = %b, y = %b", a, b, en, s, y);
endmodule