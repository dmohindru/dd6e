primitive maj_func(F, A, B, C, D);
output F;
input A, B, C, D;
table
//  A   B   C   D   :   F
    0   0   0   0   :   0;
    0   0   0   1   :   0;
    0   0   1   0   :   0;
    0   0   1   1   :   0;
    0   1   0   0   :   0;
    0   1   0   1   :   0;
    0   1   1   0   :   0;
    0   1   1   1   :   1;
    1   0   0   0   :   0;
    1   0   0   1   :   0;
    1   0   1   0   :   0;
    1   0   1   1   :   0;
    1   1   0   0   :   0;
    1   1   0   1   :   1;
    1   1   1   0   :   1;
    1   1   1   1   :   1;
endtable
endprimitive

// Inistantiate primitive
module Circuit_with_maj_func(f, a, b, c, d);
output f;
input a, b, c, d;
maj_func(f, a, b, c, d);
endmodule

module circuit_maj_func_tb;
reg a, b, c, d;
wire f;

Circuit_with_maj_func circuit(f, a, b, c, d);
initial
begin
$monitor("a=%b, b=%b, c=%b, d=%b, f=%b", a, b, c, d, f);
a = 0; b = 0; c = 0; d = 0; #10;
a = 0; b = 0; c = 0; d = 1; #10;
a = 0; b = 0; c = 1; d = 0; #10;
a = 0; b = 0; c = 1; d = 1; #10;
a = 0; b = 1; c = 0; d = 0; #10;
a = 0; b = 1; c = 0; d = 1; #10;
a = 0; b = 1; c = 1; d = 0; #10;
a = 0; b = 1; c = 1; d = 1; #10;
a = 1; b = 0; c = 0; d = 0; #10;
a = 1; b = 0; c = 0; d = 1; #10;
a = 1; b = 0; c = 1; d = 0; #10;
a = 1; b = 0; c = 1; d = 1; #10;
a = 1; b = 1; c = 0; d = 0; #10;
a = 1; b = 1; c = 0; d = 1; #10;
a = 1; b = 1; c = 1; d = 0; #10;
a = 1; b = 1; c = 1; d = 1; #10;
$finish;
end
endmodule
