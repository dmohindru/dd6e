//fig 3-24 pg. 125
module mod3_32_e(F, A, B, C, D, E);
    output F;
    input A, B, C, D, E;
    wire nor1_wire, nor2_wire;

    nor G1(nor1_wire, A, B);
    nor G2(nor2_wire, C, D);
    and G3(F, ~nor1_wire, ~nor2_wire, E);
endmodule

module mod3_32_e_tb;
reg a, b, c, d, e;
wire y;

mod3_32_e circuit(y, a, b, c, d, e);
initial
begin
$monitor("a=%b, b=%b, c=%b, d=%b, e=%b, y=%b", a, b, c, d, e, y);
a = 0; b = 0; c = 0; d = 0; e = 0;  #10;
a = 0; b = 0; c = 0; d = 0; e = 1;  #10;
a = 0; b = 0; c = 0; d = 1; e = 0;  #10;
a = 0; b = 0; c = 0; d = 1; e = 1;  #10;
a = 0; b = 0; c = 1; d = 0; e = 0;  #10;
a = 0; b = 0; c = 1; d = 0; e = 1;  #10;
a = 0; b = 0; c = 1; d = 1; e = 0;  #10;
a = 0; b = 0; c = 1; d = 1; e = 1;  #10;
a = 0; b = 1; c = 0; d = 0; e = 0;  #10;
a = 0; b = 1; c = 0; d = 0; e = 1;  #10;
a = 0; b = 1; c = 0; d = 1; e = 0;  #10;
a = 0; b = 1; c = 0; d = 1; e = 1;  #10;
a = 0; b = 1; c = 1; d = 0; e = 0;  #10;
a = 0; b = 1; c = 1; d = 0; e = 1;  #10;
a = 0; b = 1; c = 1; d = 1; e = 0;  #10;
a = 0; b = 1; c = 1; d = 1; e = 1;  #10;
a = 1; b = 0; c = 0; d = 0; e = 0;  #10;
a = 1; b = 0; c = 0; d = 0; e = 1;  #10;
a = 1; b = 0; c = 0; d = 1; e = 0;  #10;
a = 1; b = 0; c = 0; d = 1; e = 1;  #10;
a = 1; b = 0; c = 1; d = 0; e = 0;  #10;
a = 1; b = 0; c = 1; d = 0; e = 1;  #10;
a = 1; b = 0; c = 1; d = 1; e = 0;  #10;
a = 1; b = 0; c = 1; d = 1; e = 1;  #10;
a = 1; b = 1; c = 0; d = 0; e = 0;  #10;
a = 1; b = 1; c = 0; d = 0; e = 1;  #10;
a = 1; b = 1; c = 0; d = 1; e = 0;  #10;
a = 1; b = 1; c = 0; d = 1; e = 1;  #10;
a = 1; b = 1; c = 1; d = 0; e = 0;  #10;
a = 1; b = 1; c = 1; d = 0; e = 1;  #10;
a = 1; b = 1; c = 1; d = 1; e = 0;  #10;
a = 1; b = 1; c = 1; d = 1; e = 1;  #10;
$finish;
end
endmodule