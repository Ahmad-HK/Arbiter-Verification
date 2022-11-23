`ifndef GEN
`define GEN
`include "transaction.sv"
`include "config.sv"

class generator;

  rand transaction trans;
  int num_of_trans=2048;
  mailbox gen2driv;
  virtual intf vif;


  function new(virtual intf vif,mailbox gen2driv);
    this.gen2driv = gen2driv;
    this.vif = vif ; 

  endfunction

  
  task generate_trans();

    repeat(num_of_trans)

      begin
        @(posedge vif.clk);

        trans = new();

        trans.randomize(); 

        gen2driv.put(trans);

      end
  endtask

endclass
`endif