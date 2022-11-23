// TODO:include the follwoing files:
// interface file
// transactions file
// driver file
// generator file
`ifndef ENV
`define ENV
`include "driver.sv"
`include "generator.sv"
`include "interface.sv"
`include "monitor.sv"
`include "scoreBoard.sv"
`include "RefMod.sv"
`include "config.sv"
class environment;

  generator gen;
  driver driv;

  virtual intf vif;

  mailbox gen2drive;
  mailbox mon2sc ; 
  mailbox ref2sc, mon2ref ;

  monitor monit ; 
  scoreBoard score;
  RefMod RM;

  function new(virtual intf vif);

    this.vif = vif ;

    gen2drive=new();
    mon2sc=new();
    ref2sc=new();
    mon2ref=new();
    
    gen 	= new(vif,gen2drive);
    driv 	= new(vif,gen2drive);
    monit	= new(vif,mon2sc,mon2ref); // for input and output .
    score	= new(vif,ref2sc,mon2sc);
    RM		= new(ref2sc,mon2ref); 
  endfunction


  task run();
     begin
        fork
          begin 
            gen.generate_trans(); 
          end
          begin 
            driv.drive();
          end
          begin
            monit.monitorTask();
          end
          begin
            score.sc();
          end
          begin
            forever
            @ev RM.reference();
          end
        join_any
      end

  endtask

endclass
`endif