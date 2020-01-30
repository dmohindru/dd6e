module ex_6_50_a(out, clk, reset);
    output [2:0] out;
    input clk, reset;
    reg [2:0] out;

    always @(posedge clk, negedge reset) begin
        if (!reset)
            out <= 3'b000;
        else begin
            case (out)
                3'b000: out <= 3'b100;
                3'b001: out <= 3'b110;
                3'b010: out <= 3'b001;
                3'b100: out <= 3'b010;
                3'b110: out <= 3'b000;
                default: out <= 3'b000;
            endcase
        end
    end
endmodule

module ex_6_50_b(out, clk, reset);
    output [2:0] out;
    input clk, reset;
    reg [2:0] out;

    always @(posedge clk, negedge reset) begin
        if (!reset)
            out <= 3'b000;
        else begin
            case (out)
                3'b000: out <= 3'b001;
                3'b001: out <= 3'b010;
                3'b010: out <= 3'b100;
                3'b100: out <= 3'b110;
                3'b110: out <= 3'b000;
                default: out <= 3'b000;
            endcase
        end
    end
endmodule

module ex_6_50_tb;
    reg clk, reset;
    wire [2:0] ex_27, ex_28;

    ex_6_50_a UUTa(ex_27, clk, reset);
    ex_6_50_b UUTb(ex_28, clk, reset);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial fork
        reset = 1;
        #2 reset = 0;
        #3 reset = 1;
    join
    initial begin $dumpfile("6-50.vcd"); $dumpvars(0, ex_6_50_tb); end
endmodule