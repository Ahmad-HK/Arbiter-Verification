`ifndef SC
`define SC
`include "transaction.sv"
`include "interface.sv"
`include "config.sv"

class scoreBoard;

  virtual intf vif;
  mailbox mon2sc;
  mailbox ref2sc;

  transaction ActualTrans;
  transaction ExpectecTrans;

  function new(virtual intf vif,mailbox ref2sc,mailbox mon2sc);
    this.ref2sc=ref2sc;
    this.mon2sc=mon2sc;
    this.vif=vif;
  endfunction 

  task sc();

    forever @(posedge vif.clk)begin
      ActualTrans=new();
      ExpectecTrans=new();
      if(mon2sc.num()>0 && ref2sc.num() >0) begin 
        mon2sc.get(ActualTrans);

        ref2sc.get(ExpectecTrans);

        if (ActualTrans.grant !== ExpectecTrans.grant)
          $display("FAIL -> when Actual = %h ,and Expected = %h   ",ActualTrans.grant , ExpectecTrans.grant);
        else if (ActualTrans.grant === ExpectecTrans.grant)
          $display("PASS! when Actual = %h ,and Expected = %h   ",ActualTrans.grant , ExpectecTrans.grant);

      end
    end

  endtask
endclass

`endif