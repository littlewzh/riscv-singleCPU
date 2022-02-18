`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/31 17:36:56
// Design Name: 
// Module Name: decodeInstruction
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


module decodeInstruction(
input [31:0] ins,
output [6:0] op,
output [2:0] fun3,
output [4:0] rd,
output [4:0] rs1,
output [4:0] rs2,
output [6:0] fun7,
output [24:0] imm
    );
    assign imm=ins[31:7];
    assign rd=ins[11:7];
    assign rs1=ins[19:15];
    assign fun3=ins[14:12];
    assign rs2=ins[24:20];
    assign fun7=ins[31:25];
    assign op=ins[6:0];
endmodule
