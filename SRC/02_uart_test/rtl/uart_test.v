`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    uart_test 
// 
//////////////////////////////////////////////////////////////////////////////////
module uart_test(clk50, rx, tx, reset);
input clk50;
input reset;
input rx;
output tx;

wire clk;       //clock for 9600 uart port
wire [7:0] txdata,rxdata;
wire idle;
wire dataerror;
wire frameerror;

//����ʱ�ӵ�Ƶ��Ϊ16*9600��
clkdiv u0 (
		.clk50                   (clk50),                           
		.clkout                  (clk)                          
 );

uartrx u1 (
		.clk                     (clk),  
      .rx	                   (rx),  	
		.dataout                 (rxdata),              //uart ���յ�������                     
      .rdsig                   (rdsig),               //uart ���յ�������Ч 
		.dataerror               (dataerror),
		.frameerror              (frameerror)
);

uarttx u2 (
		.clk                     (clk),                           
		.datain                  (txdata),               //uart ���͵�����   
      .wrsig                   (wrsig),                //uart ���͵�������Ч  
      .idle                    (idle), 	
	   .tx                      (tx)		
 );

uartctrl u3 (
		.clk                     (clk),                           
		.rdsig                   (rdsig),                //uart ���յ�������Ч   
      .rxdata                  (rxdata), 		          //uart ���յ������� 
      .wrsig                   (wrsig),                //uart ���͵�������Ч  
      .dataout                 (txdata)	             //uart ���͵����� 
	
 );
 

endmodule

