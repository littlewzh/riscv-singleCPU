`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/31 17:36:56
// Design Name: 
// Module Name: RAM
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


/*module RAM(
    input clk,
    input [31:0] address,
    input [31:0] writeData, // [31:24], [23:16], [15:8], [7:0]
    //input nRD, // Ϊ 1����������Ϊ 1,�������̬
    input [2:0] memop,
    input nWR, // Ϊ 0��д��Ϊ 1���޲���
    output [31:0] Dataout
);
    //reg [7:0] ram [1023:0]; //�洢��
    reg [7:0] ram0[1023:0]; //���� 4kB �Ĵ洢��
    reg [7:0] ram1[1023:0];
    reg [7:0] ram2[1023:0];
    reg [7:0] ram3[1023:0];
    initial
    begin
        $readmemh("rv32ui-p-simple.hex0",ram0);
        $readmemh("rv32ui-p-simple.hex1",ram1);
        $readmemh("rv32ui-p-simple.hex2",ram2);
        $readmemh("rv32ui-p-simple.hex3",ram3);
    end
    // ��
    assign Dataout[7:0] = ram3[address]; 
    assign Dataout[15:8] = ram2[address];
    assign Dataout[23:16] = ram1[address];
    assign Dataout[31:24] = ram0[address];
    //д
    always@(negedge clk) 
    begin
        if( nWR==1 ) 
        begin
        case(memop)
            3'b000:begin           //�����ֽ�
              ram0[address] <= writeData[31:24];ram1[address] <= writeData[23:16];ram2[address] <= writeData[15:8];ram3[address] <= writeData[7:0];
              end
            3'b001:begin
              ram2[address] <= writeData[15:8];ram3[address] <= writeData[7:0];
              end
            3'b010:begin
              ram3[address] <= writeData[7:0];
              end
        endcase
        end
    end
endmodule*/
module RAM(
    input rdclk,
    input wrclk,
    input [31:0] addr,
    input [31:0] writeData, // [31:24], [23:16], [15:8], [7:0]
    //input nRD, // Ϊ 1����������Ϊ 1,�������̬
    input [2:0] memop,
    input we, // Ϊ 0��д��Ϊ 1���޲���
    output reg [31:0] dataout
    );
    reg [31:0] ram[1023:0]; //���� 4kB �Ĵ洢��
    //reg [7:0] ram1[1023:0];
    //reg [7:0] ram2[1023:0];
    //reg [7:0] ram3[1023:0];
/*initial begin
        $readmemh("rv32ui-p-simple.hex0", ram0);
        $readmemh("rv32ui-p-simple.hex1", ram1);
        $readmemh("rv32ui-p-simple.hex2", ram2);
        $readmemh("rv32ui-p-simple.hex3", ram3);
 end*/
always@(rdclk)
begin
   if(rdclk==1) begin            //��ȡ������ʱ�������ؽ��У���һ��ʱ�����ڵ�һ��
     case(memop)
        3'b000:begin           //������
           Dataout={{24{ram[address][7]}},ram[address][7:0]};
          end
        3'b001:begin
          Dataout={{16{ram[address][15]}},ram[address][15:0]};
          end
        3'b010:begin
          Dataout={ram[address]};
          end
        3'b100:begin           //�޷���
           Dataout={{24'b0},ram[address]};
          end
        3'b101:begin
           Dataout={{16'b0},ram[address]};
          end
     endcase
   end
end
always@(negedge wrclk)
   begin               //д��������һ��ʱ��������ʱ���в�����Ҫдʹ���ź���Ч
     if( we==1 ) 
        begin
        case(memop)
            3'b000:begin           //�����ֽ�sl
              ram[address] = writeData;
              end
            3'b001:begin          //��2�ֽ�sw
              ram[address][15:0]= writeData[15:0];
              end
            3'b010:begin                //��1�ֽ�sb
              ram[address][7:0] = writeData[7:0];
              end
        endcase
        end
   end
endmodule