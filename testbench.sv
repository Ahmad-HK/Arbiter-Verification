`ifndef TB
`define TB
`include "test.sv"
`include "config.sv"
`include "design.sv"

`timescale 1ps/1ps

module tbench_top;

  bit clk;


  always #5 clk = ~clk; 

  intf intff(clk);

  test t1(intff);

  ArbFixedPriorityAbs #(`REQ_NUM) dut(
    .clk(intff.clk),
    .rst_n(intff.rst_n),
    .req(intff.req),

    .grant(intff.grant)
    );

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end

  initial begin
    #1000 $finish;
  end
endmodule

`endif