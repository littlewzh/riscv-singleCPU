// 这个可以根据自己的需求修改
/*module rv32is(
	input 	clock,
	input 	reset,
	output [31:0] imemaddr,			//imem的地址
	input  [31:0] imemdataout,	//imem读取到的数据
	output 	imemclk,						//imem的时钟
	output [31:0] dmemaddr,			//dmem的地址
	input  [31:0] dmemdataout,	//dmem读取到的数据
	output [31:0] dmemdatain,		//需要写入dmem的数据
	output 	dmemrdclk,					//dmem读口时钟
	output	dmemwrclk,					//dmem写口时钟
	output [2:0] dmemop,				//3'b000:sb 3'b001:sh 3'b010://sw
	output	dmemwe,							//dmem写有效
	output [31:0] dbg_pc,				//当前完成的指令的PC
	output done,								//读取到Instr为0xdead10cc时认为程序结束
	output wb										//当前周期是否有指令完成
);//add your code here



endmodule*/

`timescale 1ns / 1ps
module rv32is(
    input clk,
    input reset,
    input [31:0]  IDataOut,
    output [31:0] nextPC,
    //output [31:0] IAddr,
    output [31:0] result,
    output [2:0] memop,
    output memwr,
    output [31:0] ReadData2,
    input [31:0] DataOut,
    output imemclk,
    output dmemrdclk,
    output dmemwrclk,
    output done,
    output wb,
    output [31:0] dbg_pc
    );
    //wire PCWre;
    //wire [31:0] nextPC;
    wire [31:0] IAddr;
  
    wire [6:0] opcode;
    wire [2:0] fun3;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] fun7;
    wire [24:0] imm;
    wire [31:0] num;
    wire [2:0]extop;
    wire regwr;
    wire [2:0]branch;
    wire memtoreg;
    wire aluasrc;
    wire [1:0] alubsrc;
    wire [3:0]aluctr;
    wire [31:0] ReadData1;
    wire [31:0] DB;
    wire zero;
    wire less;
    wire [31:0] ALUA;
    wire [31:0] ALUB;
    reg waitt;
     //assign PCWre=1;
     always @(negedge clk) begin
      if(reset==1) begin waitt=0;end
      else begin
        waitt=~waitt;
      end 
      $display("IDataOut=%x",IDataOut);
      $display("pc=%x",IAddr);
      $display("nextPC=%x",nextPC);
      $display("opcode=%x",opcode);
      $display("rd=%x",rd);
      $display("rs1=%x",rs1);
      $display("rs2=%x",rs2);
      $display("num=%x",num);
      $display("DB=%x",DB);
      $display("memtoreg=%x",memtoreg);
      $display("result=%x",result);
      $display("ReadData1=%x",ReadData1);
      $display("ReadData2=%x",ReadData2);
      $display("aluctr=%x",aluctr);
      $display("alubsrc=%x",alubsrc);
      $display("aluasrc=%x",aluasrc);
      $display("zero=%x",zero);
      $display("memop=%x",memop);
    end
     
      
     assign imemclk=clk;
     assign dmemrdclk=clk;
     assign dmemwrclk=waitt?clk:1;
     assign dbg_pc=IAddr;
     assign done=(IDataOut==32'hdead10cc)?1:0;
     assign wb=~waitt;
    PC pc(clk,reset,waitt,nextPC,IAddr);
    //instructionMemory ins(clk,IAddr,IDataOut);
    
    decodeInstruction decode(IDataOut, opcode, fun3, rd, rs1,rs2,fun7,imm); //ָ������
   
    InstrToImm  immd(imm,extop,num);      //����������
    
    controlUnit control(opcode[6:2],fun3,fun7[5],extop,regwr,branch,memtoreg,memwr, memop,aluasrc,alubsrc,aluctr);//���������ź�
    RegFile regf(clk,reset,regwr,rs1,rs2,rd,DB,ReadData1,ReadData2,waitt);
    //selecterFor5bits selecter1(RegDst,rt,rd,WriteReg);
    selecterFor32bits2 selecter2(aluasrc,ReadData1,nextPC,ALUA);
    selecterFor32bits4 selecter3(alubsrc,ReadData2,num,32'd4,ALUB);
    //selecterFor32bits selecter4(DBDataSrc,result,DataOut,DB);
    
    ALU32 alu(aluctr,ALUA,ALUB,result,zero,less);              //a little problem which is not issured
    
   // RAM ram(clk,result,ReadData2, memop,memwr,DataOut);

    selecterFor32bits2 selecter4(memtoreg,result,DataOut,DB);
    PCSelecter pcselecter(clk,branch,reset,zero,less,ReadData1,num,IAddr,nextPC,waitt);//a little problem which is issured

endmodule



