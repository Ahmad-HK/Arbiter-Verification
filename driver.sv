`ifndef DRIVER
`define DRIVER
`include "transaction.sv"
class driver;

  mailbox gen2drive ;

  virtual intf vif ;

  function new(virtual intf vif, mailbox gen2drive);
    this.gen2drive = gen2drive;
    this.vif=vif ; 
  endfunction


  task drive(); //forever loop to drive transactions
    transaction tranns ;
    tranns = new();

    forever @(posedge vif.clk) begin
      if(gen2drive.num() > 0) begin

        gen2drive.get(tranns);

        vif.req <= tranns.req;
        vif.rst_n <= tranns.rst_n;

      end
    end
  endtask



endclass


`endif
