module ex_6_35_j(s_out, par_in, load, shift, clear_b, clk);
    output s_out;
    input [3:0] par_in;
    input load, shift, clear_b, clk;

    reg carry;
    reg [3:0] number;
    wire S0 = ~number[0];
    
    assign s_out = S0 ^ carry;
    
    always @(posedge clk, negedge clear_b) begin
        if (!clear_b) begin
            number <= 4'b0000;
            carry <= 1'b1;
        end
        else if(load) begin
            number <= par_in;
        end
        else if(shift) begin
            carry <= S0 & carry;
            number = {s_out, number[3:1]};
            //s_out <= S0 ^ carry;
        end
    end
endmodule

module ex_6_35_j_tb;
    reg load, shift, clear_b, clk;
    reg [3:0] par_in;
    wire s_out;

    ex_6_35_j UUT(s_out, par_in, load, shift, clear_b, clk);
    
    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        shift = 0;
        load = 0;
        par_in = 4'b0000;
        #2 clear_b = 0;
        #3 clear_b = 1;
        //load 0001 into register
        #10 load = 1;
        #10 par_in = 4'b0010;
        //start the process of converting number to it's 2's complement
        #20 load = 0;
        #20 shift = 1;
        #70 shift = 0;

    join
    initial begin $dumpfile("6-35-j.vcd"); $dumpvars(0, ex_6_35_j_tb); end
    

endmodule