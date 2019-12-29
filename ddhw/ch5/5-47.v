module ex_5_47(out, run, clk, rst);
    output [3:0] out;
    input run, clk, rst;
    reg [3:0] out;
    reg [3:0] state, next_state;

    parameter S0 = 4'b0000, S2 = 4'b0010, S4 = 4'b0100, S6 = 4'b0110, 
              S8 = 4'b1000, S10 = 4'b1010, S12 = 4'b1100, S14 = 4'b1110;
    
    // present state logic
    always @(posedge clk, negedge rst) 
    begin
        if (!rst) state <= S0; 
        else state <= next_state;
    end

    //next state logic
    always @(state, run) begin
        case (state)
            S0:  begin out = S0;  if (run) next_state = S2;  else next_state = S0;  end
            S2:  begin out = S2;  if (run) next_state = S4;  else next_state = S2;  end
            S4:  begin out = S4;  if (run) next_state = S6;  else next_state = S4;  end
            S6:  begin out = S6;  if (run) next_state = S8;  else next_state = S6;  end
            S8:  begin out = S8;  if (run) next_state = S10; else next_state = S8;  end
            S10: begin out = S10; if (run) next_state = S12; else next_state = S10; end
            S12: begin out = S12; if (run) next_state = S14; else next_state = S12; end
            S14: begin out = S14; if (run) next_state = S0;  else next_state = S14; end
            default: begin out = S0; next_state = S0; end
        endcase
    end

endmodule


module ex_5_47_tb;
    reg run, clk, rst;
    wire [3:0] out;

    ex_5_47 UUT(out, run, clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        rst = 1;
        run = 0;
        #2 rst = 0;
        #4 rst = 1;
        #10 run = 1;
        #50 run = 0;
        #80 run = 1;
    join
    initial begin $dumpfile("5-47.vcd"); $dumpvars(0, ex_5_47_tb); end

endmodule