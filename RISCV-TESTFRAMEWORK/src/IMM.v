`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/01 10:04:09
// Design Name: 
// Module Name: IMM
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


module InstrToImm(
input [31:7] instr,
input [2:0] extop,
output reg [31:0] imm
    );
always @(*)
begin
 case(extop)
 3'b000:begin// I
  imm[11:0]=instr[31:20];
  imm[31:12]={20{instr[31]}};
 end
 3'b001:begin// U
  imm[31:12]=instr[31:12];
  imm[11:0]=0;
 end
 3'b010:begin// S
  imm[11:5]=instr[31:25];
  imm[4:0]=instr[11:7];
  imm[31:12]={20{instr[31]}};
 end
 3'b011:begin// B
  imm={{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
 end
 3'b100:begin// J
  imm={{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
 end
 default:begin end
 endcase
end
endmodule
