module ex_5_32;
    reg A, B, C, D, E, F, enable;
    reg A1, B1, C1, D1, E1, F1, enable1;

    initial 
    begin
        enable = 0; A = 1; B = 0; C = 0; D = 0; E = 1; F = 1; // t = 0
        #10 A = 0; B = 1; C = 1; //t = 10
        #10 A = 1; B = 0; D = 1; E = 0; //t = 20
        #10 B = 1; E = 1; F = 0; // t = 30
        #10 enable = 1; B = 0; D = 0; F = 1; // t = 40
        #10 B = 1; // t = 50
        #10 B = 0; D = 1; // t = 60
        #10 B = 1; // t = 70
        #10;
    end
    initial
    fork
    enable1 = 0; A1 = 1; B1 = 0; C1 = 0; D1 = 0; E1 = 1; F1 = 1; // t = 0
    #10 A1 = 0; 
    #10 B1 = 1; 
    #10 C1 = 1;
    #20 A1 = 1; 
    #20 B1 = 0; 
    #20 D1 = 1; 
    #20 E1 = 0;
    #30 B1 = 1; 
    #30 E1 = 1; 
    #30 F1 = 0;
    #40 enable1 = 1; 
    #40 B1 = 0; 
    #40 D1 = 0; 
    #40 F1 = 1; // t = 40
    #50 B1 = 1; // t = 50
    #60 B1 = 0; 
    #60 D1 = 1; // t = 60
    #70 B1 = 1; // t = 70
    #80;
    join
    initial begin $dumpfile("5-32.vcd"); $dumpvars(0, ex_5_32); end

endmodule