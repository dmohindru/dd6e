//fig 3-21 (b) pg. 123
module mod3_31_d(F, A, B, C, D);
    output F;
    input A, B, C, D;
    wire nand1_wire, nand2_wire, or1_wire, or2_wire, nand3_wire;

    nand G1(nand1_wire, A, ~B);
    nand G2(nand2_wire, ~A, B);
    or G3(or1_wire, C, ~D);
    or G4(or2_wire, ~nand1_wire, ~nand2_wire);
    and G5(F, or1_wire, or2_wire);
endmodule

module mod3_31_d_tb;
reg a, b, c, d;
wire y;

mod3_31_d circuit(y, a, b, c, d);
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