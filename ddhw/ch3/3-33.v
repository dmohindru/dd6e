`timescale 1 ns/ 1 ps
/*
Wavedrom code
{signal: [
  {name: 'x', wave: 'l........................'},
  {name: 'y', wave: 'l....h...................'},
  {name: '!x', wave: 'l.h......................'},
  {name: '!y', wave: 'l.h....l.................'},
  {name: 'x.!y', wave: 'l........................'},
  {name: '!x.y', wave: 'l........h...............'},
  {name: 'x.!y + !x.y', wave: 'l.............h..........'},
  ],
  head: {tick:0} 
}
*/
module xor_gate_2(f, x, y);
    output f;
    input x, y;
    wire not_x, not_y, x_not_y, not_x_y;
    not #4 g1 (not_x, x);               //Prop delay 4 ns
    not #4 g2 (not_y, y);               //Prop delay 4 ns
    and #8 g3 (x_not_y, x, not_y);      //Prop delay 8 ns
    and #8 g4 (not_x_y, not_x, y);      //Prop delay 8 ns
    or  #10 g5(f, x_not_y, not_x_y);   //Prop delay 10 ns

endmodule

module xor_gate_tb;
reg x, y;
wire f;

xor_gate_2 gate(f, x, y);
initial begin
$dumpfile("xorgate.vcd");
$dumpvars(0, gate);
x = 1'b0; y = 1'b0;
#10 y = 1'b1;
end

initial  #50 $finish;
endmodule