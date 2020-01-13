module ushift_4_beh(a_par, i_par, sel, clear_b, clk);
    output [3:0] a_par;
    input [3:0] i_par;
    input [1:0] sel;
    input lsb_in, clear_b, clk;
    reg [3:0] a_par;

    always @(posedge clk, negedge clear_b) 
    begin
        if (!clear_b) a_par <= 4'b0000;
        else if(sel[1]) a_par <= {a_par[0], a_par[3:1]}; //shift
        else if(sel[0]) a_par <= i_par; //load
    end
endmodule

module ushift_4_beh_tb;
    reg [3:0] i_par;
    reg load, shift, clear_b, clk;
    wire [3:0] a_par;

    ushift_4_beh UUT(a_par, i_par, {shift, load}, clear_b, clk);
    
    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        load = 1'b0;
        shift = 1'b0;
        i_par = 4'b0000;
        #2 clear_b = 0;
        #3 clear_b = 1;
        // Parallel load
        #10 load = 1'b1; 
        #10 shift = 1'b0;
        #10 i_par = 4'b1111;
        //hold value
        #20 load = 1'b0; 
        #20 shift = 1'b0;
        //shift right
        #50 load = 1'b0; 
        #50 shift = 1'b1;
        //shift right
        #70 load = 1'b1;
        #70 shift = 1'b1; 
        //Parallel load
        #100 load = 1'b1; 
        #100 shift = 1'b0;
        #100 i_par = 4'b1100;
        //hold value
        #110 load = 2'b00; 
        #110 shift = 2'b00; 
    join
    initial begin $dumpfile("6-35-d.vcd"); $dumpvars(0, ushift_4_beh_tb); end
endmodule