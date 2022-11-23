`ifndef REF
`define REF
`include "transaction.sv"
`include "interface.sv"
`include "config.sv"

class RefMod;

  reg [`REQ_NUM-1:0] grantt;
  mailbox ref2sc,mon2ref;

  function new (mailbox ref2sc,mailbox mon2ref);
    grantt=0;
    this.ref2sc=ref2sc;
    this.mon2ref=mon2ref;
  endfunction



  function reference();
    transaction trann,trranss;
    begin   

      if(mon2ref.num()>0)begin

        trann=new();
        trranss = new();
        mon2ref.try_get(trranss);

        if (!trranss.rst_n || !trranss.req)
          grantt=0;
        else 
          begin
            for (int i = 0; i < `REQ_NUM; i++)
            begin
                if(trranss.req[i])
                begin
                    grantt = 1 << i;
                    break;
                end
            end

            trann.grant=grantt ;
          end//else
        ref2sc.try_put(trann); // Expected results .

      end//if
    end//function begin
  endfunction 
endclass
`endif