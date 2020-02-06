module ex_6_48_a(count, clk, reset);
    output [7:0] count;
    input clk, reset;
    reg [7:0] count, next_count;

    parameter s0 = 8'b00000010, s1 = 8'b00000001, s2 = 8'b00000100, s3 = 8'b00001000, s4 = 8'b00000000,
              s5 = 8'b00010000, s6 = 8'b00010001, s7 = 8'b00100000, s8 = 8'b01000000, s9 = 8'b01000001,
              s10 = 8'b10000000;
    
    always @(posedge clk, negedge reset) begin
        if (!reset)
            count <= s0;
        else
            count <= next_count;
    end

    always @(count) begin
        case (count)
        
        endcase
        
    end

endmodule