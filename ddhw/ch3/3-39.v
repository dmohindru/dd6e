module add_half(s, c, a, b);
output s, c;
input a, b;
xor (s, a, b);
and (c, a, b);
endmodule

module add_half_tb;
reg a, b;
wire s, c;

add_half circuit(s, c, a, b);

initial 
begin
$monitor("a=%b, b=%b, s=%b, c=%b", a, b, s, c);
a = 0; b = 0; #10;
a = 0; b = 1; #10;
a = 1; b = 0; #10;
a = 1; b = 1; #10;
$finish;
end
endmodule