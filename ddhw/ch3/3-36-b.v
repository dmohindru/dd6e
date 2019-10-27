module Circuit_B(F1, F2, F3, A0, A1, B0, B1);
output F1, F2, F3;
input A0, A1, B0, B1;
nor (F1, F2, F3);
or  (F2, w1, w2, w3);
and (F3, w4, w5);
and (w1, w6, B1);
or  (w2, w6, w7, B0);
and (w3, w7, B0, B1);
not (w6, A1);
not (w7, A0);
xor (w4, A1, B1);
xnor (w5, A0, B0);
endmodule

module Circuit_B_tb;
reg a0, a1, b0, b1;
wire f1, f2, f3;

Circuit_B circuit(f1, f2, f3, a0, a1, b0, b1);
initial
begin
$monitor("a0=%b, a1=%b, b0=%b, b1=%b, f3=%b, f2=%b, f1=%b", a0, a1, b0, b1, f3, f2, f1);
a0 = 0; a1 = 0; b0 = 0; b1 = 0; #10;
a0 = 0; a1 = 0; b0 = 0; b1 = 1; #10;
a0 = 0; a1 = 0; b0 = 1; b1 = 0; #10;
a0 = 0; a1 = 0; b0 = 1; b1 = 1; #10;
a0 = 0; a1 = 1; b0 = 0; b1 = 0; #10;
a0 = 0; a1 = 1; b0 = 0; b1 = 1; #10;
a0 = 0; a1 = 1; b0 = 1; b1 = 0; #10;
a0 = 0; a1 = 1; b0 = 1; b1 = 1; #10;
a0 = 1; a1 = 0; b0 = 0; b1 = 0; #10;
a0 = 1; a1 = 0; b0 = 0; b1 = 1; #10;
a0 = 1; a1 = 0; b0 = 1; b1 = 0; #10;
a0 = 1; a1 = 0; b0 = 1; b1 = 1; #10;
a0 = 1; a1 = 1; b0 = 0; b1 = 0; #10;
a0 = 1; a1 = 1; b0 = 0; b1 = 1; #10;
a0 = 1; a1 = 1; b0 = 1; b1 = 0; #10;
a0 = 1; a1 = 1; b0 = 1; b1 = 1; #10;
$finish;
end
endmodule