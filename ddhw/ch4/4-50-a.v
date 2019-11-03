module prob_4_50_a(code_BCD, code_84_m2_m1);
    output reg [3:0] code_BCD;
    input [3:0] code_84_m2_m1;
    
    always @ (code_84_m2_m1)
    case (code_84_m2_m1)
        4'b0000: code_BCD = 4'b0000;    //0
        4'b0111: code_BCD = 4'b0001;    //1
        4'b0110: code_BCD = 4'b0010;    //2
        4'b0101: code_BCD = 4'b0011;    //3
        4'b0100: code_BCD = 4'b0100;    //4
        4'b1011: code_BCD = 4'b0101;    //5
        4'b1010: code_BCD = 4'b0110;    //6
        4'b1001: code_BCD = 4'b0111;    //7
        4'b1000: code_BCD = 4'b1000;    //8
        4'b1111: code_BCD = 4'b1001;    //9
        
        4'b0001: code_BCD = 4'b1010;    //10
        4'b0010: code_BCD = 4'b1011;    //11
        4'b0011: code_BCD = 4'b1100;    //12
        4'b1100: code_BCD = 4'b1101;    //13
        4'b1101: code_BCD = 4'b1110;    //14
        4'b1110: code_BCD = 4'b1111;    //15

        
    endcase
endmodule

module prob_4_50_a_tb;
    reg [3:0] in;
    wire [3:0] f;
    //Instantiate UUT
    prob_4_50_a UUT(f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("input = %b, output = %b", in, f);
endmodule