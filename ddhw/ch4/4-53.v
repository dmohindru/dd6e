
//behaviorial 4 bit adder
module Add_4(c_out, sum, a, b, c_in);
    output c_out;
    output [3:0] sum;
    input [3:0] a, b;
    input c_in;
    assign {c_out, sum} = a + b + c_in;
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

module BCD_usign_tb;
    reg [3:0] a, b;
    reg c_in;
    wire [3:0] s;
    wire c_out;
    integer i, j, k;

    //Instantiate UUT
    BCD_usign_adder_4 UUT(s, c_out, a, b, c_in);
    
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