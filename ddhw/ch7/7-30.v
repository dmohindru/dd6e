module memory(Enable, ReadWrite, clk, Address, DataIn, DataOut);
    input Enable, ReadWrite, clk;
    input [3:0] DataIn;
    input [5:0] Address;
    output [3:0] DataOut;
    reg [3:0] DataOut;
    reg [3:0] Mem [0:63];

    always @ (posedge clk) begin
        if (Enable) begin
            if(ReadWrite) DataOut = Mem[Address];
            else Mem[Address] = DataIn; 
        end
        else
            DataOut = 4'bz;
    end

endmodule