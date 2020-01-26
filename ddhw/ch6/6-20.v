module binary_couner_4_par_load(a_count, c_out, data_in, count, load, clk, clear_b);
    output reg [3:0] a_count;
    output c_out;
    input [3:0] data_in;
    input count, load, clk, clear_b;

    assign c_out = count && (~load) && (a_count == 4'b1111);

    always @(posedge clk, negedge clear_b) begin
        if (~clear_b) a_count <= 4'b0000;
        else if (load) a_count <= data_in;
        else if (count) a_count <= a_count + 1'b1;
    end
endmodule

module binary_counter_64(a_count, clk, clear_b);
    output [7:0] a_count;
    input clk, clear_b;

    wire [3:0] low_nibble, high_nibble;
    wire c_out0, c_cout1;
    binary_couner_4_par_load m0(low_nibble, c_out_0, 4'b0000, 1'b1, high_nibble[2], clk, clear_b);
    binary_couner_4_par_load m1(high_nibble, c_cout1, 4'b0000, c_out_0, high_nibble[2], clk, clear_b);

    assign a_count = {high_nibble, low_nibble};

endmodule

module binary_counter_64_tb;
    reg clk, clear_b;
    wire [7:0] a_count;

    binary_counter_64 UUT(a_count, clk, clear_b);

    initial #700 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        #2 clear_b = 0;
        #3 clear_b = 1;
    join
    initial begin $dumpfile("6-20.vcd"); $dumpvars(0, binary_counter_64_tb); end

endmodule