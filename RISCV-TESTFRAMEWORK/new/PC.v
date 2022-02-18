`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/31 17:36:56
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset,
    input PCWre,
    input[31:0] nextPC,
    output reg[31:0] currentPC
    );
    always@(negedge clk)
    begin
        if(reset == 1)
        begin
            currentPC = 32'h80000000;
        end
        else
        begin
            if(!PCWre) currentPC =nextPC;
        end
    end
endmodule
