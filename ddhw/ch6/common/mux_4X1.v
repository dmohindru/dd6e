module mux_4x1(y, x, sel);
    output y;
    input [3:0] x;
    input [1:0] sel;
    reg y;

    always @(x, sel) begin
        case(sel)
            2'b00: y = x[0];
            2'b01: y = x[1];
            2'b10: y = x[2];
            2'b11: y = x[3];
        endcase
    end
endmodule

module mux_4x1_tb;
    reg [3:0] x;
    reg [1:0] sel;
    wire y;

    mux_4x1 UUT(y, x, sel);

    initial #100 $finish;
    initial fork
        x = 4'b1010;
        sel = 2'b00;
        #20 sel = 2'b01;
        #40 sel = 2'b10;
        #60 sel = 2'b11;
    join
    initial begin $dumpfile("mux_4x1.vcd"); $dumpvars(0, mux_4x1_tb); end
endmodule