`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/31 17:36:56
// Design Name: 
// Module Name: PCSelector
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


module PCSelecter(
input clk,
input [2:0]branch,
input reset,
input zero,
input result0,
input [31:0] busa,
input [31:0] imm,
input [31:0] pc,
//output reg nxtasrc,
//output reg nxtbsrc
output reg [31:0]nextpc,
input waitt
    );
always@(negedge clk)
begin
if(reset==1) nextpc=32'h80000000;
else if(waitt) begin end
else
begin
 case(branch)
  3'b000:begin //����תָ��
    nextpc=pc+4;end
  3'b001:begin //jal����������ת PC Ŀ��
   nextpc=pc+imm;
   end
  3'b010:begin //jalr����������ת�Ĵ���Ŀ��
   nextpc=busa+imm;
   end
  3'b100:begin //beq��������֧������
    nextpc=(zero==1 ?pc+imm :pc+4 );
    end
  3'b101:begin //bne��������֧��������
    nextpc=(!zero==1 ?pc+imm :pc+4 );
    end
  3'b110:begin //,bltu��������֧��С��
    nextpc=(result0==1 ?pc+imm :pc+4 );
    end
  3'b111:begin //bge,bgeu��������֧�����ڵ���
     nextpc=(zero|!result0)==1 ?pc+imm :pc+4 ;
    end
  default:begin end
 endcase
end
end
endmodule
