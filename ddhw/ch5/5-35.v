//`include "../lib/d-flipflop.v"

/*module ex_5_35(z, x, y, Clk, Rst);
    output z;
    input x, y, Clk, Rst;
    wire Qa, Qb, Da, Db;

    assign Da = ~x&y | x&Qa;
    assign Db = x&Qa | ~x&Qb;
    assign z = Qb;

    D_flipflop a(Qa, Da, Clk, Rst);
    D_flipflop b(Qb, Db, Clk, Rst);

endmodule
*/
module ex_5_35(z, x, y, clk, rst);
    output z;
    input x, y, clk, rst;
    reg z;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    parameter I0 = 2'b00, I1 = 2'b01, I2 = 2'b10, I3 = 2'b11;

    reg [1:0] state, next_state;

    //current state logic
    always @(posedge clk, negedge rst) begin
        if (!rst) begin state <= S0; next_state <= S0; end
        else state <= next_state;
    end

    //next state logic
    always @(state, x, y) begin
        case (state)
            S0: begin
                case ({x,y})
                    I0, I2, I3: begin z = 0; next_state = S0; end
                    I1: begin z = 0; next_state = S2; end
                endcase
            end
            S1: begin
                case ({x,y})
                    I0: begin z = 1; next_state = S1; end
                    I1: begin z = 1; next_state = S3; end
                    I2, I3: begin z = 1; next_state = S0; end
                endcase
            end
            S2: begin
                case ({x,y})
                    I0: begin z = 0; next_state = S0; end
                    I1: begin z = 0; next_state = S2; end
                    I2, I3: begin z = 0; next_state = S3; end
                endcase
            end
            S3: begin
                case ({x,y})
                    I0: begin z = 1; next_state = S1; end
                    I1, I2, I3: begin z = 1; next_state = S3; end
                endcase
            end
        endcase
    end

endmodule
//TODO: write a proper test bench to test FSM for all the state and inputs
module ex_5_35_tb;
    reg clk, rst;
    reg [1:0] in;
    wire z;

    ex_5_35 UUT(z, in[1], in[0], clk, rst);

    initial #200 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end

    initial
        begin
            #5 rst = 1'b0;
            #5 rst = 1'b1; 
            #5 in = 2'b00;
            #10 in = 2'b10;
            #10 in = 2'b01;
            #10 in = 2'b10;
            #10 in = 2'b01;
            #10 in = 2'b00;
            #10 in = 2'b11;
            //repeat (3) #10 in = in + 1;
        end
    initial begin $dumpfile("5-35.vcd"); $dumpvars(0, ex_5_35_tb); end
endmodule