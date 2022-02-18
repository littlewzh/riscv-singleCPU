`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/31 17:36:56
// Design Name: 
// Module Name: instructionMemory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instructionMemory(           //�Ѹ�
    input RW,
    input[31:0] IAddr,
    input wren,
    output reg[31:0] IDataOut
    );
    reg[31:0] ram[1023:0];
    /*initial
    begin
        $readmemh("test.txt",storage);
    end*/
    always@(RW or IAddr)
    begin
        if(RW == 0)
        begin
            /*IDataOut[7:0] <= storage[IAddr+3];
            IDataOut[15:8] <= storage[IAddr+2];
            IDataOut[23:16] <= storage[IAddr+1];
            IDataOut[31:24] <= storage[IAddr+0];*/
            IDataOut=ram[IAddr>>2];
        end
       /* else
        begin
            storage[IAddr+0] <= IDataOut[7:0];
            storage[IAddr+1] <= IDataOut[15:8];
            storage[IAddr+2] <= IDataOut[23:16];
            storage[IAddr+3] <= IDataOut[31:24];
            //storage[IAddr] <= IDataOut;
        end*/
    end
endmodule
