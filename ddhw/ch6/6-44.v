module DFF ( output reg Q, input D, Clock, reset_b);
    always @ ( posedge Clock, negedge reset_b)
        if (reset_b == 0) Q <= 0; else Q <= D;
endmodule

module Mux_2 (output reg y, input a, b, sel);
    always @ (a, b, sel) if (sel ==1) y = b; else y = a;
endmodule

module DFF_gated ( output Q, input D, Shift_control, Clock, reset_b);
    DFF M_DFF (Q, D_internal, Clock, reset_b);
    Mux_2 M_Mux (D_internal, Q, D, Shift_control);
endmodule

module FA ( output reg carry, sum, input a, b, C_in);
    always @ (a, b, C_in) {carry, sum} = a + b + C_in;
endmodule

module Shift_Reg_gated_clock ( output SO, input S_in, input [7: 0] data, input load, Shift_control, Clock, reset_b);
    reg [7: 0] SReg;
    assign SO = SReg[0];
    always @ ( posedge Clock, negedge reset_b)
        if (reset_b == 0) SReg <= 0;
        else if (load) SReg <= data;
        else if (Shift_control) SReg <= {S_in, SReg[7: 1]};
endmodule

module ex_6_44_Str ( output SO, input [7: 0] data_A, data_B, input S_in, load, Shift_control, CLK, Clear);
    supply0 gnd;
    wire sum, carry;
    assign SO = sum;
    wire SO_A, SO_B;
    Shift_Reg_gated_clock M_A (SO_A, sum, data_A, load, Shift_control, CLK, Clear);
    Shift_Reg_gated_clock M_B (SO_B, S_in, data_B, load, Shift_control, CLK, Clear);
    FA M_FA (carry, sum, SO_A, SO_B, Q);
    DFF_gated M_FF (Q, carry, Shift_control, CLK, Clear);
endmodule


module ex_6_44_Str_tb;
    wire SO;
    reg SI, load, Shift_control, Clock, Clear;
    reg [7: 0] data_A, data_B;
    ex_6_44_Str M0 (SO, data_A, data_B, SI, load, Shift_control, Clock, Clear);
    
    initial #200 $finish ;
    initial begin Clock = 0; forever #5 Clock = ~Clock; end
    initial begin #2 Clear = 0; #4 Clear = 1; end
    initial fork
    data_A = 8'hAA; //8'h ff;
    data_B = 8'h55; //8'h01;
    SI = 0;
    #20 load = 1;
    #30 load = 0;
    #50 Shift_control = 1;
    #50 begin repeat (8) @ ( posedge Clock) ;
        #5 Shift_control = 0;
    end
    join
    initial begin $dumpfile("6-44.vcd"); $dumpvars(0, ex_6_44_Str_tb); end
endmodule