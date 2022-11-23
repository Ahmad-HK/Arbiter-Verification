`ifndef TEST
`define TEST

`include "enviroment.sv"

program test(intf test_intf);
   
environment e;
    
  initial begin
    e = new(test_intf);

    e.run();
  end
endprogram
`endif