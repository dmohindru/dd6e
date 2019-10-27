module Circuit_C(y1, y2, a, b);
output y1, y2;
input a, b;
assign y1 = a & b;
or (y2, a, b);
endmodule

module Circuit_C_tb;
reg a, b;
wire y1, y2;

Circuit_C circuit(y1, y2, a, b);
initial
begin
$monitor("a=%b, b=%b, y1=%b, y2=%b", a, b, y1, y2);
a = 0; b = 0; #10;
a = 0; b = 1; #10;
a = 1; b = 0; #10;
a = 1; b = 1; #10;

$finish;
end
endmodule