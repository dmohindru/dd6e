//fig 3-20 (a) pg. 122
module mod3_31_a(F, A, B, C, D);
    output F;
    input A, B, C, D;
    wire and1_wire, and2_wire, or2_wire, and3_wire;

    and G1(and1_wire, C, D);
    or G2(or2_wire, and1_wire, B);
    and G3(and2_wire, B, ~C);
    and G4(and3_wire, or2_wire, A);
    or G5(F, and3_wire, and2_wire);
endmodule

module mod3_31_a_tb;
reg a, b, c, d;
wire y;

mod3_31_a circuit(y, a, b, c, d);
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