module ushift_4(a_par, i_par, sel, clear_b, clk);
    output [3:0] a_par;
    input [3:0] i_par;
    input [1:0] sel;
    input clear_b, clk;
    reg [3:0] a_par;

    always @(posedge clk, negedge clear_b) 
    begin
        if (!clear_b) a_par <= 4'b0000;
        else if(sel == 2'b11) a_par <= i_par;
        else if(sel == 2'b10) a_par <= 4'b0000;
        else if(sel == 2'b01) a_par <= ~a_par;
    end
    

endmodule

module ushift_4_tb;
    reg [3:0] i_par;
    reg clear_b, clk;
    reg [1:0] sel;
    wire [3:0] a_par;

    ushift_4 UUT(a_par, i_par, sel, clear_b, clk);
    
    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        clear_b = 1;
        i_par = 4'b0000;
        sel = 2'b00;
        #2 clear_b = 0;
        #3 clear_b = 1;
        // Parallel load
        #10 sel = 2'b11; 
        #10 i_par = 4'b1011;
        //hold value
        #20 sel = 2'b00; 
        //complement output
        #50 sel = 2'b01; 
        //complement output
        #60 sel = 2'b01; 
        //hold value
        #70 sel = 2'b00; 
        //zero output
        #90 sel = 2'b10;
        //hold value
        #100 sel = 2'b00;
        //Parallel load
        #140 sel = 2'b11;
        #140 i_par = 4'b1000;
        //complement output
        #150 sel = 2'b01;
        //hold value
        #160 sel = 2'b00;
    
    join
    initial begin $dumpfile("6-35-f.vcd"); $dumpvars(0, ushift_4_tb); end
endmodule