module ex_6_48_a(count, clk, reset);
    output [7:0] count;
    input clk, reset;
    reg [7:0] count, next_count;
    reg [3:0] state;
    
    always @(posedge clk, negedge reset) begin
        if (!reset)
            state <= 4'b0000;
        else if (state > 13)
            state <= 4'b0000;
        else
            state <= state + 1'b1;
    end

    always @(state) begin
        case (state)
            4'b0000: count = 8'b0000_0010;
            4'b0001: count = 8'b0000_0001;
            4'b0010: count = 8'b0000_0100;
            4'b0011: count = 8'b0000_0001;
            4'b0100: count = 8'b0000_1000;
            4'b0101: count = 8'b0000_0000;
            4'b0110: count = 8'b0001_0000;
            4'b0111: count = 8'b0001_0001;
            4'b1000: count = 8'b0010_0000;
            4'b1001: count = 8'b0000_0001;
            4'b1010: count = 8'b0100_0000;
            4'b1011: count = 8'b0100_0001;
            4'b1100: count = 8'b1000_0000;
            4'b1101: count = 8'b0000_0001;
            default: count = 8'b0000_0010;
        endcase
    end
endmodule

module ex_6_48_b(count, clk, reset);
    output [7:0] count;
    input clk, reset;
    reg [7:0] count, next_count;
    reg [3:0] state;
    
    always @(posedge clk, negedge reset) begin
        if (!reset)
            state <= 4'b0000;
        else if (state > 13)
            state <= 4'b0000;
        else
            state <= state + 1'b1;
    end

    always @(state) begin
        case (state)
            4'b0000: count = 8'b0100_0000;
            4'b0001: count = 8'b1000_0000;
            4'b0010: count = 8'b0010_0000;
            4'b0011: count = 8'b1000_0000;
            4'b0100: count = 8'b0001_0000;
            4'b0101: count = 8'b1000_0000;
            4'b0110: count = 8'b0000_1000;
            4'b0111: count = 8'b1000_0000;
            4'b1000: count = 8'b0000_0100;
            4'b1001: count = 8'b1000_0000;
            4'b1010: count = 8'b0000_0010;
            4'b1011: count = 8'b1000_0000;
            4'b1100: count = 8'b0000_0001;
            4'b1101: count = 8'b1000_0000;
            default: count = 8'b0100_0000;
        endcase
    end
endmodule

module ex_6_48_tb;
    reg clk, reset;
    wire [7:0] count_a, count_b;

    ex_6_48_a UUT0(count_a, clk, reset);
    ex_6_48_b UUT1(count_b, clk, reset);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        #2 reset = 0;
        #3 reset = 1;
    join
    initial begin $dumpfile("6-48.vcd"); $dumpvars(0, ex_6_48_tb); end


endmodule
