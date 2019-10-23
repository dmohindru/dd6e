//fig 3-25 pg. 125
module mod3_31_f(F, A, B, C, D);
    output F;
    input A, B, C, D;
    wire and1_wire, and2_wire, nor1_wire, nor2_wire;

    and G1(and1_wire, A, ~B);
    and G2(and2_wire, ~A, B);
    nor G3(nor1_wire, C, ~D);
    nor G4(nor2_wire, and1_wire, and2_wire);
    and G5(F, ~nor1_wire, ~nor2_wire);
endmodule

module mod3_31_f_tb;
reg a, b, c, d;
wire y;

mod3_31_f circuit(y, a, b, c, d);
initial
begin
$monitor("a=%b, b=%b, c=%b, d=%b, y=%b", a, b, c, d, y);
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