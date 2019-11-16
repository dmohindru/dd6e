//behaviorial 4 bit adder
module add_4(c_out, sum, a, b, c_in);
    output c_out;
    output [3:0] sum;
    input [3:0] a, b;
    input c_in;
    assign {c_out, sum} = a + b + c_in;
endmodule

//multiplier module
module multipler_4(product, multiplicant, multiplier);
    output [7:0] product;
    input [3:0] multiplicant, multiplier;
    wire [3:0] input_adder1, input_adder2, input_adder3, output_adder1, output_adder2;
    wire [2:0] w1;

    assign product[0] = multiplicant[0] & multiplier[0];
    // for inputs to adder 1
    assign w1[2] = multiplicant[0] & multiplier[3];
    assign w1[1] = multiplicant[0] & multiplier[2];
    assign w1[0] = multiplicant[0] & multiplier[1];

    assign input_adder1[3] = multiplicant[1] & multiplier[3];
    assign input_adder1[2] = multiplicant[1] & multiplier[2];
    assign input_adder1[1] = multiplicant[1] & multiplier[1];
    assign input_adder1[0] = multiplicant[1] & multiplier[0];

    add_4 m1(output_adder1[3], {output_adder1[2:0], product[1]}, input_adder1, {1'b0,w1}, 1'b0);

    // for inputs to adder 2
    assign input_adder2[3] = multiplicant[2] & multiplier[3];
    assign input_adder2[2] = multiplicant[2] & multiplier[2];
    assign input_adder2[1] = multiplicant[2] & multiplier[1];
    assign input_adder2[0] = multiplicant[2] & multiplier[0];

    add_4 m2(output_adder2[3], {output_adder2[2:0], product[2]}, input_adder2, output_adder1, 1'b0);

    // for inputs to adder 3
    assign input_adder3[3] = multiplicant[3] & multiplier[3];
    assign input_adder3[2] = multiplicant[3] & multiplier[2];
    assign input_adder3[1] = multiplicant[3] & multiplier[1];
    assign input_adder3[0] = multiplicant[3] & multiplier[0];

    add_4 m3(product[7], {product[6],product[5],product[4],product[3]}, input_adder3, output_adder2, 1'b0);


endmodule

// test bench for bcd adder subtractor
module BCD_usign_tb;
    reg [3:0] a, b;
    wire [7:0] p;
    integer i;

    //Instantiate UUT
    multipler_4 UUT(p, a, b);
    
    //stimulus block
    
    
    initial
        begin
            //b = 4'b1111;
            a = 4'b0011;
            //#200;
            for (i = 0; i <= 15; i = i+1) begin
                b = i;
                #200;
            end

        end
    initial $monitor("a = %d, b = %d, product = %d", a, b, p);
endmodule