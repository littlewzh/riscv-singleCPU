`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/31 17:36:56
// Design Name: 
// Module Name: ALU32
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


module ALU32(                        //�Ѹ�
    input[3:0] ALUopcode,
    input[31:0] rega,
    input[31:0] regb,
    output reg[31:0] result,
    output zero,
    output less
    );
    reg [63:0] temp;
    always@(ALUopcode or rega or regb)
    begin
       case(ALUopcode)
       4'b0000:result = rega + regb;
       4'b1000:result = rega - regb;
       4'b0001:result = (rega << regb[4:0]);
       4'b0010:begin // ??��???��???
            if(rega < regb && (rega[31] == regb[31]))result = 1;
            else if (rega[31] == 1 && regb[31] == 0) result = 1;
            else result = 0;
       end
       4'b0011:result = (rega < regb)?1:0;
       4'b1111:result=regb;
       4'b0100:result = rega ^ regb;
       4'b0101:result = (rega>>regb[4:0]);
       4'b1101: begin                                   //some problem ��������
             temp={{32{rega[31]}},rega[31:0]}>>regb[4:0];
             result=temp[31:0];   
             end
       4'b0110:result = rega | regb;
       4'b0111:result = rega & regb;
       default :begin end
       endcase
    end
    assign zero = (rega-regb == 0)?1:0;
    assign less=result[0];
endmodule
