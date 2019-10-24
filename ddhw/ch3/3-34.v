module mod3_34(Out_1, Out_2, Out_3, A, B, C, D);
    output Out_1, Out_2, Out_3;
    input A, B, C, D;
    
    assign Out_1 = (C || B) && (!A || D) && B;
    assign Out_2 = ((C && !B) || (A && B && C) || (!C && B)) && (A || !D);
    assign Out_3 = (C && ((A && D) || B)) || (C && !A);

    
endmodule

module mod3_34_tb;
reg a, b, c, d;
wire out1, out2, out3;

mod3_34 circuit(out1, out2, out3, a, b, c, d);
initial
begin
$monitor("a=%b, b=%b, c=%b, d=%b, out1=%b, out2=%b, out3=%b", a, b, c, d, out1, out2, out3);
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