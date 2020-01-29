module ex_6_37_a(count, clk, reset);
    output [2:0] count;
    input clk, reset;
    reg [2:0] count;

    always @(posedge clk, negedge reset) begin
        if(!reset)
            count <= 3'b000;
        else if(count == 3'b000)
            count <= 3'b011;
        else if(count == 3'b011)
            count <= 3'b001;
        else if(count == 3'b001)
            count <= 3'b111;
        else if(count == 3'b111)
            count <= 3'b110;
        else if(count == 3'b110)
            count <= 3'b100;
        else if(count == 3'b100)
            count <= 3'b000;
    end
endmodule

module ex_6_37_b(count, clk, reset);
    output [2:0] count;
    input clk, reset;
    reg [2:0] count;

    always @(posedge clk, negedge reset) begin
        if(!reset)
            count <= 3'b000;
        else begin
            case(count)
                3'b000: count <= 3'b011;
                3'b001: count <= 3'b111;
                3'b011: count <= 3'b001;
                3'b100: count <= 3'b000;
                3'b110: count <= 3'b100;
                3'b111: count <= 3'b110;
                default: count <= 3'b000;
            endcase
        end
    end
endmodule

module ex_6_37_c(count, clk, reset);
    output [2:0] count;
    input clk, reset;
    reg [2:0] count, next_count;
    
    parameter S0 = 3'b000, S1 = 3'b001, S3 = 3'b011, S4 = 3'b100,
               S6 = 3'b110, S7 = 3'b111;
    // present state logic
    always @(posedge clk, negedge reset) begin
        if (!reset) count <= S0;
        else count <= next_count;
    end

    //next state logic
    always @(count) begin
        case (count)
            S0: next_count = S3;
            S1: next_count = S7;   
            S3: next_count = S1; 
            S4: next_count = S0;   
            S6: next_count = S4; 
            S7: next_count = S6; 
            default: next_count = S0;
        endcase
    end
endmodule

module ex_6_37_tb;
    reg clk, reset;
    wire [2:0] count_a, count_b, count_c;

    ex_6_37_a UUTa(count_a, clk, reset);
    ex_6_37_b UUTb(count_b, clk, reset);
    ex_6_37_c UUTc(count_c, clk, reset);
    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        #2 reset = 0;
        #3 reset = 1;
    join
    initial begin $dumpfile("6-37.vcd"); $dumpvars(0, ex_6_37_tb); end
endmodule