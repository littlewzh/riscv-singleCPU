`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/31 17:36:56
// Design Name: 
// Module Name: controlUnit
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



module controlUnit(
input [4:0]op,
input [2:0]func3,
input func7,
output reg [2:0]extop,
output reg regwr,
output reg [2:0]branch,
output reg memtoreg,
output reg memwr,
output reg [2:0] memop,
output reg aluasrc,
output reg [1:0] alubsrc,
output reg [3:0]aluctr
//output reg nxtasrc,
//output reg nxtbsrc
    );//ExtOp RegWr Branch MemtoReg MemWr MemOp ALUASrc ALUBSrc ALUctr NxtASrc NxtBSrc
 //extop=3'b000;regwr=0;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0000;nxtasrc=0;nxtbsrc=0;
always@(*)begin
case(op)
5'b01101: begin // lui
   extop=3'b001;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b01;aluctr=4'b1111;
 end
  5'b00101: begin // auipc
   extop=3'b001;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=1;alubsrc=2'b01;aluctr=4'b0000;
 end
  5'b00100: begin 
   case(func3)
    3'b000:begin // addi 
      extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b01;aluctr=4'b0000;
    end
    3'b010:begin // slti
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b01;aluctr=4'b0010;
    end
    3'b011:begin // sltiu 
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b01;aluctr=4'b0011;
    end
    3'b100:begin // xori
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b01;aluctr=4'b0100;
    end
    3'b110:begin // ori
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b01;aluctr=4'b0110;
    end
    3'b111:begin // andi 
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b01;aluctr=4'b0111;
    end
    3'b001:begin // slli
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b01;aluctr=4'b0001;
    end 
    3'b101:begin // srli&srai
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b01;aluctr=func7?4'b1101:4'b0101;
    end
    default :begin end
   endcase
 end
  5'b01100: begin //
   case(func3)
    3'b000:begin // add&sub
      extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=func7?4'b1000:4'b0000;
    end
    3'b001:begin // sll
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0001;
    end
    3'b010:begin // slt
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0010;
    end
    3'b011:begin // sltu
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0011;//nxtasrc=0;nxtbsrc=0;
    end
    3'b100:begin // xor
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0100;//nxtasrc=0;nxtbsrc=0;
    end
    3'b101:begin // srl&sra 
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=func7?4'b1101:4'b0101;//nxtasrc=0;nxtbsrc=0;
    end
    3'b110:begin // or
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0110;//nxtasrc=0;nxtbsrc=0;
    end 
    3'b111:begin // and 
     extop=3'b000;regwr=1;branch=3'b000;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0111;//nxtasrc=0;nxtbsrc=0;
    end
    default :begin end
   endcase
end
 5'b11011:begin //jal
   extop=3'b100;regwr=1;branch=3'b001;memtoreg=0;memwr=0; memop=0;aluasrc=1;alubsrc=2'b10;aluctr=4'b0000;//nxtasrc=0;nxtbsrc=1;
  end
 5'b11001:begin //jalr
   extop=3'b000;regwr=1;branch=3'b010;memtoreg=0;memwr=0; memop=0;aluasrc=1;alubsrc=2'b10;aluctr=4'b0000;//nxtasrc=1;nxtbsrc=1;
  end
 5'b11000:begin  //branch
   case(func3)
     3'b000:begin //beq
       extop=3'b011;regwr=0;branch=3'b100;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0010;//nxtasrc=1;nxtbsrc=1;
      end
     3'b001:begin //bne
       extop=3'b011;regwr=0;branch=3'b101;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0010;//nxtasrc=1;nxtbsrc=1;
      end
     3'b100:begin //blt
       extop=3'b011;regwr=0;branch=3'b110;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0010;//nxtasrc=1;nxtbsrc=1;
      end
     3'b101:begin //bge
       extop=3'b011;regwr=0;branch=3'b111;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0010;//nxtasrc=1;nxtbsrc=1;
      end
     3'b110:begin //bltu
       extop=3'b011;regwr=0;branch=3'b110;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0011;//nxtasrc=1;nxtbsrc=1;
      end
     3'b111:begin //bgeu
       extop=3'b011;regwr=0;branch=3'b111;memtoreg=0;memwr=0; memop=0;aluasrc=0;alubsrc=2'b00;aluctr=4'b0011;//nxtasrc=1;nxtbsrc=1;
      end
      default :begin end
   endcase
 end
 5'b00000:begin  //load
    case(func3)
      3'b000:begin  //lb
        extop=3'b000;regwr=1;branch=3'b000;memtoreg=1;memwr=0; memop=3'b000;aluasrc=0;alubsrc=2'b01;aluctr=4'b0000;//nxtasrc=0;nxtbsrc=0;
       end
      3'b001:begin //lh
        extop=3'b000;regwr=1;branch=3'b000;memtoreg=1;memwr=0; memop=3'b001;aluasrc=0;alubsrc=2'b01;aluctr=4'b0000;//nxtasrc=0;nxtbsrc=0;
       end
      3'b010:begin //lw
        extop=3'b000;regwr=1;branch=3'b000;memtoreg=1;memwr=0; memop=3'b010;aluasrc=0;alubsrc=2'b01;aluctr=4'b0000;//nxtasrc=0;nxtbsrc=0;
       end
      3'b100:begin //lbu
        extop=3'b000;regwr=1;branch=3'b000;memtoreg=1;memwr=0; memop=3'b100;aluasrc=0;alubsrc=2'b01;aluctr=4'b0000;//nxtasrc=0;nxtbsrc=0;
       end
      3'b101:begin //lhu
        extop=3'b000;regwr=1;branch=3'b000;memtoreg=1;memwr=0; memop=3'b101;aluasrc=0;alubsrc=2'b01;aluctr=4'b0000;//nxtasrc=0;nxtbsrc=0; 
       end
       default :begin end
    endcase
 end
5'b01000:begin  //store
    case(func3)
       3'b000:begin //sb
         extop=3'b010;regwr=0;branch=3'b000;memtoreg=0;memwr=1; memop=3'b000;aluasrc=0;alubsrc=2'b01;aluctr=4'b0000;//nxtasrc=0;nxtbsrc=0;
        end
       3'b001:begin //sh
         extop=3'b010;regwr=0;branch=3'b000;memtoreg=0;memwr=1; memop=3'b001;aluasrc=0;alubsrc=2'b01;aluctr=4'b0000;//nxtasrc=0;nxtbsrc=0;
        end
       3'b010:begin //sw
         extop=3'b010;regwr=0;branch=3'b000;memtoreg=0;memwr=1; memop=3'b010;aluasrc=0;alubsrc=2'b01;aluctr=4'b0000;//nxtasrc=0;nxtbsrc=0;
        end
        default :begin end
    endcase
end
default :begin end
endcase
end
endmodule
