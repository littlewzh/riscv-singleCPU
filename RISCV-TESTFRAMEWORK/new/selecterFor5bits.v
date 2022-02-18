`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/31 17:36:56
// Design Name: 
// Module Name: selecterFor5bits
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


module selecterFor32bits4(
    input [1:0]src,
    input[31:0] input1,
    input[31:0] input2,
    input[31:0] input3,
    output reg[31:0] outputResult
    );
    always@(src or input1 or input2)
    begin
        if(src == 0)
        begin
            outputResult = input1;
        end
        else if(src==1)
        begin
            outputResult = input2;
        end
        else if(src==2)
        begin
             outputResult = input3;
        end
    end
endmodule