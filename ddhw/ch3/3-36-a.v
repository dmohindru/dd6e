module Circuit_A(A, B, C, F);
input A, B, C;
output F;
wire w, x, y;
xor (w, A, B);
and (x, w, C);
and (y, A, B);
or (F, x, y);
endmodule

module Circuit_A_tb;
reg a, b, c;
wire f;

Circuit_A circuit(a, b, c, f);
initial
begin
$monitor("A=%b, B=%b, C=%b, F=%b", a, b, c, f);
a = 0; b = 0; c = 0; #10;
a = 0; b = 0; c = 1; #10;
a = 0; b = 1; c = 0; #10;
a = 0; b = 1; c = 1; #10;
a = 1; b = 0; c = 0; #10;
a = 1; b = 0; c = 1; #10;
a = 1; b = 1; c = 0; #10;
a = 1; b = 1; c = 1; #10;

$finish;
end
endmodule