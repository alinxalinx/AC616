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

//产生时钟的频率为16*9600，
clkdiv u0 (
		.clk50                   (clk50),                           
		.clkout                  (clk)                          
 );

uartrx u1 (
		.clk                     (clk),  
      .rx	                   (rx),  	
		.dataout                 (rxdata),              //uart 接收到的数据                     
      .rdsig                   (rdsig),               //uart 接收到数据有效 
		.dataerror               (dataerror),
		.frameerror              (frameerror)
);

uarttx u2 (
		.clk                     (clk),                           
		.datain                  (txdata),               //uart 发送的数据   
      .wrsig                   (wrsig),                //uart 发送的数据有效  
      .idle                    (idle), 	
	   .tx                      (tx)		
 );

uartctrl u3 (
		.clk                     (clk),                           
		.rdsig                   (rdsig),                //uart 接收到数据有效   
      .rxdata                  (rxdata), 		          //uart 接收到的数据 
      .wrsig                   (wrsig),                //uart 发送的数据有效  
      .dataout                 (txdata)	             //uart 发送的数据 
	
 );
 

endmodule

