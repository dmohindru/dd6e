module priority_encoder_4(v, x, y, d);
    output reg v, x, y;
    input [3:0] d;

    //x = D1 + D0
    //y = D0 + D2.D1'
    //V = D0 + D1 + D2 + D3
    always @(d) begin
        casex(d)
            4'b0000: {x, y, v} = 3'bxx0;
            4'b0001: {x, y, v} = 3'b001;
            4'b001x: {x, y, v} = 3'b011;
            4'b01xx: {x, y, v} = 3'b101;
            4'b1xxx: {x, y, v} = 3'b111;
            
        endcase
    end
endmodule

module priority_encoder_4_tb;
    reg [3:0] in;
    //reg en;
    wire v, x, y;
    
    //Instantiate UUT
    priority_encoder_4 UUT(v, x, y, in);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("in = %b, x = %b, y = %b, v = %b", in, x, y, v);
endmodule