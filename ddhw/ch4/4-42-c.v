//gate level description of bcd to excess-3 convertor
module bcd_to_excess_3_dataflow(x, a);
    output [3:0] x;
    input [3:0] a;
    
    //a = a[3], b = a[2], c = a[1], d = a[0]
    //w = bd + bc + a
    assign x[3] = a[2]&a[0] | a[2]&a[1] | a[3];
    //x = bc'd' + b'd + b'c
    assign x[2] = a[2]&(~a[1])&(~a[0]) | (~a[2])&a[0] | (~a[2])&a[1];
    //y = c'd' + cd
    assign x[1] = (~a[1])&(~a[0]) | a[1]&a[0];
    //z = d'
    assign x[0] = ~a[0];

endmodule

module bcd_to_excess_3_dataflow_tb;
    reg [3:0] in;
    wire [3:0] f;
    //Instantiate UUT
    bcd_to_excess_3_dataflow UUT(f, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(9) #10 in = in + 1'b1;
        end
    initial $monitor("input = %b, output = %b", in, f);
endmodule