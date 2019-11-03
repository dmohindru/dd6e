module prob_4_50_b(code_grey, code_84_m2_m1);
    output reg [3:0] code_grey;
    input [3:0] code_84_m2_m1;
    
    always @ (code_84_m2_m1)
    case (code_84_m2_m1)
        4'b0000: code_grey = 4'b0000;    //0
        4'b0111: code_grey = 4'b0001;    //1
        4'b0110: code_grey = 4'b0011;    //2
        4'b0101: code_grey = 4'b0010;    //3
        4'b0100: code_grey = 4'b0110;    //4
        4'b1011: code_grey = 4'b0111;    //5
        4'b1010: code_grey = 4'b0101;    //6
        4'b1001: code_grey = 4'b0100;    //7
        4'b1000: code_grey = 4'b1100;    //8
        4'b1111: code_grey = 4'b1101;    //9
        4'b0001: code_grey = 4'b1111;    //10
        4'b0010: code_grey = 4'b1110;    //11
        4'b0011: code_grey = 4'b1010;    //12
        4'b1100: code_grey = 4'b1011;    //13
        4'b1101: code_grey = 4'b1001;    //14
        4'b1110: code_grey = 4'b1000;    //15

        
    endcase
endmodule

module prob_4_50_b_tb;
    reg [3:0] in;
    wire [3:0] f;
    //Instantiate UUT
    prob_4_50_b UUT(f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("input = %b, output = %b", in, f);
endmodule