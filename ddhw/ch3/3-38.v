//Verilog model: User-defined Primitive
primitive UDP_02467(D, A, B, C);
output D;
input A, B, C;
//Truth table for D = f(A, B, C) = min(0, 2, 4, 6, 7);
table
//  A   B   C   :   D
    0   0   0   :   1;
    0   0   1   :   0;
    0   1   0   :   1;
    0   1   1   :   0;
    1   0   0   :   1;
    1   0   1   :   0;
    1   1   0   :   1;
    1   1   1   :   1;
endtable
endprimitive

//Instantiate primitive
//Verilog model: Circuit instantiation of Circuit_UDP_02467
module Circuit_with_UDP_02467(f, a, b, c);
output f;
input a, b, c;
UDP_02467 (f, a, b, c);
endmodule

// testbench
module circuit_maj_func_tb;
reg a, b, c;
wire f;

Circuit_with_UDP_02467 circuit(f, a, b, c);

initial begin
$monitor("a=%b, b=%b, c=%b, f=%b", a, b, c, f);
a = 1'b1; b = 1'b1; c = 1'b0;
#10 c = 1'b1;
#10 b = 1'b0; c = 1'b0;
#10 c = 1'b1;
#10 a = 1'b0; b = 1'b1; c = 1'b0;
#10 b = 1'b1; c = 1'b1;
#10 b = 1'b0; c = 1'b0;
#10 c = 1'b1;
end

initial #80 $finish;
endmodule