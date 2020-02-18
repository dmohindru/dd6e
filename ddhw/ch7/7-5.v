module memory(Enable, ReadWrite, Address, DataIn, DataOut);
    input Enable, ReadWrite;
    input [3:0] DataIn;
    input [5:0] Address;
    output [3:0] DataOut;
    reg [3:0] DataOut;
    reg [3:0] Mem [0:63];

    always @ (Enable or ReadWrite or DataIn) begin
        if (Enable) begin
            if(ReadWrite) DataOut = Mem[Address];
            else Mem[Address] = DataIn; 
        end
        else
            DataOut = 4'bz;
    end

endmodule

module memory_tb;
    reg Enable, ReadWrite;
    reg [3:0] DataIn;
    reg [5:0] Address;
    wire [3:0] DataOut;

    memory UUT(Enable, ReadWrite, Address, DataIn, DataOut);

    initial #150 $finish;
    initial fork
        // write mem[5] = 7;
        #10 Address = 6'b000101;
        #10 DataIn = 4'b0111;
        #10 Enable = 1'b1;
        #10 ReadWrite = 4'b0;
        // wait few cycles
        // wriet mem[7] = 5;
        #40 Address = 6'b000111;
        #40 DataIn = 4'b0101;
        #40 Enable = 1'b1;
        #40 ReadWrite = 4'b0;
        //wait few cycles
        //read mem[5]
        #80 Address = 6'b000101;
        #80 Enable = 1'b1;
        #80 ReadWrite = 4'b1;

        #90 Enable = 1'b0;
        //read mem[7]
        #100 Address = 6'b000111;
        #100 Enable = 1'b1;
        #100 ReadWrite = 4'b1;

        #120 Enable = 1'b0;

    join
    initial begin $dumpfile("7-5.vcd"); $dumpvars(0, memory_tb); end

endmodule