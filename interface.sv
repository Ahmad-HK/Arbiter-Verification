`ifndef IF
`define IF
`include "config.sv"

interface intf(input logic clk);  
	
	
  logic [`REQ_NUM-1:0] grant;
	logic [`REQ_NUM-1:0] req;
	logic rst_n;
    
endinterface: intf

`endif

