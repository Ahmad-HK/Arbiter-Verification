`ifndef TRANS
`define TRANS
`include "config.sv"

class transaction;

  rand bit [`REQ_NUM-1:0] req;
  rand bit rst_n;

  bit [`REQ_NUM-1:0] grant;

  constraint rand_reset_c {
    rst_n dist { 0 := 30, 1 := 70 };

  }
endclass
`endif

