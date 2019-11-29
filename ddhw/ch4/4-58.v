module arth_shift_right_3(f, in);
    output [31:0] f;
    input [31:0] in;
    
    assign f = {in[31], in[31], in[31], in[31:3]}; 
endmodule

module logical_shift_left_3(f, in);
    output [31:0] f;
    input [31:0] in;

    assign f = {in[28:0], 3'b0}; 
endmodule

module shift_tb;
    reg [31:0] a, b;
    wire [31:0] f1, f2;

    //Instantiate UUT
    arth_shift_right_3 UUT1(f1, a);
    logical_shift_left_3 UUT2(f2, b);

    //stimulus block
    initial
        begin
            a = 32'hf0f0f0f0;
            b = 32'hf0f0f0f0;
        end
    initial $monitor("a = %b, f1 = %b", a, f1);
    //initial $monitor("b = %b, f2 = %b", b, f2);
endmodule