module seven_seg_driver(seven_seg, w, x, y, z);
    output [6:0] seven_seg;
    input w, x, y, z;
    //seven_seg [6] = a, seven_seg [5] = b, seven_seg [4] = c
    //seven_seg [3] = d, seven_seg [2] = e, seven_seg [1] = f
    //seven_seg [0] = g
    //a = wx'y' + w'xz + w'y + x'y'z'
    //b = w'y'z' + w'yz + w'x' + x'y'
    //c = x'y' + w'z + w'x
    //d = w'xy'z + w'x'y + w'yz' + wx'y' + x'y'z'
    //e = x'y'z' + w'yz'
    //f = w'xy' + w'xz' + wx'y' + x'y'z'
    //g = w'x'y + w'xy' + wx'y' + w'xz'
    assign seven_seg[6] = (w&~x&~y) | (~w&x&z) | (~w&y) | (~x&~y&~z);                       //a
    assign seven_seg[5] = (~w&~y&~z) | (~w&y&z) | (~w&~x) | (~x&~y);                        //b
    assign seven_seg[4] = (~x&~y) | (~w&z) | (~w&x);                                        //c
    assign seven_seg[3] = (~w&x&~y&z) | (~w&~x&y) | (~w&y&~z) | (w&~x&~y) | (~x&~y&~z);     //d
    assign seven_seg[2] = (~x&~y&~z) | (~w&y&~z);                                           //e
    assign seven_seg[1] = (~w&x&~y) | (~w&x&~z) | (w&~x&~y) | (~x&~y&~z);                   //f
    assign seven_seg[0] = (~w&~x&y) | (~w&x&~y) | (w&~x&~y) | (~w&x&~z);                    //g
endmodule

module seven_seg_driver_tb;
    reg [3:0] in;
    wire [6:0] f;
    //Instantiate UUT
    seven_seg_driver UUT(f, in[3], in[2], in[1], in[0]);

    //stimulus block
    initial
        begin
            in = 4'b0000;
            repeat(15) #10 in = in + 1'b1;
        end
    initial $monitor("in = %b, seg_out = %b", in, f);
endmodule