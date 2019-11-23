module octal_priority_encoder(v, x, y, z, d);
    output reg v, x, y, z;
    input [7:0] d;

    
    always @(d) begin
        casex(d)
            8'b00000000: {x, y, z, v} = 4'bxxx0;
            8'b00000001: {x, y, z, v} = 4'b0001;
            8'b0000001x: {x, y, z, v} = 4'b0011;
            8'b000001xx: {x, y, z, v} = 4'b0101;
            8'b00001xxx: {x, y, z, v} = 4'b0111;
            8'b0001xxxx: {x, y, z, v} = 4'b1001;
            8'b001xxxxx: {x, y, z, v} = 4'b1011;
            8'b01xxxxxx: {x, y, z, v} = 4'b1101;
            8'b1xxxxxxx: {x, y, z, v} = 4'b1111;
        endcase
    end
endmodule

module octal_priority_encoder_tb;
    reg [7:0] in;
    //reg en;
    wire v, x, y, z;
    
    //Instantiate UUT
    octal_priority_encoder UUT(v, x, y, z, in);

    //stimulus block
    initial
        begin
            in = 8'b00000000;
            #10 in = 8'b00000001;
            #10 in = 8'b00000010;
            #10 in = 8'b00000110;
            #10 in = 8'b00001010;
            #10 in = 8'b00010010;
            #10 in = 8'b00100010;
            #10 in = 8'b01000110;
            #10 in = 8'b10000010;

            
        end
    initial $monitor("in = %b, x = %b, y = %b, z = %b, v = %b", in, x, y, z, v);
endmodule