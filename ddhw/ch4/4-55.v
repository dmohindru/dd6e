
//behaviorial 4 bit adder
module Add_4(c_out, sum, a, b, c_in);
    output c_out;
    output [3:0] sum;
    input [3:0] a, b;
    input c_in;
    assign {c_out, sum} = a + b + c_in;
endmodule

//signed BCD adder
module BCD_sign_adder_4(sum, cout, addend, augend, cin);
    output [3:0] sum;
    output cout;
    input [3:0] addend, augend;
    input cin;
    wire [3:0] augend_complement, augend_out;

    //instantiate a 9's complement module for subtraction
    BCD_9_complement m1(augend_complement, augend);

    //instantiate quad 2X1 mux
    mux_quad_2x1 m2(augend_out, augend, augend_complement, cin);

    //instantiate bcd adder
    BCD_usign_adder_4 m3(sum, cout, addend, augend_out, cin);

endmodule

//Unsigned BCD adder
module BCD_usign_adder_4(sum, cout, addend, augend, cin);
    output [3:0] sum;
    output cout;
    input [3:0] addend, augend;
    input cin;
    wire [3:0] add_1_out, add_2_addend;
    wire carry_1_out, carry_2_out;
    supply0 gnd;

    // initiate first 4 bit unsigned adder
    Add_4 adder1(carry_1_out, add_1_out, addend, augend, cin);
    assign cout = carry_1_out | add_1_out[3]&add_1_out[2] | add_1_out[3]&add_1_out[1];

    //assign add_2_addend = {1'b0, cout, cout, 1'b0};
    // initiate second 4 bit unsigned adder
    Add_4 adder2(carry_2_out, sum, {1'b0, cout, cout, 1'b0}, add_1_out, 1'b0);

endmodule

//bcd 9's complement
module BCD_9_complement(a, x);
    output [3:0] a;
    input [3:0] x;

    //A = w'x'y'
    //B = x'y + xy'
    //C = y
    //D = z'
    assign a[3] = ~x[3] & ~x[2] & ~x[1];
    assign a[2] = x[2] ^ x[1];
    assign a[1] = x[1];
    assign a[0] = ~x[0];
endmodule

//Behavioral quad 2x1 Mux
module mux_quad_2x1(m_out, a, b, select);
    output [3:0] m_out;
    input [3:0] a, b;
    input select;
    reg [3:0] m_out;

    always @ (a, b, select)
        case (select)
            1'b0: m_out <= a;
            1'b1: m_out <= b; 
        endcase
endmodule

// test bench for testing quad 2X1 mux
/*module mux_tb;
    reg [3:0] a, b;
    reg sel;
    wire [3:0] mout;

    mux_quad_2x1 mux(mout, a, b, sel);
    //stimulus block
    initial #300 $finish;
    
    initial
        begin
            a = 4'b0101;
            b = 4'b1111;
            sel = 1'b0;
            #100;
            sel = 1'b1;
            #100;
        end
    initial $monitor("a = %d, b = %d, sel = %d, mout = %d", a, b, sel, mout);
endmodule
*/
// test bench for bcd adder subtractor
module BCD_usign_tb;
    reg [3:0] a, b;
    reg c_in;
    wire [3:0] s;
    wire c_out;
    integer i, j, k;

    //Instantiate UUT
    BCD_sign_adder_4 UUT(s, c_out, a, b, c_in);
    
    //stimulus block
    initial #30000 $finish;
    
    initial
        begin
            c_in = 1'b0;
            for (i = 0; i <= 1; i = i+1) begin
                c_in = i; #50;
                for (j = 0; j <= 9; j = j+1) begin
                    a = j; #50;
                    for (k = 0; k <= 9; k = k+1) begin
                        b = k; #50;
                    end
                end

            end
        end
    initial $monitor("a = %d, b = %d, c_in = %d, sum = %d%d", a, b, c_in, c_out, s);
endmodule
