module Mealy_Zero_Dector(y_out, x_in, clock, reset);
    output y_out;
    input x_in, clock, reset;
    reg y_out;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11; 
    reg [1:0] state, next_state;
    
    always @(posedge clock, negedge reset) begin
        if (!reset) state <= S0;
        else state <= next_state;
    end

    always @(state, x_in) begin
        case (state)
            S0: begin y_out = 0; if (x_in) next_state = S1; else next_state = S0; end
            S1: begin y_out = !x_in; if (x_in) next_state = S3; else next_state = S0; end
            S2: begin y_out = !x_in; if (!x_in) next_state = S0; else next_state = S2; end
            S3: begin y_out = !x_in; if (x_in) next_state = S2; else next_state = S0; end
        endcase   
    end
endmodule

module Mealy_Zero_Dector_tb;
    reg t_x_in, t_clock, t_reset;
    wire t_y_out;

    Mealy_Zero_Dector UUT(t_y_out, t_x_in, t_clock, t_reset);
    initial #200 $finish;
    initial begin t_clock = 0; forever #5 t_clock = ~t_clock; end
    initial fork
        t_reset = 0;
        #2 t_reset = 1;
        #87 t_reset = 0;
        #89 t_reset = 1;
        #10 t_x_in = 1;
        #30 t_x_in = 0;
        #40 t_x_in = 1;
        #50 t_x_in = 0;
        #52 t_x_in = 1;
        #54 t_x_in = 0;
        #80 t_x_in = 1;
        #100 t_x_in = 0;
        #120 t_x_in = 1;
    join
    //initial $monitor("t_y_out = %b, t_x_in = %b, t_clock = %b, t_reset = %b", t_y_out, t_x_in, t_clock, t_reset); 
    //code to generate vcd file from verilog taken from
    //https://iverilog.fandom.com/wiki/GTKWAVE
    initial begin $dumpfile("5-27.vcd"); $dumpvars(0, Mealy_Zero_Dector_tb); end
endmodule