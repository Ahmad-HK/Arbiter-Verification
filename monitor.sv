`ifndef MONITER
`define MONITER
`include "transaction.sv"
`include "interface.sv"
`include "config.sv"
class monitor;

  mailbox mon2sc,mon2ref; 
  virtual intf vif;

  function new (virtual intf vif,mailbox mon2sc,mailbox mon2ref);
    this.vif=vif;
    this.mon2sc=mon2sc;
    this.mon2ref=mon2ref;
  endfunction

  string a="you are in test class!!!!!!!!!! ";
  transaction traanns ;


  task monitorTask();

    forever @(posedge vif.clk) begin
      traanns=new(); 

      traanns.grant  	 =  vif.grant ;
      traanns.req	     =  vif.req ;
      traanns.rst_n 	 = 	vif.rst_n ;
      mon2sc.put(traanns); // actual output .
      mon2ref.put(traanns); // actual output .
       -> ev;
    end  

  endtask
endclass
`endif